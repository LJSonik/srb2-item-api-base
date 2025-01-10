itemapi.addActionAnimation("sound", {
	start = function(mo, _, params)
		S_StartSound(mo, params.sound)
	end,
})

itemapi.addActionAnimation("looped_sound", {
	tick = function(mo, _, params)
		if leveltime % params.frequency == 0 then
			S_StartSound(mo, params.sound)
		end
	end,
})
