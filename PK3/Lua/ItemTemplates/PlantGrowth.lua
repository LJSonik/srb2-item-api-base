local plantableMaterials = itemapi.arrayToSet{ "dirt", "grass" }


local function isSurfaceFertile(surfaceType, surface)
	local texture
	if surfaceType == "sector_floor" then
		texture = surface.floorpic
	elseif surfaceType == "fof_top" then
		texture = surface.toppic
	end

	local material = itemapi.textureToSurfaceMaterial[texture]
	return plantableMaterials[material]
end

---Note: whacky and unreliable...
---@param x fixed_t
---@param y fixed_t
---@param z fixed_t
---@return nil|"sector_floor"|"fof_top"
---@return any
local function findFloorAt(x, y, z)
	local subsector = R_PointInSubsectorOrNil(x, y)
	if not subsector then return nil, nil end
	local sector = subsector.sector

	local bestZ = P_GetZAt(sector.f_slope, x, y, sector.floorheight)
	if bestZ > z then return nil, nil end

	local bestSurfaceType = "sector_floor"
	local bestSurface = sector

	for fof in sector.ffloors() do
		if fof.flags & FF_BLOCKOTHERS then
			local fofZ = P_GetZAt(fof.t_slope, x, y, fof.topheight)

			if fofZ <= z then
				bestSurfaceType = "fof_top"
				bestSurface = fof
				bestZ = fofZ
			end
		end
	end

	if abs(z - bestZ) <= 16*FU then
		return bestSurfaceType, bestSurface
	else
		return nil, nil
	end
end


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

				local floorType, floor = findFloorAt(plant.x, plant.y, plant.z)
				if not (floorType and isSurfaceFertile(floorType, floor)) then return end

				local age = plant.age + deltaTime
				plant.age = age

				if age >= def.growthTime then
					local grownID = def.groups["growing_plant"]
					itemapi.replaceGroundItem(plant, grownID)
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
				if not itemapi.placeItem(p, plantID, nil, isSurfaceFertile) then return end
				itemapi.smartUncarryItem(p)
			end
		}
	}
end)
