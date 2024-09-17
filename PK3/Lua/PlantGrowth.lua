itemapi.addItemTemplate("growing_plant", function()
	return {
		name = "growing plant",

		onSpawn = function(plant)
			plant.age = 0
		end,

		groundTicker1 = {
			frequency = TICRATE,
			ticker = function(plant, deltaTime)
				local def = itemapi.getItemDefFromMobj(plant)

				local age = plant.age + deltaTime
				plant.age = age

				if age >= def.growthTime then
					local grownID = def.groups["growing_plant"]
					itemapi.spawnGroundItem(plant.x, plant.y, plant.z, grownID)
					P_RemoveMobj(plant)
				end
			end
		}
	}
end)


itemapi.addItemTemplate("plant_seed", function()
	return {
		name = "plant seed",

		action1 = {
			name = "plant",
			action = function(p)
				local def = itemapi.itemDefs[itemapi.getMainCarriedItemType(p)]
				local plantID = def.groups["plant_seed"]
				if not itemapi.placeItem(p, plantID) then return end
				itemapi.smartUncarryItem(p)
			end
		}
	}
end)
