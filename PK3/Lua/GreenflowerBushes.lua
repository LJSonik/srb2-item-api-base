itemapi.addItemTemplate("berry_bush", function(def)
	return {
		groundAction1 = {
			name = "pick berries",
			duration = TICRATE,
			animation = "shake",

			action = function(p, bush)
				if not p.itemapi_inventory:add(def.berry, 4) then return end
				itemapi.spawnGroundItem(bush.x, bush.y, bush.z, def.leafedBush)
				P_RemoveMobj(bush)
			end
		}
	}
end)

itemapi.addItemTemplate("leafed_berry_bush", function(def)
	return {
		template = "growing_plant",

		growthTime = 3*60*TICRATE,

		groundAction1 = {
			name = "pick leaves",
			duration = TICRATE/2,
			animation = "shake",

			action = function(p, bush)
				if not p.itemapi_inventory:add("leaves") then return end
				itemapi.spawnGroundItem(bush.x, bush.y, bush.z, def.leaflessBush)
				P_RemoveMobj(bush)
			end
		}
	}
end)

itemapi.addItemTemplate("leafless_berry_bush", function(def)
	return {
		template = "growing_plant",

		growthTime = 3*60*TICRATE,

		groundAction1 = {
			name = "pick wood",
			duration = TICRATE/2,
			animation = "shake",

			action = function(p, bush)
				if not p.itemapi_inventory:add("log") then return end
				itemapi.spawnGroundItem(bush.x, bush.y, bush.z, def.trunk)
				P_RemoveMobj(bush)
			end
		}
	}
end)

itemapi.addItemTemplate("berry_bush_trunk", function(def)
	return {
		template = "growing_plant",

		growthTime = 3*60*TICRATE,

		groundAction1 = {
			name = "destroy and get seeds",
			duration = TICRATE/2,
			animation = "shake",

			action = function(p, bush)
				local n = P_RandomRange(1, 2)
				if not p.itemapi_inventory:add(def.seed, n) then return end
				P_RemoveMobj(bush)
			end
		}
	}
end)


itemapi.addItem("leaves", {
	name = "leaves",
	stackable = 20,
	groups = { fuel=15*TICRATE, workbench_ingredient=true },

	mobjSprite = SPR_ITEM,
	mobjFrame = G,

	action1 = {
		name = "F***ING LEAVES",
		duration = TICRATE/4,

		animation = {
			type = "crumbs",
			sprites = "ICRU:0-2",
			color = SKINCOLOR_GREEN,
			scale = 4*FU,
			frequency = TICRATE/32
		},

		action = function(p)
			itemapi.smartUncarryItem(p)
			CONS_Printf(p, "You get rid of the f***ing leaves.")
		end
	}
})


itemapi.addItem("berry", {
	name = "berry",
	template = "food",
	stackable = 4,

	nutrition = 60*TICRATE,
	eatDuration = TICRATE/2,
	foodCrumbColor = SKINCOLOR_RED,

	mobjSprite = SPR_IFOD,
	mobjFrame = D
})

itemapi.addItem("berry_bush", {
	name = "berry bush",
	template = "berry_bush",

	berry = "berry",
	leafedBush = "leafed_berry_bush",

	mobjType = MT_BERRYBUSH,
	mobjSprite = SPR_BUS1,
	mobjFrame = A
})

itemapi.addItem("leafed_berry_bush", {
	name = "leafed berry bush",
	template = "leafed_berry_bush",

	groups = { growing_plant="berry_bush" },
	seed = "berry_bush_seed",
	leaflessBush = "leafless_berry_bush",

	mobjType = MT_BUSH,
	mobjSprite = SPR_BUS2,
	mobjFrame = A
})

itemapi.addItem("leafless_berry_bush", {
	name = "leafless berry bush",
	template = "leafless_berry_bush",

	groups = { growing_plant="leafed_berry_bush" },
	seed = "berry_bush_seed",
	trunk = "berry_bush_trunk",

	mobjSprite = SPR_ITEM,
	mobjFrame = K
})

itemapi.addItem("berry_bush_trunk", {
	name = "berry bush trunk",
	template = "berry_bush_trunk",

	groups = { growing_plant="leafless_berry_bush" },
	seed = "berry_bush_seed",

	mobjSprite = SPR_ITEM,
	mobjFrame = J
})

itemapi.addItem("berry_bush_seed", {
	name = "berry bush seed",
	template = "plant_seed",
	stackable = 10,

	groups = { plant_seed="berry_bush_trunk" },

	mobjSprite = SPR_ITEM,
	mobjFrame = D
})


itemapi.addItem("blueberry", {
	name = "blueberry",
	template = "food",
	stackable = 4,

	nutrition = 120*TICRATE,
	eatDuration = TICRATE/2,
	foodCrumbColor = SKINCOLOR_BLUE,

	mobjSprite = SPR_IFOD,
	mobjFrame = E
})

itemapi.addItem("blueberry_bush", {
	name = "blueberry bush",
	template = "berry_bush",

	berry = "blueberry",
	leafedBush = "leafed_blueberry_bush",

	mobjType = MT_BLUEBERRYBUSH,
	mobjSprite = SPR_BUS3,
	mobjFrame = A
})

itemapi.addItem("leafed_blueberry_bush", {
	name = "leafed blueberry bush",
	template = "leafed_berry_bush",

	groups = { growing_plant="blueberry_bush" },
	seed = "blueberry_bush_seed",
	leaflessBush = "leafless_blueberry_bush",

	mobjSprite = SPR_BUS2,
	mobjFrame = A
})

itemapi.addItem("leafless_blueberry_bush", {
	name = "leafless blueberry bush",
	template = "leafless_berry_bush",

	groups = { growing_plant="leafed_blueberry_bush" },
	seed = "blueberry_bush_seed",
	trunk = "blueberry_bush_trunk",

	mobjSprite = SPR_ITEM,
	mobjFrame = K
})

itemapi.addItem("blueberry_bush_trunk", {
	name = "blueberry bush trunk",
	template = "berry_bush_trunk",

	groups = { growing_plant="leafless_blueberry_bush" },
	seed = "blueberry_bush_seed",

	mobjSprite = SPR_ITEM,
	mobjFrame = J
})

itemapi.addItem("blueberry_bush_seed", {
	name = "blueberry bush seed",
	template = "plant_seed",
	stackable = 10,

	groups = { plant_seed="blueberry_bush_trunk" },

	mobjSprite = SPR_ITEM,
	mobjFrame = D
})
