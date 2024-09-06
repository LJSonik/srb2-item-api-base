freeslot("MT_ITEMAPI_CAMPFIRE_SPITITEM", "S_ITEMAPI_CAMPFIRE_SPITITEM")

mobjinfo[MT_ITEMAPI_CAMPFIRE_SPITITEM] = {
	spawnstate = S_ITEMAPI_CAMPFIRE_SPITITEM,
	spawnhealth = 1,
	radius = 8*FU,
	height = 16*FU,
	flags = MF_NOBLOCKMAP|MF_NOCLIP|MF_NOCLIPHEIGHT|MF_SCENERY|MF_NOGRAVITY
}

states[S_ITEMAPI_CAMPFIRE_SPITITEM] = {}


---@param fire mobj_t
function itemapi.campfire_setUpSpit(fire)
	fire.spitModel = itemapi.spawnModelOnMobj(fire, "campfire_spit")
	itemapi.setModelTransform(fire.spitModel, fire.x, fire.y, fire.z, nil, 2 * fire.scale)
	fire.spitSlots = {}
end

---@param fire mobj_t
---@return itemapi.ItemType?
local function getUnusedSpitSlot(fire)
	for _, i in ipairs{ 2, 1, 3 } do
		if not fire.spitSlots[i] then
			return i
		end
	end

	return nil
end

---@param fire mobj_t
---@return integer
local function getUsedSpitSlot(fire)
	for i = 1, 3 do
		local slot = fire.spitSlots[i]
		if slot then
			local itemDef = itemapi.itemDefs[slot.itemType]
			if not itemDef.groups["roastable"] or slot.progress >= itemDef.roastDuration then
				return i
			end
		end
	end

	for i = 1, 3 do
		if fire.spitSlots[i] then
			return i
		end
	end

	return nil
end

---@param fire mobj_t
---@param itemType itemapi.ItemType
function itemapi.campfire_addItemToSpit(fire, itemType)
	local def = itemapi.itemDefs[itemType]

	if not fire.spitSlots then
		itemapi.campfire_setUpSpit(fire)
	end

	local slotIndex = getUnusedSpitSlot(fire)
	if not slotIndex then return end

	local x, y, z = itemapi.getGroundItemSpotPosition(fire, slotIndex)
	z = z - 16*FU / 2

	local mo = P_SpawnMobj(x, y, z, MT_ITEMAPI_CAMPFIRE_SPITITEM)
	mo.sprite = def.mobjSprite
	mo.frame = def.mobjFrame

	fire.spitSlots[slotIndex] = {
		itemType = itemType,
		progress = 0,
		mobj = mo
	}
end

---@param fire mobj_t
---@param slotIndex integer
---@return itemapi.ItemType?
function itemapi.campfire_removeItemFromSpit(fire, slotIndex)
	local slot = fire.spitSlots[slotIndex]
	if not slot then return end

	P_RemoveMobj(slot.mobj)
	fire.spitSlots[slotIndex] = nil

	return slot.itemType
end

---@param fire mobj_t
function itemapi.campfire_updateSpit(fire, deltaTime)
	for i = 1, 3 do
		local slot = fire.spitSlots[i]
		if not slot then continue end

		local itemDef = itemapi.itemDefs[slot.itemType]
		if itemDef.roastDuration == nil then continue end

		slot.progress = min($ + deltaTime, itemDef.roastDuration)
		if slot.progress == itemDef.roastDuration then
			local roastedDef = itemapi.itemDefs[itemDef.groups["roastable"]]

			slot.itemType = roastedDef.index
			slot.progress = 0

			slot.mobj.sprite = roastedDef.mobjSprite
			slot.mobj.frame = roastedDef.mobjFrame
		end
	end
end
