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

itemapi.addItem("blue_berry", {
	name = "blueberry",
	template = "food",
	stackable = 4,

	nutrition = 60*TICRATE,
	eatDuration = TICRATE/2,
	foodCrumbColor = SKINCOLOR_BLUE,

	mobjSprite = SPR_IFOD,
	mobjFrame = E
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
			itemapi.spawnGroundItem(bush.x, bush.y, bush.z, "leafed_berry_bush")
			P_RemoveMobj(bush)
		end
	}
})

itemapi.addItem("leafed_berry_bush", {
	name = "leafed berry bush",
	template = "growing_plant",

	groups = { growing_plant="berry_bush" },
	growthTime = 3*60*TICRATE,
	seed = "berry_bush_seed",

	mobjType = MT_BUSH,
	mobjSprite = SPR_BUS2,
	mobjFrame = A,

	groundAction1 = {
		name = "pick leaves",
		duration = TICRATE/2,
		animation = "shake",

		action = function(p, bush)
			if not p.itemapi_inventory:add("leaves") then return end
			itemapi.spawnGroundItem(bush.x, bush.y, bush.z, "leafless_berry_bush")
			P_RemoveMobj(bush)
		end
	}
})

itemapi.addItem("leafless_berry_bush", {
	name = "leafless berry bush",
	template = "growing_plant",

	groups = { growing_plant="leafed_berry_bush" },
	growthTime = 3*60*TICRATE,
	seed = "berry_bush_seed",

	mobjSprite = SPR_ITEM,
	mobjFrame = K,

	groundAction1 = {
		name = "pick wood",
		duration = TICRATE/2,
		animation = "shake",

		action = function(p, bush)
			if not p.itemapi_inventory:add("log") then return end
			itemapi.spawnGroundItem(bush.x, bush.y, bush.z, "berry_bush_trunk")
			P_RemoveMobj(bush)
		end
	}
})

itemapi.addItem("berry_bush_trunk", {
	name = "berry bush trunk",
	template = "growing_plant",

	groups = { growing_plant="leafless_berry_bush" },
	growthTime = 3*60*TICRATE,
	seed = "berry_bush_seed",

	mobjSprite = SPR_ITEM,
	mobjFrame = J,

	groundAction1 = {
		name = "destroy and get seeds",
		duration = TICRATE/2,
		animation = "shake",

		action = function(p, bush)
			local n = P_RandomRange(1, 2)
			if not p.itemapi_inventory:add("berry_bush_seed", n) then return end
			P_RemoveMobj(bush)
		end
	}
})

itemapi.addItem("berry_bush_seed", {
	name = "berry bush seed",
	template = "plant_seed",
	stackable = 10,

	groups = { plant_seed="berry_bush_trunk" },

	mobjSprite = SPR_ITEM,
	mobjFrame = D
})
