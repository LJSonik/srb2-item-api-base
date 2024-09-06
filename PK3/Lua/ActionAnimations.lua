itemapi.addActionAnimation("shake", {
	start = function(_, action)
		action.shakeOffset = 0
	end,

	tick = function(mo, action)
		local intensity = 4*FU
		local speed = TICRATE/8
		local offset = itemapi.sinCycle(leveltime, -intensity, intensity, speed)

		mo.spritexoffset = $ + offset - action.shakeOffset
		action.shakeOffset = offset
	end,

	stop = function(mo, action)
		mo.spritexoffset = $ - action.shakeOffset
	end
})
