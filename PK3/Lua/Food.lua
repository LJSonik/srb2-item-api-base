itemapi.addItemTemplate("food", function(def)
	return {
		name = "food",

		action1 = {
			name = "eat",
			duration = def.eatDuration,

			action = function(p)
				itemapi.eat(p, def.nutrition)
				itemapi.uncarryItem(p)
			end,
		}
	}
end)
