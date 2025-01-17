freeslot("SPR_ICRU")

local function parseParams(params)
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
end

itemapi.addActionAnimation("crumbs", {
	start = function(_, state, params)
		state.crumbs = itemapi.spawnParticlePool()
	end,

	tick = function(mo, state, params)
		if not params.parsedSprites then
			parseParams(params)
		end

		if leveltime % (params.frequency or 1) ~= 0 then return end

		local crumbs = state.crumbs

		local z = mo.z + FixedMul(params.offsetZ or 0, mo.scale)

		local crumb = P_SpawnMobj(mo.x, mo.y, z, MT_ITEMAPI_PARTICLE)
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
