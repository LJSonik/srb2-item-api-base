itemapi.CAMPFIRE_MAX_FLAMES = 10

local maxFlameHeightForNumLogs = { [0] = 0, 0, 32, 32, 64 }


freeslot("S_ITEMAPI_CAMPFIRE_FLAME")
states[S_ITEMAPI_CAMPFIRE_FLAME] = { SPR_FLAM, A|FF_ANIMATE|FF_FULLBRIGHT, 24, nil, 7, 3, S_ITEMAPI_CAMPFIRE_FLAME }


function itemapi.campfire_getNumFlamesForFuelAmount(fuelAmount)
	local wantedNumFlames = fuelAmount * (itemapi.CAMPFIRE_MAX_FLAMES + 1) / itemapi.CAMPFIRE_MAX_FUEL
	return min(wantedNumFlames, itemapi.CAMPFIRE_MAX_FLAMES)
end

---@param campfire mobj_t
---@return fixed_t
---@return fixed_t
---@return fixed_t
local function getFlamePosition(campfire)
	local numLogs = itemapi.campfire_getNumLogsForFuelAmount(campfire.fuel)
	local x, y = itemapi.randomPointInCircle(campfire.x, campfire.y, 48 * campfire.scale)
	local z = campfire.z + P_RandomRange(0, maxFlameHeightForNumLogs[numLogs]) * campfire.scale
	return x, y, z
end

---@param campfire mobj_t
function itemapi.campfire_updateFlames(campfire)
	local flames = campfire.flames

	local wantedNumFlames = itemapi.campfire_getNumFlamesForFuelAmount(campfire.fuel)

	if #flames < wantedNumFlames then -- Not enough flames, spawn more
		local x, y, z = getFlamePosition(campfire)
		local flame = P_SpawnMobj(x, y, z, MT_ITEMAPI_PARTICLE)
		flames[#flames + 1] = flame

		flame.state = S_ITEMAPI_CAMPFIRE_FLAME

		flame.scale = campfire.scale / 64
		flame.destscale = itemapi.randomFixed(campfire.scale / 2, campfire.scale * 2)
		flame.scalespeed = campfire.scale / 1024
	-- Remove a flame once in a while or when there is too many
	elseif #flames > wantedNumFlames
	or P_RandomChance(FU/8 * #flames / itemapi.CAMPFIRE_MAX_FLAMES) then
		local i = P_RandomRange(1, #flames)
		if flames[i].valid then
			P_RemoveMobj(flames[i])
		end
		table.remove(flames, i)
	else -- Move a random flame
		if P_RandomChance(FU/2 * #flames / itemapi.CAMPFIRE_MAX_FLAMES) then
			local i = P_RandomRange(1, #flames)
			if flames[i].valid then
				P_MoveOrigin(flames[i], getFlamePosition(campfire))
			end
		end
	end
end
