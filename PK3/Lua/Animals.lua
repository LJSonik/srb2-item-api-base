itemapi.addItem("blue_bird", {
	name = "blue bird",

	mobjSprite = SPR_FL01,
	mobjFrame = A,
	mobjType = MT_FLICKY_01,

	action1 = {
		name = "turn into meat",
		duration = 2*TICRATE,
		action = function(p)
			itemapi.uncarryItem(p)
			itemapi.carryItem(p, "raw_meat")
		end
	}
})

itemapi.addItem("raw_meat", {
	name = "raw meat",

	groups = { roastable="half_roasted_meat" },
	roastDuration = 5*TICRATE,

	mobjSprite = SPR_IFOD,
	mobjFrame = A
})

itemapi.addItem("half_roasted_meat", {
	name = "half-roasted meat",

	groups = { roastable="roasted_meat" },
	roastDuration = 5*TICRATE,

	mobjSprite = SPR_IFOD,
	mobjFrame = B
})

itemapi.addItem("roasted_meat", {
	name = "roasted meat",
	template = "food",

	nutrition = 5*60*TICRATE,
	eatDuration = 3*TICRATE,
	foodCrumbColor = SKINCOLOR_YOGURT,

	mobjSprite = SPR_IFOD,
	mobjFrame = C,
})
