freeslot("SPR_ICRU")

itemapi.addActionAnimation("crumbs", {
	start = function(_, state, params)
		params.sprites = $ or params.sprite
		if type(params.sprites) == "string" then
			params.sprites = { params.sprites }
		end

		params.parsedSprites = {}
		for _, s in ipairs(params.sprites) do
			local extraSprites = itemapi.parseSpriteFramePairs(s)
			for _, extraSprite in ipairs(extraSprites) do
				table.insert(params.parsedSprites, { extraSprite[1], extraSprite[2] })
			end
		end

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

		local spritePair = itemapi.randomElement(params.parsedSprites)
		crumb.sprite, crumb.frame = spritePair[1], spritePair[2]
		crumb.color = params.color or SKINCOLOR_NONE

		local scale = params.scale or FU
		crumb.spritexscale, crumb.spriteyscale = scale, scale
	end,
})
