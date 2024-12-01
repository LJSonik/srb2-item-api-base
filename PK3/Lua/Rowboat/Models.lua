itemapi.addModel("rowboat", {
	-- Sides
	{ "paper", SPR_IBOA, E, -96,   0, 0, angle=180, sy=FU/2 },
	{ "paper", SPR_IBOA, F, -16,  64, 0, angle= 90, sy=FU/2 },
	{ "paper", SPR_IBOA, F, -16, -64, 0, angle=-90, sy=FU/2, flip=true },
	{ "paper", SPR_IBOA, G,  90,  54, 0, angle= 69, sy=FU/2 },
	{ "paper", SPR_IBOA, G,  90, -54, 0, angle=-69, sy=FU/2, flip=true },
	{ "paper", SPR_IBOA, H, 138,  22, 0, angle= 45, sy=FU/2 },
	{ "paper", SPR_IBOA, H, 138, -22, 0, angle=-45, sy=FU/2, flip=true },

	-- Bottom
	{ "splat", SPR_IBOA, I, -96, 0, 12, angle=0, vangle=-14 },
	{ "splat", SPR_IBOA, J, -64, 0, 4, angle=0, vangle=-7 },
	{ "splat", SPR_IBOA, K, -32, 0, 0, angle=0, vangle=0 },
	{ "splat", SPR_IBOA, L, 64, 0, 0, angle=0, vangle=9 },
	{ "splat", SPR_IBOA, M, 108, 0, 5, angle=0, vangle=20 },

	-- Floor
	{ "splat", SPR_IBOA, B, 32, 0, 24, angle=0, vangle=0 },

	-- Benches
	{ "splat", SPR_IBOA, C, 32, 0, 48, angle=0, vangle=0 },
	{ "splat", SPR_IBOA, C, -32, 0, 48, angle=0, vangle=0 },

	-- Front
	{ "paper", SPR_IBOA, D, 160, 0, 0, angle=90 },
})
