freeslot("S_ITEMAPI_GFZTREE_LEAFLESS")
states[S_ITEMAPI_GFZTREE_LEAFLESS] = { SPR_ITRE, A }

freeslot("S_ITEMAPI_GFZTREE_TRUNK")
states[S_ITEMAPI_GFZTREE_TRUNK] = { SPR_ITRE, B }


itemapi.addItem("red_apple", {
	name = "red apple",
	template = "food",
	stackable = 2,

	nutrition = 180*TICRATE,
	eatDuration = 2*TICRATE,
	foodCrumbColor = SKINCOLOR_RED,

	mobjSprite = SPR_IFOD,
	mobjFrame = F,

	extraAction = {
		name = "try to get seed",
		duration = 3*TICRATE,

		animations = {
			{
				type = "crumbs",
				sprites = "ICRU:0-2",
				color = SKINCOLOR_RED,
				scale = FU,
				frequency = TICRATE/16
			},
			{ type="shake" },
		},

		action = function(p)
			if not p.itemapi_inventory:canAdd("greenflower_red_apple_tree_seed") then return end
			if P_RandomChance(FU/5) then
				p.itemapi_inventory:add("greenflower_red_apple_tree_seed")
			end
			itemapi.smartUncarryItem(p)
		end
	}
})

itemapi.addItem("greenflower_red_apple_tree", {
	name = "Greenflower red apple tree",
	carriable = false,

	mobjType = MT_GFZBERRYTREE,
	mobjSprite = SPR_TRE1,
	mobjFrame = B,

	groundAction = {
		name = "pick apples",
		duration = 5*TICRATE,
		animation = "shake",

		actionV2 = function(action, tree, actors)
			if not itemapi.giveItemStackToMultiplePlayers(actors, "red_apple", 5) then return end
			itemapi.replaceGroundItem(tree, "greenflower_tree")
		end
	}
})

itemapi.addItem("greenflower_tree", {
	template = "growing_plant",

	name = "Greenflower red apple tree",
	carriable = false,

	groups = { growing_plant="greenflower_red_apple_tree" },
	growthTime = 5*60*TICRATE,

	mobjType = MT_GFZTREE,
	mobjSprite = SPR_TRE1,
	mobjFrame = A,

	groundAction = {
		name = "pick leaves",
		duration = 10*TICRATE,
		animation = "shake",

		actionV2 = function(action, tree, actors)
			if not itemapi.giveItemStackToMultiplePlayers(actors, "leaves", 5) then return end
			tree.state = S_ITEMAPI_GFZTREE_LEAFLESS
		end
	}
})

itemapi.addItem("leafless_greenflower_red_apple_tree", {
	template = "growing_plant",

	name = "leafless Greenflower red apple tree",
	carriable = false,

	groups = { growing_plant="greenflower_red_apple_tree" },
	growthTime = 5*60*TICRATE,

	mobjType = MT_GFZTREE,
	mobjState = S_ITEMAPI_GFZTREE_LEAFLESS,
	mobjSprite = SPR_ITRE,
	mobjFrame = A,

	groundAction = {
		name = "pick wood",
		duration = 20*TICRATE,
		animation = "shake",

		actionV2 = function(action, tree, actors)
			if not itemapi.giveItemStackToMultiplePlayers(actors, "log", 10) then return end
			itemapi.replaceGroundItem(tree, "greenflower_red_apple_tree_trunk")
		end
	}
})

itemapi.addItem("greenflower_red_apple_tree_trunk", {
	name = "Greenflower red apple tree trunk",
	template = "growing_plant",

	groups = { growing_plant="leafless_greenflower_red_apple_tree" },
	growthTime = 5*60*TICRATE,
	seed = "greenflower_red_apple_tree_seed",

	mobjType = MT_GFZTREE,
	mobjState = S_ITEMAPI_GFZTREE_TRUNK,
	mobjSprite = SPR_ITRE,
	mobjFrame = B,

	groundAction1 = {
		name = "destroy and get seeds",
		duration = 5*TICRATE,
		animation = "shake",

		action = function(p, tree, def)
			if not p.itemapi_inventory:add(def.seed) then return end
			P_RemoveMobj(tree)
		end
	}
})

itemapi.addItem("greenflower_red_apple_tree_seed", {
	name = "Greenflower red apple tree seed",
	template = "plant_seed",
	stackable = 10,

	groups = { plant_seed="greenflower_red_apple_tree_trunk" },

	mobjSprite = SPR_ITEM,
	mobjFrame = D
})
