---@class itemapi.GlobalLight : itemapi.Module
---@field vars itemapi.GlobalLight.Vars
itemapi.GlobalLight = itemapi.addModule()


---@class itemapi.GlobalLight
local gl = itemapi.GlobalLight


---@class itemapi.GlobalLight.Vars
---@field light integer
---@field actualLight integer
---@field origSectorLights? integer[]

gl.vars.light = 255
gl.vars.actualLight = gl.vars.light
gl.vars.origSectorLights = nil

local precalculatedLightLevels -- Only used locally


local function initialiseSectorLights()
	gl.vars.origSectorLights = {}
	for i = 0, #sectors - 1 do
		gl.vars.origSectorLights[i] = min(max(sectors[i].lightlevel, 0), 255)
	end
end

local function precalculateLightLevels()
	local minLight = 128
	local lightRange = 255 - minLight

	precalculatedLightLevels = {}

	for light = 0, 255 do
		local lightLevels = {}

		for origLight = 0, 255 do
			if origLight > minLight then
				lightLevels[origLight] = max(origLight - (255 - light), minLight)

				--local ratio = FixedMul(origLight - minLight, lightRange)
				--lightLevels[origLight] = itemapi.easeLinear(ratio, minLight * FU, light * FU) / FU
			else
				lightLevels[origLight] = origLight
			end
		end

		precalculatedLightLevels[light] = lightLevels
	end
end

local function updateSectors()
	if not gl.vars.origSectorLights then
		initialiseSectorLights()
	end

	if not precalculatedLightLevels then
		precalculateLightLevels()
	end

	-- Store globals into locals to make the loop much faster
	local sectors = sectors
	local origSectorLights = gl.vars.origSectorLights
	local precalculatedLightLevels = precalculatedLightLevels[gl.vars.light]

	for i = 0, #origSectorLights do
		sectors[i].lightlevel = precalculatedLightLevels[origSectorLights[i]]
	end

	gl.vars.actualLight = gl.vars.light
end

function gl.setLight(light)
	gl.vars.light = light
end


addHook("ThinkFrame", function()
	if gamestate == GS_LEVEL and gl.vars.light ~= gl.vars.actualLight then
		updateSectors()
	end
end)

addHook("MapChange", function()
	gl.vars.actualLight = 255
	gl.vars.origSectorLights = nil

	precalculatedLightLevels = nil
end)

addHook("NetVars", function(n)
	precalculatedLightLevels = nil
end)
