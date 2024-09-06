itemapi.addItemTemplate("food", {
	name = "food",

	onTemplate = function(def)
		def.action1.duration = def.eatDuration
	end,

	action1 = {
		name = "eat",
		action = function(p)
			local def = itemapi.itemDefs[itemapi.getMainCarriedItemType(p)]
			itemapi.eat(p, def.nutrition)
			itemapi.uncarryItem(p)
		end
	}
})
