---@class itemapi.DayNightCycle : itemapi.Module
---@field vars itemapi.DayNightCycle.Vars
itemapi.DayNightCycle = itemapi.addModule()


---@class itemapi.DayNightCycle
local dn = itemapi.DayNightCycle


dn.DAY_LIGHT = 255

dn.MINUTE = 60*TICRATE
dn.HOUR = 60*dn.MINUTE
dn.DAY = 24*dn.HOUR

dn.MORNING_START = 5*dn.HOUR
dn.MORNING_END = 9*dn.HOUR
dn.EVENING_START = 19*dn.HOUR
dn.EVENING_END = 23*dn.HOUR


---@class itemapi.DayNightCycle.Vars
---@field time tic_t

dn.vars.time = 0


dn.vars.time = (dn.MORNING_START + dn.MORNING_END) / 2


function dn.getTimeDiff(startTime, endTime)
	local delta = endTime - startTime
	if delta < 0 then
		delta = delta + dn.DAY
	end
	return delta
end

function dn.isTimeInRange(time, startTime, endTime)
	return (dn.getTimeDiff(startTime, time) < dn.getTimeDiff(startTime, endTime))
end

function dn.getDayPhase()
	local time = dn.vars.time

	local phase
	local startTime, endTime
	if dn.isTimeInRange(time, dn.MORNING_START, dn.MORNING_END) then
		phase = "morning"
		startTime, endTime = dn.MORNING_START, dn.MORNING_END
	elseif dn.isTimeInRange(time, dn.MORNING_END, dn.EVENING_START) then
		phase = "day"
		startTime, endTime = dn.MORNING_END, dn.EVENING_START
	elseif dn.isTimeInRange(time, dn.EVENING_START, dn.EVENING_END) then
		phase = "evening"
		startTime, endTime = dn.EVENING_START, dn.EVENING_END
	else
		phase = "night"
		startTime, endTime = dn.EVENING_END, dn.EVENING_START
	end

	local ratio = FixedDiv(dn.getTimeDiff(startTime, time), dn.getTimeDiff(startTime, endTime))

	return phase, ratio
end

function dn.isDayHalf()
	local morning = (dn.MORNING_START + dn.MORNING_END) / 2
	local evening = (dn.EVENING_START + dn.EVENING_END) / 2
	return dn.isTimeInRange(dn.vars.time, morning, evening)
end

local function getLightInTimeRange(time, startTime, endTime, startLight, endLight)
	local ratio = FixedDiv(dn.getTimeDiff(startTime, time), dn.getTimeDiff(startTime, endTime))
	return itemapi.easeLinear(ratio, startLight, endLight)
end

function dn.getSunLight(time)
	local nightLight = 128
	local phase = dn.getDayPhase()

	if phase == "morning" then
		return getLightInTimeRange(time, dn.MORNING_START, dn.MORNING_END, nightLight, dn.DAY_LIGHT)
	elseif phase == "day" then
		return dn.DAY_LIGHT
	elseif phase == "evening" then
		return getLightInTimeRange(time, dn.EVENING_START, dn.EVENING_END, dn.DAY_LIGHT, nightLight)
	else
		return nightLight
	end
end

local function updateTime()
	dn.vars.time = ($ + 120) % dn.DAY

	local light = dn.getSunLight(dn.vars.time)

	local oldSky = globallevelskynum
	local sky
	if light > 160 then
		sky = mapheaderinfo[gamemap].skynum
	else
		sky = 21
	end

	if sky ~= oldSky then
		P_SetupLevelSky(sky)
	end

	itemapi.GlobalLight.setLight(light)
end


addHook("ThinkFrame", function()
	if gamestate == GS_LEVEL then
		updateTime()
	end
end)
