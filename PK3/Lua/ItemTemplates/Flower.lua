itemapi.addItemTemplate("flower", function(def)
	return {
		name = "flower",

		action1 = {
			name = "destroy and get seeds",
			action = function(p)
				local n = P_RandomRange(1, 2)
				if not p.itemapi_inventory:add(def.seed, n) then return end
				itemapi.smartUncarryItem(p)
			end
		}
	}
end)
