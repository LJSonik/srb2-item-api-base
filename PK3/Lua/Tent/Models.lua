itemapi.addModel("tent", {
	-- Roof
	{ "splat", SPR_ITNT, A, 0, 128, 0, angle=-90, vangle=45 },
	{ "splat", SPR_ITNT, A, 0, -128, 0, angle=90, vangle=45 },

	-- Floor
	{ "splat", SPR_ITNT, A, 0, 128, 0, angle=-90, vangle=0 },
	{ "splat", SPR_ITNT, A, 0, -128, 0, angle=90, vangle=0 },

	-- Front
	{ "paper", SPR_ITNT, B, -256, 0, 0, angle=0 },

	-- Back
	{ "paper", SPR_ITNT, C, 256, 0, 0, angle=0 },
})

-- itemapi.addModel("tent_collision", {
-- 	-- Left wall
-- 	{ "paper", SPR_NULL, A, 128, 128, 0, angle=90, radius=128, height=64 },
-- 	{ "paper", SPR_NULL, A, 384, 128, 0, angle=90, radius=128, height=64 },
-- 	{ "mobj", SPR_NULL, A, 32 + 0*64, 96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 1*64, 96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 2*64, 96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 3*64, 96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 4*64, 96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 5*64, 96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 6*64, 96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 7*64, 96, 64, angle=0, radius=31, height=1 },
-- 	{ "paper", SPR_NULL, A, 128, 64, 64, angle=90, radius=128, height=64 },
-- 	{ "paper", SPR_NULL, A, 384, 64, 64, angle=90, radius=128, height=64 },

-- 	-- Roof
-- 	{ "mobj", SPR_NULL, A, 64 + 0*128, 0, 128, angle=0, radius=63, height=1 },
-- 	{ "mobj", SPR_NULL, A, 64 + 1*128, 0, 128, angle=0, radius=63, height=1 },
-- 	{ "mobj", SPR_NULL, A, 64 + 2*128, 0, 128, angle=0, radius=63, height=1 },
-- 	{ "mobj", SPR_NULL, A, 64 + 3*128, 0, 128, angle=0, radius=63, height=1 },

-- 	-- Right wall
-- 	{ "paper", SPR_NULL, A, 128, -128, 0, angle=90, radius=128, height=64 },
-- 	{ "paper", SPR_NULL, A, 384, -128, 0, angle=90, radius=128, height=64 },
-- 	{ "mobj", SPR_NULL, A, 32 + 0*64, -96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 1*64, -96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 2*64, -96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 3*64, -96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 4*64, -96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 5*64, -96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 6*64, -96, 64, angle=0, radius=31, height=1 },
-- 	{ "mobj", SPR_NULL, A, 32 + 7*64, -96, 64, angle=0, radius=31, height=1 },
-- 	{ "paper", SPR_NULL, A, 128, -64, 64, angle=90, radius=128, height=64 },
-- 	{ "paper", SPR_NULL, A, 384, -64, 64, angle=90, radius=128, height=64 },
-- })
