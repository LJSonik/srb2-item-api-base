freeslot("MT_ITEMAPI_LOG", "S_ITEMAPI_LOG", "SPR_ILOG")

mobjinfo[MT_ITEMAPI_LOG] = {
	spawnstate = S_ITEMAPI_LOG,
	spawnhealth = 1,
	radius = 32*FU,
	height = 32*FU,
	flags = MF_SOLID|MF_SCENERY
}

states[S_ITEMAPI_LOG] = { SPR_NULL }

itemapi.addModel("log", {
	{ "splat", SPR_ILOG, A, -16,   0,  0, angle=0, vangle=0 },
	{ "splat", SPR_ILOG, A, -16,   0, 32, angle=0, vangle=0 },
	{ "paper", SPR_ILOG, A,  16,   0,  0, angle=0 },
	{ "paper", SPR_ILOG, A, -16,   0,  0, angle=0 },
	{ "paper", SPR_ILOG, A,   0,  64,  0, angle=90, sx=FU/4 },
	{ "paper", SPR_ILOG, A,   0, -64,  0, angle=90, sx=FU/4 },
})

itemapi.addItem("log", {
	name = "log",
	stackable = 2,
	groups = { fuel=60*TICRATE },

	mobjType = MT_ITEMAPI_LOG,
	mobjScale = FU/2,
	mobjSprite = SPR_ITEM,
	mobjFrame = A,

	model = "log",
	modelScale = FU/2,

	action1 = {
		name = "admire",
		action = function(p)
			CONS_Printf(p, "WOA!! u gota... log!!!")
		end
	},
})
