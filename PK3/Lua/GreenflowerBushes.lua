itemapi.addItem("berry", {
	name = "berry",
	template = "food",
	stackable = 4,

	nutrition = 60*TICRATE,
	eatDuration = TICRATE/2,

	mobjSprite = SPR_IFOD,
	mobjFrame = D
})

itemapi.addItem("blue_berry", {
	name = "blueberry",
	template = "food",
	stackable = 4,

	nutrition = 60*TICRATE,
	eatDuration = TICRATE/2,

	mobjSprite = SPR_IFOD,
	mobjFrame = D
})

itemapi.addItem("leaves", {
	name = "leaves",
	stackable = 8,

	mobjSprite = SPR_ITEM,
	mobjFrame = G,

	action1 = {
		name = "admire",
		action = function(p)
			CONS_Printf(p, "WOA!! u gota... leaves!!!")
		end
	}
})

itemapi.addItem("berry_bush", {
	name = "berry bush",

	mobjType = MT_BERRYBUSH,
	mobjSprite = SPR_BUS1,
	mobjFrame = A,

	groundAction1 = {
		name = "pick berries",
		duration = TICRATE,
		animation = "shake",

		action = function(p, bush)
			if not p.itemapi_inventory:add("berry", 4) then return end
			itemapi.spawnGroundItem(bush.x, bush.y, bush.z, "bush")
			P_RemoveMobj(bush)
		end
	}
})

itemapi.addItem("bush", {
	name = "bush",
	template = "growing_plant",

	groups = { growing_plant="berry_bush" },
	growthTime = 3*60*TICRATE,
	seed = "bush_seed",

	mobjType = MT_BUSH,
	mobjSprite = SPR_BUS2,
	mobjFrame = A,

	groundAction1 = {
		name = "pick leaves",
		duration = TICRATE/2,
		animation = "shake",

		action = function(p, bush)
			if not p.itemapi_inventory:add("leaves") then return end
			itemapi.spawnGroundItem(bush.x, bush.y, bush.z, "leafless_bush")
			P_RemoveMobj(bush)
		end
	}
})

itemapi.addItem("leafless_bush", {
	name = "leafless bush",
	template = "growing_plant",

	groups = { growing_plant="bush" },
	growthTime = 3*60*TICRATE,
	seed = "bush_seed",

	mobjSprite = SPR_ITEM,
	mobjFrame = K,

	groundAction1 = {
		name = "pick wood",
		duration = TICRATE/2,
		animation = "shake",

		action = function(p, bush)
			if not p.itemapi_inventory:add("log") then return end
			itemapi.spawnGroundItem(bush.x, bush.y, bush.z, "bush_trunk")
			P_RemoveMobj(bush)
		end
	}
})

itemapi.addItem("bush_trunk", {
	name = "bush trunk",
	template = "growing_plant",

	groups = { growing_plant="leafless_bush" },
	growthTime = 3*60*TICRATE,
	seed = "bush_seed",

	mobjSprite = SPR_ITEM,
	mobjFrame = J,

	groundAction1 = {
		name = "destroy and get seeds",
		duration = TICRATE/2,
		animation = "shake",

		action = function(p, bush)
			local n = P_RandomRange(1, 2)
			if not p.itemapi_inventory:add("bush_seed", n) then return end
			P_RemoveMobj(bush)
		end
	}
})

itemapi.addItem("bush_seed", {
	name = "bush seed",
	template = "plant_seed",
	stackable = 10,

	groups = { plant_seed="bush_trunk" },

	mobjSprite = SPR_ITEM,
	mobjFrame = D
})
