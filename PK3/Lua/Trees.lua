freeslot("S_ITEMAPI_GFZTREE_LEAFLESS")
states[S_ITEMAPI_GFZTREE_LEAFLESS] = { SPR_ITRE, A }


itemapi.addItem("greenflower_berry_tree", {
	name = "Greenflower berry tree",
	carriable = false,

	mobjType = MT_GFZBERRYTREE,
	mobjSprite = SPR_TRE1,
	mobjFrame = B,

	groundAction = {
		name = "pick berries",
		duration = 3*TICRATE,
		animation = "shake",

		action = function(p, tree)
			if not p.itemapi_inventory:add("berry", 10) then return end
			itemapi.spawnGroundItem(tree.x, tree.y, tree.z, "greenflower_tree")
			P_RemoveMobj(tree)
		end
	}
})

itemapi.addItem("greenflower_tree", {
	template = "growing_plant",

	name = "Greenflower tree",
	carriable = false,

	groups = { growing_plant="greenflower_berry_tree" },
	growthTime = 3*60*TICRATE,

	mobjType = MT_GFZTREE,
	mobjSprite = SPR_TRE1,
	mobjFrame = A,

	groundAction = {
		name = "pick leaves",
		duration = 3*TICRATE,
		animation = "shake",

		action = function(p, tree)
			if not p.itemapi_inventory:add("leaves", 5) then return end
			tree.state = S_ITEMAPI_GFZTREE_LEAFLESS
		end
	}
})

itemapi.addItem("leafless_greenflower_tree", {
	template = "growing_plant",

	name = "leafless Greenflower tree",
	carriable = false,

	groups = { growing_plant="greenflower_berry_tree" },
	growthTime = 3*60*TICRATE,

	mobjType = MT_GFZTREE,
	mobjState = S_ITEMAPI_GFZTREE_LEAFLESS,
	mobjSprite = SPR_ITRE,
	mobjFrame = A,

	groundAction = {
		name = "pick wood",
		duration = 10*TICRATE,
		animation = "shake",

		action = function(p, tree)
			if not p.itemapi_inventory:add("log", 5) then return end
			P_RemoveMobj(tree)
		end
	}
})
