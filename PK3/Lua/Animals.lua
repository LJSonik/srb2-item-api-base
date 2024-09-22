itemapi.addItemTemplate("flicky", function(def)
	return {
		name = "flicky",

		action1 = {
			name = "turn into meat",
			duration = 2*TICRATE,
			animation = { type="shake" },

			action = function(p)
				itemapi.uncarryItem(p)
				itemapi.carryItem(p, "raw_meat")
			end
		}
	}
end)

itemapi.addItem("blue_bird", {
	template = "flicky",
	name = "blue bird",

	mobjSprite = SPR_FL01,
	mobjFrame = A,
	mobjType = MT_FLICKY_01
})

itemapi.addItem("rabbit", {
	template = "flicky",
	name = "rabbit",

	mobjSprite = SPR_FL02,
	mobjFrame = A,
	mobjType = MT_FLICKY_02
})

itemapi.addItem("chicken", {
	template = "flicky",
	name = "chicken",

	mobjSprite = SPR_FL03,
	mobjFrame = A,
	mobjType = MT_FLICKY_03
})

itemapi.addItem("seal", {
	template = "flicky",
	name = "seal",

	mobjSprite = SPR_FL04,
	mobjFrame = A,
	mobjType = MT_FLICKY_04
})

itemapi.addItem("pig", {
	template = "flicky",
	name = "pig",

	mobjSprite = SPR_FL05,
	mobjFrame = A,
	mobjType = MT_FLICKY_05
})

itemapi.addItem("chipmunk", {
	template = "flicky",
	name = "chipmunk",

	mobjSprite = SPR_FL06,
	mobjFrame = A,
	mobjType = MT_FLICKY_06
})

itemapi.addItem("penguin", {
	template = "flicky",
	name = "penguin",

	mobjSprite = SPR_FL07,
	mobjFrame = A,
	mobjType = MT_FLICKY_07
})

itemapi.addItem("fish", {
	template = "flicky",
	name = "fish",

	mobjSprite = SPR_FL08,
	mobjFrame = A,
	mobjType = MT_FLICKY_08
})

itemapi.addItem("ram", {
	template = "flicky",
	name = "ram",

	mobjSprite = SPR_FL09,
	mobjFrame = A,
	mobjType = MT_FLICKY_09
})

itemapi.addItem("puffin", {
	template = "flicky",
	name = "puffin",

	mobjSprite = SPR_FL10,
	mobjFrame = A,
	mobjType = MT_FLICKY_10
})

itemapi.addItem("cow", {
	template = "flicky",
	name = "cow",

	mobjSprite = SPR_FL11,
	mobjFrame = A,
	mobjType = MT_FLICKY_11
})

itemapi.addItem("rat", {
	template = "flicky",
	name = "rat",

	mobjSprite = SPR_FL12,
	mobjFrame = A,
	mobjType = MT_FLICKY_12
})

itemapi.addItem("bear", {
	template = "flicky",
	name = "bear",

	mobjSprite = SPR_FL13,
	mobjFrame = A,
	mobjType = MT_FLICKY_13
})

itemapi.addItem("dove", {
	template = "flicky",
	name = "dove",

	mobjSprite = SPR_FL14,
	mobjFrame = A,
	mobjType = MT_FLICKY_14
})

itemapi.addItem("cat", {
	template = "flicky",
	name = "cat",

	mobjSprite = SPR_FL15,
	mobjFrame = A,
	mobjType = MT_FLICKY_15
})

itemapi.addItem("canary", {
	template = "flicky",
	name = "canary",

	mobjSprite = SPR_FL16,
	mobjFrame = A,
	mobjType = MT_FLICKY_16
})

itemapi.addItem("spider", {
	template = "flicky",
	name = "spider",

	mobjSprite = SPR_FS01,
	mobjFrame = A,
	mobjType = MT_SECRETFLICKY_01
})

itemapi.addItem("bat", {
	template = "flicky",
	name = "bat",

	mobjSprite = SPR_FS02,
	mobjFrame = A,
	mobjType = MT_SECRETFLICKY_02
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
