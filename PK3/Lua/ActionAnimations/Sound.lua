itemapi.addActionAnimation("sound", {
	start = function(_, _, params, p)
		S_StartSound(p.mo, params.sound)
	end,
})

itemapi.addActionAnimation("looped_sound", {
	tick = function(_, _, params, p)
		if leveltime % params.frequency == 0 then
			S_StartSound(p.mo, params.sound)
		end
	end,
})
