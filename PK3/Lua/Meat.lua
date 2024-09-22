itemapi.addItem("raw_meat", {
	name = "raw meat",

	groups = { roastable="half_roasted_meat" },
	roastDuration = 30*TICRATE,

	mobjSprite = SPR_IFOD,
	mobjFrame = A
})

itemapi.addItem("half_roasted_meat", {
	name = "half-roasted meat",

	groups = { roastable="roasted_meat" },
	roastDuration = 30*TICRATE,

	mobjSprite = SPR_IFOD,
	mobjFrame = B
})

itemapi.addItem("roasted_meat", {
	name = "roasted meat",
	template = "food",

	nutrition = 5*60*TICRATE,
	eatDuration = 5*TICRATE,
	foodCrumbColor = SKINCOLOR_YOGURT,

	mobjSprite = SPR_IFOD,
	mobjFrame = C,
})
