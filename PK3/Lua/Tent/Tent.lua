-- Todo:
-- Tent


freeslot(
	"SPR_ITNT",
	"MT_ITEMAPI_TENT", "S_ITEMAPI_TENT",
	"MT_ITEMAPI_TENT_SENSOR", "S_ITEMAPI_TENT_SENSOR"
)


mobjinfo[MT_ITEMAPI_TENT] = {
	spawnstate = S_ITEMAPI_TENT,
	spawnhealth = 1,
	radius = 8*FU,
	height = 16*FU,
	flags = MF_NOCLIP|MF_NOCLIPHEIGHT|MF_SCENERY|MF_NOGRAVITY
}

states[S_ITEMAPI_TENT] = { SPR_NULL }


---@param tent mobj_t
local function spawnSensors(tent)
	tent.sensors = {}

	for y = -64*FU, 64*FU, 128*FU do
		for x = -192*FU, 192*FU, 128*FU do
			local tx, ty = itemapi.rotatePointAroundPivot(x, y, 0, 0, tent.angle)
			local sensor = P_SpawnMobj(tent.x + tx, tent.y + ty, tent.z, MT_ITEMAPI_TENT_SENSOR)
			sensor.target = tent
			table.insert(tent.sensors, sensor)
		end
	end
end


itemapi.addItem("tent", {
	name = "tent",
	stackable = 2,
	carriable = false,
	dimensions = { 512, 256, 128 },

	mobjType = MT_ITEMAPI_TENT,
	mobjSprite = SPR_ITEM,
	mobjFrame = A,

	model = "tent",

	onPlace = function(tent)
		spawnSensors(tent)
	end,

	onDespawn = function(tent)
		for _, sensor in ipairs(tent.sensors) do
			P_RemoveMobj(sensor)
		end
	end,
})


itemapi.addCraftingRecipe(nil, {
	item = "tent",
	ingredients = { { "leaves", 10 } }
})


dofile "Tent/Collision.lua"
dofile "Tent/Models.lua"
