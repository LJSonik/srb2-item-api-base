freeslot("SPR_ICRU")

itemapi.addActionAnimation("crumbs", {
	start = function(mo, state)
		state.crumbs = itemapi.spawnParticlePool()
	end,

	tick = function(mo, state, params)
		if leveltime % (params.frequency or 1) ~= 0 then return end

		local crumbs = state.crumbs

		local crumb = P_SpawnMobj(mo.x, mo.y, mo.z, MT_ITEMAPI_PARTICLE)
		table.insert(crumbs, crumb)

		crumb.flags = $ & ~(MF_NOCLIP|MF_NOCLIPHEIGHT|MF_NOGRAVITY)
		crumb.fuse = 10*TICRATE

		crumb.momx, crumb.momy = itemapi.randomPointInCircle(0, 0, 4*FU)
		crumb.momz = 4*FU

		crumb.sprite, crumb.frame = SPR_ICRU, 0
		crumb.color = params.color
	end,

	stop = function(mo, state)
	end
})
