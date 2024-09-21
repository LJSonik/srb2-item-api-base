dofile "Libraries/ljrequire.lua"

for _, filename in ipairs{
	"ActionAnimations/Shake.lua",
	"ActionAnimations/Crumbs.lua",
	"ActionAnimations/Sound.lua",

	"Core.lua",
	"GlobalLight.lua",
	"DayNightCycle.lua",
	"PlantGrowth.lua",
	"Food.lua",
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
