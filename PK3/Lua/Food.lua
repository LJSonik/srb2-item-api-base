freeslot("sfx_iteat")


itemapi.addItemTemplate("food", function(def)
	itemapi.parseSugarArray(def, "eatAnimations", "eatAnimation")

	if not def.eatAnimations then
		def.eatAnimations = {
			{
				type = "crumbs",
				sprites = "ICRU:0-2",
				color = def.foodCrumbColor or SKINCOLOR_RED,
				scale = 2*FU,
				frequency = TICRATE/16
			},
			{ type="shake" },
			{ type="sound", sound=sfx_iteat },
		}
	end

	return {
		name = "food",

		action1 = {
			name = "eat",
			duration = def.eatDuration,
			animations = def.eatAnimations,

			action = function(p)
				itemapi.eat(p, def.nutrition)
				itemapi.uncarryItem(p)

				if def.eatenItem then
					itemapi.carryItem(p, def.eatenItem)
				end
			end,
		}
	}
end)
