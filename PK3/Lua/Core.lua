freeslot("SPR_ITEM", "SPR_IFOD", "SPR_ITRE")


-- itemapi.addItem("rollout_rock", {
-- 	name = "rollout rock",

-- 	mobjType = MT_ROLLOUTROCK,
-- 	mobjSprite = SPR_PUMI,
-- 	mobjFrame = A,
-- })

itemapi.addItem("oil_lamp", {
	name = "oil lamp",

	mobjType = MT_OILLAMP,
	mobjSprite = SPR_OILL,
	mobjFrame = A,
})

---@param mobj mobj_t
---@param id itemapi.ItemType
---@return mobj_t
function itemapi.replaceGroundItem(mobj, id)
	local newMobj = itemapi.spawnGroundItem(mobj.x, mobj.y, mobj.z, id)
	newMobj.itemapi_data = mobj.itemapi_data

	P_RemoveMobj(mobj)

	return newMobj
end
