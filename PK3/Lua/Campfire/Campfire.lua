-- Todo:
-- Cook meat
-- Max fuel
-- Light torch
-- Extinguish
-- Prevent carrying
-- Prevent putting fuel if max?


itemapi.CAMPFIRE_MAX_FUEL = 5*60*TICRATE
local MAX_LOGS = 4


freeslot("MT_ITEMAPI_CAMPFIRE", "S_ITEMAPI_CAMPFIRE", "SPR_IFIR")

mobjinfo[MT_ITEMAPI_CAMPFIRE] = {
	spawnstate = S_ITEMAPI_CAMPFIRE,
	spawnhealth = 1,
	radius = 8*FU,
	height = 16*FU,
	flags = MF_NOGRAVITY
}

states[S_ITEMAPI_CAMPFIRE] = { SPR_NULL }


freeslot("S_ITEMAPI_CAMPFIRE_EMBER")
states[S_ITEMAPI_CAMPFIRE_EMBER] = { SPR_FLAM, FF_FULLBRIGHT|FF_ANIMATE|8, TICRATE, nil, 3, 3 }


---@param amount number
---@return integer
function itemapi.campfire_getNumLogsForFuelAmount(amount)
	return min(amount * (MAX_LOGS + 1) / itemapi.CAMPFIRE_MAX_FUEL, MAX_LOGS)
end

---@param campfire mobj_t
---@param amount number
local function setFuel(campfire, amount)
	local prevNumLogs = itemapi.campfire_getNumLogsForFuelAmount(campfire.fuel)

	campfire.fuel = amount

	local numLogs = itemapi.campfire_getNumLogsForFuelAmount(campfire.fuel)
	if numLogs ~= prevNumLogs then
		local modelID = "campfire_" .. numLogs .. "_logs"
		itemapi.setModelType(campfire.itemapi_model, modelID)
	end

	-- local numFlames = itemapi.campfire_getNumFlamesForFuelAmount(campfire.fuel)
	-- campfire.renderflags = $ & ~RF_BRIGHTMASK
	-- if numFlames > 0 then
	-- 	campfire.renderflags = $ | RF_FULLBRIGHT
	-- if campfire.fuel > 0 then
	-- 	campfire.renderflags = $ | RF_SEMIBRIGHT
	-- else
	-- 	campfire.renderflags = $ | RF_FULLBRIGHT
	-- end
end

---@param campfire mobj_t
---@param amount number
local function addFuel(campfire, amount)
	setFuel(campfire, min(max(campfire.fuel + amount, 0), itemapi.CAMPFIRE_MAX_FUEL))
end


itemapi.addItem("campfire", {
	name = "campfire",
	carriable = false,
	dimensions = { 128, 128, 128 },

	mobjType = MT_ITEMAPI_CAMPFIRE,
	mobjScale = FU/2,
	mobjSprite = SPR_ITEM,
	mobjFrame = A,

	model = "campfire_0_logs",
	modelScale = FU/2,

	spots = {
		-- Spit
		{ 0,  80, 144 },
		{ 0,   0, 144 },
		{ 0, -80, 144 },
	},

	onSpawn = function(campfire)
		campfire.fuel = 3*60*TICRATE
		campfire.flames = {}
	end,

	onDespawn = function(campfire)
		for _, flame in ipairs(campfire.flames) do
			if flame.valid then
				P_RemoveMobj(flame)
			end
		end
	end,

	-- Fuel consumption and item processing
	groundTicker1 = {
		frequency = TICRATE,
		ticker = function(campfire, deltaTime)
			setFuel(campfire, max(campfire.fuel - deltaTime, 0))

			if campfire.fuel > 0 and campfire.spitSlots then
				itemapi.campfire_updateSpit(campfire, deltaTime)
			end
		end
	},

	-- Flames
	groundTicker2 = {
		frequency = TICRATE,
		visual = true,
		ticker = function(campfire)
			itemapi.campfire_updateFlames(campfire)
		end
	},

	-- Embers
	groundTicker3 = {
		frequency = TICRATE/4,
		visual = true,

		ticker = function(campfire)
			if not P_RandomChance(FU * #campfire.flames / itemapi.CAMPFIRE_MAX_FLAMES) then return end

			local x, y = itemapi.randomPointInCircle(campfire.x, campfire.y, 48 * campfire.scale)
			local z = campfire.z + itemapi.randomFixed(0, 8*FU)
			local ember = P_SpawnMobj(x, y, z, MT_ITEMAPI_PARTICLE)
			ember.state = S_ITEMAPI_CAMPFIRE_EMBER
			ember.momz = 2*FU
		end
	},

	groundAction1 = {
		name = "refuel",
		requiredCarriedItem = "group:fuel",

		action = function(p, campfire, _, fuelDef)
			addFuel(campfire, fuelDef.groups["fuel"])
			itemapi.smartUncarryItem(p)
		end
	},

	groundAction2 = {
		name = "roast",
		requiredCarriedItem = "group:roastable",

		action = function(p, campfire, _, foodDef)
			itemapi.campfire_addItemToSpit(campfire, foodDef.index)
			itemapi.smartUncarryItem(p)
		end
	},

	groundAction3 = {
		name = "take item",
		selectSpot = true,

		action = function(p, campfire, _, _, spotIndex)
			if campfire.spitSlots then
				local itemType = itemapi.campfire_removeItemFromSpit(campfire, spotIndex)
				if itemType then
					itemapi.carryItem(p, itemType)
				end
			end
		end
	},
})


dofile "Campfire/Models.lua"
dofile "Campfire/Flames.lua"
dofile "Campfire/Spit.lua"
