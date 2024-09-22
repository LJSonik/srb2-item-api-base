itemapi.addItem("orange_flower", {
	template = "flower",
	name = "orange flower",
	stackable = 2,
	groups = { fuel=5*TICRATE },

	seed = "orange_flower_seed",

	mobjType = MT_GFZFLOWER1,
	mobjSprite = SPR_FWR1,
	mobjFrame = A,
})

itemapi.addItem("growing_orange_flower", {
	name = "growing orange flower",
	template = "growing_plant",

	groups = { growing_plant="orange_flower" },
	growthTime = 3*60*TICRATE,
	seed = "orange_flower_seed",

	mobjSprite = SPR_FWR3,
	mobjFrame = A
})

itemapi.addItem("orange_flower_seed", {
	name = "orange flower seed",
	template = "plant_seed",
	stackable = 10,

	groups = { plant_seed="growing_orange_flower" },

	mobjSprite = SPR_ITEM,
	mobjFrame = E
})
