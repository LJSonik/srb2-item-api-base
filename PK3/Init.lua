dofile "Libraries/ljrequire.lua"

for _, filename in ipairs{
	"Core.lua",
	"PlantGrowth.lua",
	"Food.lua",
	"ActionAnimations.lua",
	"Log.lua",
	"GreenflowerFlowers.lua",
	"GreenflowerBushes.lua",
	"Trees.lua",
	"Animals.lua",

	"Campfire/Campfire.lua",
	"Tent/Tent.lua",
	"Chest/Chest.lua",
} do
	dofile(filename)
end
