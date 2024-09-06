itemapi.addModel("campfire_base", {
	-- Ash
	{ "splat", SPR_IFIR, D, 0, 0, 0, angle=0, sx=FU*7/4, sy=FU*7/4 },

	-- Rocks
	{ "mobj", SPR_IFIR, C, angleFromCenter=0, distFromCenter=128, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=30, distFromCenter=120, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=62, distFromCenter=128, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=88, distFromCenter=120, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=129, distFromCenter=126, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=152, distFromCenter=120, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=180, distFromCenter=116, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=211, distFromCenter=128, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=242, distFromCenter=126, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=270, distFromCenter=120, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=297, distFromCenter=124, angle=0, sx=FU*3/2, sy=FU*3/2 },
	{ "mobj", SPR_IFIR, C, angleFromCenter=329, distFromCenter=120, angle=0, sx=FU*3/2, sy=FU*3/2 },
})

itemapi.addModel("campfire_log1", {
	{ "model", "log", -40, 16, 0, rotation=-15, scale=FU*16/16 }
})

itemapi.addModel("campfire_log2", {
	{ "model", "log", 32, 0, 0, rotation=5, scale=FU*16/16 }
})

itemapi.addModel("campfire_log3", {
	{ "model", "log", 8, 24, 32, rotation=75, scale=FU*16/16 }
})

itemapi.addModel("campfire_log4", {
	{ "model", "log", -16, -24, 32, rotation=85, scale=FU*16/16 }
})


itemapi.addModel("campfire_0_logs", {
	{ "model", "campfire_base" },
})

itemapi.addModel("campfire_1_logs", {
	{ "model", "campfire_base" },
	{ "model", "campfire_log1" },
})

itemapi.addModel("campfire_2_logs", {
	{ "model", "campfire_base" },
	{ "model", "campfire_log1" },
	{ "model", "campfire_log2" },
})

itemapi.addModel("campfire_3_logs", {
	{ "model", "campfire_base" },
	{ "model", "campfire_log1" },
	{ "model", "campfire_log2" },
	{ "model", "campfire_log3" },
})

itemapi.addModel("campfire_4_logs", {
	{ "model", "campfire_base" },
	{ "model", "campfire_log1" },
	{ "model", "campfire_log2" },
	{ "model", "campfire_log3" },
	{ "model", "campfire_log4" },
})

itemapi.addModel("campfire_spit", {
	{ "paper", SPR_IFIR, E, 0, 72, 0, angle=82 },
	{ "paper", SPR_IFIR, E, 0, -72, 0, angle=97 },
	{ "paper", SPR_IFIR, F, 0, 0, 72, angle=0 },
})
