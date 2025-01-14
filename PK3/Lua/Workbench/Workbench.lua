freeslot("SPR_IWOR")


freeslot("MT_ITEMAPI_WORKBENCHINGREDIENT", "S_WORKBENCHINGREDIENT")

mobjinfo[MT_ITEMAPI_WORKBENCHINGREDIENT] = {
	spawnstate = S_WORKBENCHINGREDIENT,
	spawnhealth = 1,
	radius = 8*FU,
	height = 16*FU,
	flags = MF_NOBLOCKMAP|MF_NOCLIP|MF_NOCLIPHEIGHT|MF_SCENERY|MF_NOGRAVITY
}

states[S_WORKBENCHINGREDIENT] = { SPR_NULL }


---@param wb mobj_t
---@param ingredientType itemapi.ItemType
---@return integer
function itemapi.workbench_countIngredientType(wb, ingredientType)
	if type(ingredientType) == "string" then
		ingredientType = itemapi.itemDefs[ingredientType].index
	end

	local n = 0

	for i = 1, #wb.ingredients do
		if wb.ingredients[i].type == ingredientType then
			n = n + wb.ingredients[i].quantity
		end
	end

	return n
end

---@param wb mobj_t
---@param recipeType integer|string
---@return boolean
function itemapi.workbench_canCraft(wb, recipeType)
	local def = itemapi.craftingRecipeDefs[recipeType]

	for _, neededIngredient in ipairs(def.ingredients) do
		if neededIngredient[2] ~= itemapi.workbench_countIngredientType(wb, neededIngredient[1]) then return false end
	end

	return true
end

---@param wb mobj_t
---@param ingredientType itemapi.ItemType
---@return boolean
function itemapi.workbench_addIngredient(wb, ingredientType)
	local ingredientDef = itemapi.itemDefs[ingredientType]

	ingredientType = ingredientDef.index

	local x = wb.x + P_RandomRange(-16, 16) * FU
	local y = wb.y + P_RandomRange(-48, 48) * FU
	x, y = itemapi.rotatePointAroundPivot(x, y, wb.x, wb.y, wb.angle)

	local mo = P_SpawnMobj(x, y, wb.z + 48*FU, MT_ITEMAPI_WORKBENCHINGREDIENT)
	mo.angle = wb.angle + ANGLE_90
	mo.scale = FU/2

	itemapi.applyGroundItemAppearanceToMobj(mo, ingredientType)

	table.insert(wb.ingredients, {
		type = ingredientType,
		quantity = 1,
		mobj = mo
	})

	return true
end

---@param wb mobj_t
---@param index integer
function itemapi.workbench_removeIngredient(wb, index)
	local ingredient = wb.ingredients[index]

	ingredient.quantity = $ - 1

	if ingredient.quantity == 0 then
		P_RemoveMobj(ingredient.mobj)
		table.remove(wb.ingredients, index)
	end
end

---@param wb mobj_t
---@param recipeType integer
function itemapi.workbench_onRecipeSelect(wb, recipeType)
	wb.recipeType = recipeType
end
itemapi.register(itemapi.workbench_onRecipeSelect)


itemapi.addItem("workbench", {
	name = "workbench",
	storable = false,

	mobjSprite = SPR_ITEM,
	mobjFrame = A,

	model = "workbench",

	-- spots = {
	-- },

	onPlace = function(wb)
		wb.ingredients = {}
	end,

	getCarriable = function(wb)
		return (#wb.ingredients == 0)
	end,

	-- groundTicker1 = {
	-- 	frequency = 1,
	-- 	ticker = function(wb)
	-- 	end
	-- }

	groundAction1 = {
		name = "craft",
		duration = 5*TICRATE,

		animation1 = {
			type = "crumbs",
			sprites = "ICRU:0-2",
			color = SKINCOLOR_BROWN,
			frequency = TICRATE/16,
			offsetZ = 48*FU
		},
		animation2 = "shake",

		condition = function(_, wb)
			return wb.recipeType and itemapi.workbench_canCraft(wb, wb.recipeType)
		end,

		action = function (p, wb)
			local recipeDef = itemapi.craftingRecipeDefs[wb.recipeType]
			if not itemapi.carryItem(p, recipeDef.item) then return end

			for _, ingredient in ipairs(wb.ingredients) do
				P_RemoveMobj(ingredient.mobj)
			end

			wb.ingredients = {}
		end
	},

	groundAction2 = {
		name = "add ingredient",
		requiredCarriedItem = "group:workbench_ingredient",

		action = function(p, wb)
			if itemapi.workbench_addIngredient(wb, itemapi.getMainCarriedItemType(p)) then
				itemapi.smartUncarryItem(p)
			end
		end
	},

	groundAction3 = {
		name = "remove ingredient",

		condition = function(p, wb)
			return (#wb.ingredients ~= 0)
		end,
		action = function(p, wb)
			local i = P_RandomRange(1, #wb.ingredients)
			if p.itemapi_inventory:add(wb.ingredients[i].type) then
				itemapi.workbench_removeIngredient(wb, i)
			end
		end
	},

	groundAction4 = {
		name = "choose crafting recipe",
		action = function(p)
			itemapi.openCraftingRecipeSelection(p, itemapi.workbench_onRecipeSelect, "workbench")
		end
	},
})


itemapi.addCraftingRecipe(nil, {
	item = "workbench",
	ingredients = { { "log", 10 } }
})


dofile "Workbench/Models.lua"
