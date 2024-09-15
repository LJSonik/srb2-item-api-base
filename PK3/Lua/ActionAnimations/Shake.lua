itemapi.addActionAnimation("shake", {
	start = function(_, state)
		state.shakeOffset = 0
	end,

	tick = function(mo, state, params)
		local intensity = params.intensity or (2*FU)
		local speed = params.speed or (TICRATE/8)
		local offset = itemapi.sinCycle(leveltime, -intensity, intensity, speed)

		mo.spritexoffset = $ + offset - state.shakeOffset
		state.shakeOffset = offset
	end,

	stop = function(mo, state)
		mo.spritexoffset = $ - state.shakeOffset
	end
})
