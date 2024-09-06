mobjinfo[MT_ITEMAPI_TENT_SENSOR] = {
	spawnstate = S_ITEMAPI_TENT_SENSOR,
	spawnhealth = 1,
	radius = 63*FU, -- One less to prevent sensors from touching each other
	height = 128*FU,
	flags = MF_SPECIAL|MF_NOCLIPHEIGHT|MF_SCENERY|MF_NOGRAVITY
}

states[S_ITEMAPI_TENT_SENSOR] = {}


---@param tent mobj_t
---@param x fixed_t
---@param y fixed_t
---@return fixed_t
local function getRoofZAt(tent, x, y)
	x, y = x - tent.x, y - tent.y
	x, y = itemapi.rotatePointAroundPivot(x, y, 0, 0, -tent.angle)
	return tent.z + 128 * tent.scale - abs(y)
end

-- !!! WARNING! HORRIBLE HACK AHEAD!!!
local postCollisionCallbacks = {}
addHook("PostThinkFrame", function()
	for _, callback in ipairs(postCollisionCallbacks) do
		callback()
	end
	postCollisionCallbacks = {}
end)

---@param mo mobj_t
---@param tent mobj_t
---@param roofZ fixed_t
---@param fromAbove boolean
local function bounceOffRoof(mo, tent, roofZ, fromAbove)
	local speed = R_PointToDist2(0, 0, mo.momx, mo.momy) / 4
	speed = max($, 4*FU)

	local dstX, dstY = mo.x + mo.momx, mo.y + mo.momy

	local relX, relY = dstX - tent.x, dstY - tent.y
	relX, relY = itemapi.rotatePointAroundPivot(relX, relY, 0, 0, -tent.angle)

	local vertically = (not fromAbove and abs(relY) < 32 * tent.scale)
	if vertically then
		P_InstaThrust(mo, 0, 0)
		mo.momz = -speed
	else
		local dir = ANGLE_90 * (((relY > 0) == fromAbove) and 1 or -1)
		local zDir = ANGLE_45 * (fromAbove and 1 or -1)
		P_InstaThrust(mo, tent.angle + dir, speed)
		mo.momz = FixedMul(speed, sin(zDir))
	end

	local newX, newY, newZ = dstX + mo.momx, dstY + mo.momy, tent.z + roofZ + mo.momz
	if not fromAbove then
		newZ = newZ - mo.height
	end

	mo.hitTentRoof = true

	table.insert(postCollisionCallbacks, function()
		if mo.valid then
			P_SetOrigin(mo, newX, newY, newZ)
			mo.hitTentRoof = nil
		end
	end)
end

---@param sensor mobj_t
---@param mo mobj_t
addHook("MobjCollide", function(sensor, mo)
	if mo.type ~= MT_PLAYER or mo.hitTentRoof then return end

	local tent = sensor.target
	local dstX, dstY = mo.x + mo.momx, mo.y + mo.momy

	local oldRoofZ = getRoofZAt(tent, mo.x, mo.y) - tent.z
	local roofZ = getRoofZAt(tent, dstX, dstY) - tent.z

	local bottom = mo.z - tent.z
	local top = bottom + mo.height
	local middle = (bottom + top) / 2
	local oldMiddle = middle - mo.momz

	local oldFromAbove = (oldMiddle > oldRoofZ)
	local fromAbove = (middle > roofZ)

	local touching = (top > roofZ and roofZ > bottom)
	local traversed = (oldFromAbove ~= fromAbove)
	if touching or traversed then
		bounceOffRoof(mo, tent, roofZ, oldFromAbove)
	end
end, MT_ITEMAPI_TENT_SENSOR)

addHook("TouchSpecial", function()
	return true
end, MT_ITEMAPI_TENT_SENSOR)
