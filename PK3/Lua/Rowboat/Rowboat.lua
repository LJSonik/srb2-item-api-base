---@class ItemAPI.Boat : mobj_t
---@field passengers mobj_t[]
---@field turnSpeed angle_t


freeslot("MT_ITEMAPI_ROWBOAT", "S_ITEMAPI_ROWBOAT", "SPR_IBOA")

mobjinfo[MT_ITEMAPI_ROWBOAT] = {
	spawnstate = S_ITEMAPI_ROWBOAT,
	spawnhealth = 1,
	radius = 64*FU,
	height = 24*FU,
	flags = MF_SPECIAL|MF_NOGRAVITY|MF_SLIDEME
}

states[S_ITEMAPI_ROWBOAT] = { SPR_NULL }


---@param boat ItemAPI.Boat
local function updateFloating(boat)
	local wantedLowerHeight = boat.height / 4
	local z = boat.z + wantedLowerHeight
	local waterZ = boat.watertop

	if z < waterZ then
		local floatSpeed = FU/8
		local wantedUpperHeight = boat.height - wantedLowerHeight
		local submersionRatio = min(FixedDiv(waterZ - z, wantedUpperHeight), FU)
		local momZ = boat.momz

		-- Water drag
		if momZ < 0 then
			momZ = $ * 3/4
		end

		-- Push upwards
		momZ = $ + FixedMul(submersionRatio, floatSpeed)

		boat.momz = momZ
	else
		boat.momz = $ - gravity
	end
end

---@param boat ItemAPI.Boat
local function updateMovement(boat)
	if boat.turnSpeed ~= 0 then
		boat.angle = $ + boat.turnSpeed

		-- Rotate passengers along with the boat
		local itemDef = itemapi.getItemDefFromMobj(boat)
		for seatIndex = 1, #itemDef.spots do
			local mo = boat.passengers[seatIndex]
			if mo then
				mo.angle = $ + boat.turnSpeed
			end
		end
	end

	-- Water drag
	local speed = R_PointToDist2(0, 0, boat.momx, boat.momy)
	if speed > 0 then
		local dec = FU/32
		local newSpeed = max(speed - dec, 0)
		boat.momx = FixedMul($, FixedDiv(newSpeed, speed))
		boat.momy = FixedMul($, FixedDiv(newSpeed, speed))
	end

	-- Water drag
	boat.turnSpeed = FixedMul($, FU*255/256)
end

---@param boat ItemAPI.Boat
local function updatePassengers(boat)
	local itemDef = itemapi.getItemDefFromMobj(boat)

	for seatIndex = 1, #itemDef.spots do
		local mo = boat.passengers[seatIndex]
		if not mo then continue end

		local x, y, z = itemapi.getGroundItemSpotPosition(boat, seatIndex)
		P_MoveOrigin(mo, x, y, z)

		mo.momx, mo.momy, mo.momz = 0, 0, 0

		mo.sprite = SPR_PLAY
		mo.sprite2 = SPR2_STND
		mo.frame = A

		-- Unmount if jumping
		local cmd = mo.player.cmd
		if cmd.buttons & BT_JUMP then
			itemapi.boat_unmountPlayer(boat, mo.player)
			mo.momx, mo.momy, mo.momz = boat.momx, boat.momy, boat.momz
			P_DoJump(mo.player)
		end
	end
end

---@param boat ItemAPI.Boat
local function updateDriving(boat)
	local driver = boat.passengers[1] or boat.passengers[2]
	if not driver then return end

	local cmd = driver.player.cmd

	local maxTurnAcc = 16*FU
	local turnAcc = maxTurnAcc * cmd.sidemove / -50

	local maxTurnSpeed = 1024*FU
	if abs(boat.turnSpeed) < maxTurnSpeed then
		boat.turnSpeed = itemapi.minMax(boat.turnSpeed + turnAcc, -maxTurnSpeed, maxTurnSpeed)
	end

	local maxAcc = FU/8
	local acc = maxAcc * cmd.forwardmove / 50

	local momx, momy = itemapi.rotatePointAroundPivot(boat.momx, boat.momy, 0, 0, -boat.angle)

	-- Acceleration
	local maxSpeed = 48*FU
	if abs(momx) < maxSpeed then
		momx = itemapi.minMax(momx + acc, -maxSpeed, maxSpeed)
	end

	boat.momx, boat.momy = itemapi.rotatePointAroundPivot(momx, momy, 0, 0, boat.angle)
end

---@param boat ItemAPI.Boat
---@param seatIndex integer
---@param player player_t
function itemapi.boat_mountPlayer(boat, seatIndex, player)
	boat.passengers[seatIndex] = player.mo
	P_ResetPlayer(player)
end

---@param boat ItemAPI.Boat
---@param player player_t
function itemapi.boat_unmountPlayer(boat, player)
	local itemDef = itemapi.getItemDefFromMobj(boat)

	for i = 1, #itemDef.spots do
		if boat.passengers[i] == player.mo then
			boat.passengers[i] = nil
			return
		end
	end
end


itemapi.addItem("rowboat", {
	name = "boat",
	storable = false,

	mobjType = MT_ITEMAPI_ROWBOAT,
	mobjSprite = SPR_ITEM,
	mobjFrame = A,

	model = "rowboat",

	spots = {
		{  32,  24, 48 },
		{  32, -24, 48 },
		{ -32,  24, 48 },
		{ -32, -24, 48 },
	},

	---@param boat ItemAPI.Boat
	onSpawn = function(boat)
		boat.passengers = {}
		boat.turnSpeed = 0
	end,

	groundTicker1 = {
		frequency = 1,
		---@param boat ItemAPI.Boat
		ticker = function(boat)
			updateFloating(boat)
			updateMovement(boat)
			updatePassengers(boat)
			updateDriving(boat)
		end
	}
})


---@param boat ItemAPI.Boat
---@param toucher mobj_t
addHook("TouchSpecial", function(boat, toucher)
	-- Don't mount if jumping
	if toucher.momz > boat.momz then return true end

	local seatIndex = itemapi.findClosestGroundItemSpotIndex(boat, toucher.x, toucher.y, toucher.z)
	if not boat.passengers[seatIndex] then
		itemapi.boat_mountPlayer(boat, seatIndex, toucher.player)
	end

	return true
end, MT_ITEMAPI_ROWBOAT)


itemapi.addCraftingRecipe(nil, {
	item = "rowboat",
	ingredients = { { "log", 10 } }
})


dofile "Rowboat/Models.lua"
