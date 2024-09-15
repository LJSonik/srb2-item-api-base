itemapi.addActionAnimation("shake", {
	start = function(_, state)
		state.shakeOffset = 0
	end,

	tick = function(mo, state)
		local intensity = 4*FU
		local speed = TICRATE/8
		local offset = itemapi.sinCycle(leveltime, -intensity, intensity, speed)

		mo.spritexoffset = $ + offset - state.shakeOffset
		state.shakeOffset = offset
	end,

	stop = function(mo, state)
		mo.spritexoffset = $ - state.shakeOffset
	end
})
