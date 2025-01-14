dofile "Libraries/ljrequire.lua"

for _, filename in ipairs{
	"ActionAnimations/Shake.lua",
	"ActionAnimations/Crumbs.lua",
	"ActionAnimations/Sound.lua",

	"ItemTemplates/PlantGrowth.lua",
	"ItemTemplates/Food.lua",
	"ItemTemplates/Flower.lua",

	"Core.lua",
	"GlobalLight.lua",
	"DayNightCycle.lua",
	"ChatMessages.lua",
	"Log.lua",
	"GreenflowerFlowers.lua",
	"CastleEggmanPlants.lua",
	"BotanicSerenityFlowers.lua",
	"GreenflowerBushes.lua",
	"Trees.lua",
	"Flickies.lua",
	"Meat.lua",

	"Campfire/Campfire.lua",
	"Tent/Tent.lua",
	"Chest/Chest.lua",
	"Rowboat/Rowboat.lua",
	"Workbench/Workbench.lua",
} do
	dofile(filename)
end
