freeslot("MT_ITEMAPI_CHEST", "S_ITEMAPI_CHEST", "SPR_ICHE")

mobjinfo[MT_ITEMAPI_CHEST] = {
	spawnstate = S_ITEMAPI_CHEST,
	spawnhealth = 1,
	radius = 32*FU,
	height = 48*FU,
	flags = MF_SOLID|MF_SCENERY
}

states[S_ITEMAPI_CHEST] = { SPR_NULL }

itemapi.addModel("chest", {
	{ "splat", SPR_ICHE, D, -24, 0, 48, angle=0, vangle=0 }, -- Top
	{ "splat", SPR_ICHE, D, -24, 0,  0, angle=0, vangle=0 }, -- Bottom
	{ "paper", SPR_ICHE, A, -24, 0, 0, angle=0 }, -- Front
	{ "paper", SPR_ICHE, B, 24, 0, 0, angle=0 }, -- Back
	{ "paper", SPR_ICHE, C, 0, -48, 0, angle=90 }, -- Side
	{ "paper", SPR_ICHE, C, 0, 48, 0, angle=90 }, -- Side
})

itemapi.addItem("chest", {
	name = "chest",
	storable = false,

	mobjType = MT_ITEMAPI_CHEST,
	mobjSprite = SPR_ITEM,
	mobjFrame = A,

	model = "chest",

	onPlace = function(chest)
		chest.itemapi_data = $ or {
			inventory = itemapi.Inventory(16, 4)
		}
	end,

	groundAction1 = {
		name = "open",

		action = function(p, chest)
			itemapi.openContainer(p, chest.itemapi_data.inventory)
		end
	},

	groundAction2 = {
		name = "store",
		requiredCarriedItem = "any",

		action = function(p, chest)
			local itemType = itemapi.getMainCarriedItemType(p)
			if chest.itemapi_data.inventory:add(itemType) then
				itemapi.smartUncarryItem(p)
			end
		end
	},
})


itemapi.addCraftingRecipe(nil, {
	item = "chest",
	location = "workbench",
	ingredients = { { "log", 10 } }
})
