itemapi.addItem("greenflower_tree", {
	name = "Greenflower tree",
	carriable = false,

	mobjSprite = SPR_TRE1,
	mobjFrame = A,
})

freeslot("S_ITEMAPI_GFZTREE_LEAFLESS")
states[S_ITEMAPI_GFZTREE_LEAFLESS] = { SPR_ITRE, A }

-- freeslot("S_ITEMAPI_GFZTREE_TRUNK")
-- states[S_ITEMAPI_GFZTREE_TRUNK] = { SPR_ITRE, A }

-- itemapi.addMobjAction(MT_BERRYBUSH, {
-- 	name = "pick berries",

-- 	action = function(p, tree)
-- 		if not p.itemapi_inventory:add("berry", 4) then return end
-- 		P_SpawnMobj(tree.x, tree.y, tree.z, MT_BUSH)
-- 		P_RemoveMobj(tree)
-- 	end
-- })

itemapi.addMobjAction(MT_GFZTREE, {
	name = "pick leaves",
	duration = 3*TICRATE,
	animation = "shake",

	action = function(p, tree)
		if not p.itemapi_inventory:add("leaves", 30) then return end
		tree.state = S_ITEMAPI_GFZTREE_LEAFLESS
	end
})
