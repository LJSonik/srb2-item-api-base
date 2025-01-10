freeslot("S_ITEMAPI_GFZTREE_LEAFLESS")
states[S_ITEMAPI_GFZTREE_LEAFLESS] = { SPR_ITRE, A }

freeslot("S_ITEMAPI_GFZTREE_TRUNK")
states[S_ITEMAPI_GFZTREE_TRUNK] = { SPR_ITRE, B }


itemapi.addItem("greenflower_berry_tree", {
	name = "Greenflower berry tree",
	carriable = false,

	mobjType = MT_GFZBERRYTREE,
	mobjSprite = SPR_TRE1,
	mobjFrame = B,

	groundAction = {
		name = "pick berries",
		duration = 5*TICRATE,
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
		duration = 10*TICRATE,
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
		duration = 20*TICRATE,
		animation = "shake",

		action = function(p, tree)
			if not p.itemapi_inventory:add("log", 10) then return end
			itemapi.spawnGroundItem(tree.x, tree.y, tree.z, "greenflower_tree_trunk")
			P_RemoveMobj(tree)
		end
	}
})

itemapi.addItem("greenflower_tree_trunk", {
	name = "Greenflower tree trunk",
	template = "growing_plant",

	groups = { growing_plant="leafless_greenflower_tree" },
	growthTime = 3*60*TICRATE,
	seed = "greenflower_tree_seed",

	mobjType = MT_GFZTREE,
	mobjState = S_ITEMAPI_GFZTREE_TRUNK,
	mobjSprite = SPR_ITRE,
	mobjFrame = B,

	groundAction1 = {
		name = "destroy and get seeds",
		duration = 5*TICRATE,
		animation = "shake",

		action = function(p, tree, def)
			local n = P_RandomRange(1, 2)
			if not p.itemapi_inventory:add(def.seed, n) then return end
			P_RemoveMobj(tree)
		end
	}
})

itemapi.addItem("greenflower_tree_seed", {
	name = "Greenflower tree seed",
	template = "plant_seed",
	stackable = 10,

	groups = { plant_seed="greenflower_tree_trunk" },

	mobjSprite = SPR_ITEM,
	mobjFrame = D
})
