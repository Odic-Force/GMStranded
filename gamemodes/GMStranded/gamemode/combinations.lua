/*---------------------------------------------------------
  Combinations system
---------------------------------------------------------*/
GMS.Combinations = {}
function GMS.RegisterCombi(name,tbl,group)
	if !GMS.Combinations[group] then GMS.Combinations[group] = {} end
	GMS.Combinations[group][name] = tbl
end
/*---------------------------------------------------------

  Buildings / big stuff

---------------------------------------------------------*/
/*---------------------------------------------------------
  Stone Workbench
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stone Workbench"
COMBI.Description = [[This stone table has various fine specialized equipment used in crafting basic items.
You need:
30 Stone
20 Wood
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 20
COMBI.Req["Stone"] = 30

COMBI.Results = {}
COMBI.Results = "gms_stoneworkbench"
COMBI.BuildSiteModel = "models/props/de_piranesi/pi_merlon.mdl"

GMS.RegisterCombi("StoneWorkbench",COMBI,"Buildings")
/*---------------------------------------------------------
  Copper Workbench
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Copper Workbench"
COMBI.Description = [[This Copper table has various fine specialized equipment used in crafting quality items.
You need:
30 Copper
10 Stone
20 Wood
]]

COMBI.Req = {}
COMBI.Req["Copper"] = 30
COMBI.Req["Stone"] = 10
COMBI.Req["Wood"] = 20

COMBI.Results = {}
COMBI.Results = "gms_copperworkbench"
COMBI.BuildSiteModel = "models/props_combine/breendesk.mdl"

GMS.RegisterCombi("CopperWorkbench",COMBI,"Buildings")
/*---------------------------------------------------------
  Iron Workbench
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Iron Workbench"
COMBI.Description = [[This iron table has various fine specialized equipment used in crafting advanced items.
You need:
30 Iron
20 Stone
10 Wood
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 30
COMBI.Req["Stone"] = 20
COMBI.Req["Wood"] = 10

COMBI.Results = {}
COMBI.Results = "gms_ironworkbench"
COMBI.BuildSiteModel = "models/props_wasteland/controlroom_desk001b.mdl"

GMS.RegisterCombi("IronWorkbench",COMBI,"Buildings")
/*---------------------------------------------------------
  Drinking Fountain
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Drinking Fountain"
COMBI.Description = [[PORTABLE WATER?!
You need:
50 Copper
50 Iron
50 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Copper"] = 50
COMBI.Req["Iron"] = 50
COMBI.Req["Water_Bottles"] = 50

COMBI.Results = {}
COMBI.Results = "gms_waterfountain"
COMBI.BuildSiteModel = "models/props/de_inferno/fountain.mdl"

GMS.RegisterCombi("DrinkingFountain",COMBI,"Buildings")
/*---------------------------------------------------------
  Stove
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stove"
COMBI.Description = [[Using a stove, you can cook without having to light a fire.
You need:
10 Copper
25 Iron
35 Wood
]]

COMBI.Req = {}
COMBI.Req["Copper"] = 35
COMBI.Req["Iron"] = 35
COMBI.Req["Wood"] = 35

COMBI.Results = {}
COMBI.Results = "gms_stove"
COMBI.BuildSiteModel = "models/props_c17/furniturestove001a.mdl"

GMS.RegisterCombi("Stove",COMBI,"Buildings")
/*---------------------------------------------------------
  Stone Furnace
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stone Furnace"
COMBI.Description = [[You can use the furnace to smelt resources into another, such as Copper Ore into Copper.
You need:
35 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 35

COMBI.Results = {}
COMBI.Results = "gms_stonefurnace"
COMBI.BuildSiteModel = "models/props/de_inferno/ClayOven.mdl"

GMS.RegisterCombi("StoneFurnace",COMBI,"Buildings")
/*---------------------------------------------------------
  Copper Furnace
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Copper Furnace"
COMBI.Description = [[You can use the furnace to smelt resources into another, such as Iron Ore into Iron.
You need:
35 Copper
]]

COMBI.Req = {}
COMBI.Req["Copper"] = 35

COMBI.Results = {}
COMBI.Results = "gms_copperfurnace"
COMBI.BuildSiteModel = "models/props/cs_militia/furnace01.mdl"

GMS.RegisterCombi("CopperFurnace",COMBI,"Buildings")
/*---------------------------------------------------------
  Iron Furnace
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Iron Furnace"
COMBI.Description = [[You can use the furnace to smelt resources into another, such as Sand into Glass.
You need:
35 Iron
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 35

COMBI.Results = {}
COMBI.Results = "gms_ironfurnace"
COMBI.BuildSiteModel = "models/props_c17/furniturefireplace001a.mdl"

GMS.RegisterCombi("IronFurnace",COMBI,"Buildings")
/*---------------------------------------------------------
  Grinding Stone
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Grinding Stone"
COMBI.Description = [[You can use the grinding stone to smash resources into smaller things, such as stone into sand.
You need:
40 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 40

COMBI.Results = {}
COMBI.Results = "gms_grindingstone"
COMBI.BuildSiteModel = "models/props_combine/combine_mine01.mdl"

GMS.RegisterCombi("GrindingStone",COMBI,"Buildings")
/*---------------------------------------------------------
  Factory
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Factory"
COMBI.Description = [[You can use the factory to smelt resources into another and extract resources out of other resources.
You need:
200 Iron
100 Copper
50 Stone
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 200
COMBI.Req["Copper"] = 100
COMBI.Req["Stone"] = 50

COMBI.Results = {}
COMBI.Results = "gms_factory"
COMBI.BuildSiteModel = "models/props_c17/factorymachine01.mdl"

GMS.RegisterCombi("Factory",COMBI,"Buildings")
/*---------------------------------------------------------
  Gunlab
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gunlab"
COMBI.Description = [[For making the components of guns with relative ease.
You need:
100 Iron
150 Wood
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 100
COMBI.Req["Wood"] = 150

COMBI.Results = {}
COMBI.Results = "gms_gunlab"
COMBI.BuildSiteModel = "models/props/cs_militia/gun_cabinet.mdl"

GMS.RegisterCombi("Gunlab",COMBI,"Buildings")
/*---------------------------------------------------------
  GunChunks
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gun Chunks"
COMBI.Description = [[For making the components of guns with relative ease.
You need:
50 Iron
25 Copper
25 Wood
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 50
COMBI.Req["Copper"] = 25
COMBI.Req["Wood"] = 25

COMBI.Results = {}
COMBI.Results = "gms_gunchunks"
COMBI.BuildSiteModel = "models/Gibs/airboat_broken_engine.mdl"

GMS.RegisterCombi("Gunchunks",COMBI,"Buildings")
/*---------------------------------------------------------

  Furnace

---------------------------------------------------------*/
/*---------------------------------------------------------
  Glass
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Glass"
COMBI.Description = [[Glass can be used for making bottles and lighting.
You need:
2 Sand
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 2

COMBI.Results = {}
COMBI.Results["Glass"] = 1

GMS.RegisterCombi("Glass",COMBI,"IronFurnace")
/*---------------------------------------------------------
  Copper Ore to Copper x1
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Copper1"
COMBI.Description = [[Copper can be used to create more advanced buildings and tools.
You need:
1 Copper Ore
]]

COMBI.Req = {}
COMBI.Req["Copper_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Copper"] = 1

GMS.RegisterCombi("Copper1",COMBI,"StoneFurnace")
/*---------------------------------------------------------
  Copper Ore to Copper x5
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Copper5"
COMBI.Description = [[Copper can be used to create more advanced buildings and tools.
You need:
5 Copper Ore
]]

COMBI.Req = {}
COMBI.Req["Copper_Ore"] = 5

COMBI.Results = {}
COMBI.Results["Copper"] = 5

GMS.RegisterCombi("Copper5",COMBI,"StoneFurnace")
/*---------------------------------------------------------
  Copper Ore to Copper x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Copper10"
COMBI.Description = [[Copper can be used to create more advanced buildings and tools.
You need:
10 Copper Ore
]]

COMBI.Req = {}
COMBI.Req["Copper_Ore"] = 10

COMBI.Results = {}
COMBI.Results["Copper"] = 10

GMS.RegisterCombi("Copper10",COMBI,"StoneFurnace")
/*---------------------------------------------------------
  Copper Ore to Copper x25
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Copper25"
COMBI.Description = [[Copper can be used to create more advanced buildings and tools.
You need:
25 Copper Ore
]]

COMBI.Req = {}
COMBI.Req["Copper_Ore"] = 25

COMBI.Results = {}
COMBI.Results["Copper"] = 25

GMS.RegisterCombi("Copper25",COMBI,"StoneFurnace")

/*---------------------------------------------------------
  Allsmelt Copper
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Copper"
COMBI.Description = [[Copper can be used to create more advanced buildings and tools.
You need:
Copper Ore (35 MAX)
]]

COMBI.Req = {}
COMBI.Req["Copper_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Copper"] = 1

COMBI.AllSmelt = true
COMBI.Max = 35

GMS.RegisterCombi("AllSmeltCopper",COMBI,"StoneFurnace")
/*---------------------------------------------------------
  Iron Ore to Iron x1
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Iron1"
COMBI.Description = [[Iron can be used to create more advanced buildings and tools.
You need:
1 Iron Ore
]]

COMBI.Req = {}
COMBI.Req["Iron_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Iron"] = 1

GMS.RegisterCombi("Iron1",COMBI,"CopperFurnace")
/*---------------------------------------------------------
 Iron Ore to Iron x5
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Iron5"
COMBI.Description = [[Iron can be used to create more advanced buildings and tools.
You need:
5 Iron Ore
]]

COMBI.Req = {}
COMBI.Req["Iron_Ore"] = 5

COMBI.Results = {}
COMBI.Results["Iron"] = 5

GMS.RegisterCombi("Iron5",COMBI,"CopperFurnace")
/*---------------------------------------------------------
  Iron Ore to Iron x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Iron10"
COMBI.Description = [[Iron can be used to create more advanced buildings and tools.
You need:
10 Iron Ore
]]

COMBI.Req = {}
COMBI.Req["Iron_Ore"] = 10

COMBI.Results = {}
COMBI.Results["Iron"] = 10

GMS.RegisterCombi("Iron10",COMBI,"CopperFurnace")
/*---------------------------------------------------------
  Iron Ore to Iron x25
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Iron25"
COMBI.Description = [[Iron can be used to create more advanced buildings and tools.
You need:
25 Iron Ore
]]

COMBI.Req = {}
COMBI.Req["Iron_Ore"] = 25

COMBI.Results = {}
COMBI.Results["Iron"] = 25

GMS.RegisterCombi("Iron25",COMBI,"CopperFurnace")

/*---------------------------------------------------------
  Allsmelt Iron 
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Iron"
COMBI.Description = [[Iron can be used to create more advanced buildings and tools.
You need:
Iron Ore (50 MAX)
]]

COMBI.Req = {}
COMBI.Req["Iron_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Iron"] = 1

COMBI.AllSmelt = true
COMBI.Max = 50

GMS.RegisterCombi("AllSmeltIron",COMBI,"CopperFurnace")
/*---------------------------------------------------------
  Charcoal
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Charcoal"
COMBI.Description = [[Used in the production of gunpowder.
You need:
5 Wood
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 5

COMBI.Results = {}
COMBI.Results["Charcoal"] = 1

GMS.RegisterCombi("Charcoal",COMBI,"IronFurnace")
/*---------------------------------------------------------
  Charcoal10x
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Charcoal 10x"
COMBI.Description = [[Used in the production of gunpowder.
You need:
15 Wood
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 15

COMBI.Results = {}
COMBI.Results["Charcoal"] = 10

GMS.RegisterCombi("Charcoal10",COMBI,"IronFurnace")
/*---------------------------------------------------------
  Sulphur
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sulphur x5"
COMBI.Description = [[Used in the production of gunpowder, refine from rocks.
You need:
20 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 10

COMBI.Results = {}
COMBI.Results["Sulphur"] = 5

GMS.RegisterCombi("Sulphur5",COMBI,"CopperFurnace")
/*---------------------------------------------------------
  Sulphur 10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sulphur x10"
COMBI.Description = [[Used in the production of gunpowder, refine from rocks.
You need:
20 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 20

COMBI.Results = {}
COMBI.Results["Sulphur"] = 10

GMS.RegisterCombi("Sulphur10",COMBI,"CopperFurnace")
/*---------------------------------------------------------

  Factory

---------------------------------------------------------*/
/*---------------------------------------------------------
  Glass (10)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FGlass10"
COMBI.Description = [[Heats 25 sand together to form 10 glass.
You need:
25 Sand
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 25

COMBI.Results = {}
COMBI.Results["Glass"] = 10

GMS.RegisterCombi("FGlass10",COMBI,"Factory")
/*---------------------------------------------------------
  Glass (25)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FGlass25"
COMBI.Description = [[Heats 50 sand together to form 25 glass.
You need:
50 Sand
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 50

COMBI.Results = {}
COMBI.Results["Glass"] = 25

GMS.RegisterCombi("FGlass25",COMBI,"Factory")

/*---------------------------------------------------------
  Glass (50)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FGlass50"
COMBI.Description = [[Heats 75 sand together to form 50 glass.
You need:
75 Sand
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 75

COMBI.Results = {}
COMBI.Results["Glass"] = 50

GMS.RegisterCombi("FGlass50",COMBI,"Factory")

/*---------------------------------------------------------
  Iron from Stone (10)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FIron10"
COMBI.Description = [[Smelting together 25 stone forms 10 iron.
You need:
25 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 25

COMBI.Results = {}
COMBI.Results["Iron"] = 10

GMS.RegisterCombi("FIron10",COMBI,"Factory")

/*---------------------------------------------------------
  Iron from Stone (25)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FIron25"
COMBI.Description = [[Smelting together 50 stone forms 25 iron.
You need:
50 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 50

COMBI.Results = {}
COMBI.Results["Iron"] = 25

GMS.RegisterCombi("FIron25",COMBI,"Factory")

/*---------------------------------------------------------
  Iron from Stone (50)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FIron50"
COMBI.Description = [[Smelting together 75 stone forms 50 iron.
You need:
75 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 75

COMBI.Results = {}
COMBI.Results["Iron"] = 50

GMS.RegisterCombi("FIron50",COMBI,"Factory")

/*---------------------------------------------------------
  Allsmelt Iron 
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Iron"
COMBI.Description = [[Iron can be used to create more advanced buildings and tools.
You need:
Iron Ore (200 MAX)
]]

COMBI.Req = {}
COMBI.Req["Iron_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Iron"] = 1

COMBI.AllSmelt = true
COMBI.Max = 200

GMS.RegisterCombi("AllSmeltIron",COMBI,"Factory")

/*---------------------------------------------------------
  Allsmelt Copper
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Copper"
COMBI.Description = [[Copper can be used to create more advanced buildings and tools.
You need:
Copper Ore (200 MAX)
]]

COMBI.Req = {}
COMBI.Req["Copper_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Copper"] = 1

COMBI.AllSmelt = true
COMBI.Max = 200

GMS.RegisterCombi("AllSmeltCopper",COMBI,"Factory")
/*---------------------------------------------------------
  Stone to Sand (10)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FSand10"
COMBI.Description = [[Crushes 10 stone to 10 sand.
You need:
10 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 10

COMBI.Results = {}
COMBI.Results["Sand"] = 10

GMS.RegisterCombi("FSand10",COMBI,"Factory")

/*---------------------------------------------------------
  Stone to Sand (25)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FSand25"
COMBI.Description = [[Crushes 20 stone to 25 sand.
You need:
20 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 20

COMBI.Results = {}
COMBI.Results["Sand"] = 25

GMS.RegisterCombi("FSand25",COMBI,"Factory")

/*---------------------------------------------------------
  Stone to Sand (50)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FSand50"
COMBI.Description = [[Crushes 30 stone to 50 sand.
You need:
30 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 30

COMBI.Results = {}
COMBI.Results["Sand"] = 50

GMS.RegisterCombi("FSand50",COMBI,"Factory")

/*---------------------------------------------------------
  Resin (5)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FResin5"
COMBI.Description = [[Extracts the resin from the wood.
You need:
15 wood
1 Water Bottle
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 15
COMBI.Req["Water_Bottles"] = 1

COMBI.Results = {}
COMBI.Results["Resin"] = 5

GMS.RegisterCombi("FResin5",COMBI,"Factory")

/*---------------------------------------------------------
  Resin (10)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FResin10"
COMBI.Description = [[Extracts the resin from the wood.
You need:
25 wood
2 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 25
COMBI.Req["Water_Bottles"] = 2

COMBI.Results = {}
COMBI.Results["Resin"] = 10

GMS.RegisterCombi("FResin10",COMBI,"Factory")

/*---------------------------------------------------------
  Resin (25)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FResin25"
COMBI.Description = [[Extracts the resin from the wood.
You need:
50 wood
4 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 50
COMBI.Req["Water_Bottles"] = 4

COMBI.Results = {}
COMBI.Results["Resin"] = 25

GMS.RegisterCombi("FResin25",COMBI,"Factory")

/*---------------------------------------------------------
  Plastic (10)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FPlastic10"
COMBI.Description = [[Solidifies the Resin, creating a natural plastic.
You need:
10 Resin
]]

COMBI.Req = {}
COMBI.Req["Resin"] = 10

COMBI.Results = {}
COMBI.Results["Plastic"] = 10

GMS.RegisterCombi("FPlastic10",COMBI,"Factory")

/*---------------------------------------------------------
  Plastic (25)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FPlastic25"
COMBI.Description = [[Solidifies the Resin, creating a natural plastic.
You need:
20 Resin
]]

COMBI.Req = {}
COMBI.Req["Resin"] = 20

COMBI.Results = {}
COMBI.Results["Plastic"] = 25

GMS.RegisterCombi("FPlastic25",COMBI,"Factory")

/*---------------------------------------------------------

  Grinding Stone

---------------------------------------------------------*/
/*---------------------------------------------------------
  Stone to Sand x1
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sand1"
COMBI.Description = [[Converts 1 stone to 1 sand.
You need:
1 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 1

COMBI.Results = {}
COMBI.Results["Sand"] = 1

GMS.RegisterCombi("Sand1",COMBI,"GrindingStone")

/*---------------------------------------------------------
  Stone to Sand x5
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sand5"
COMBI.Description = [[Converts 5 stone to 5 sand.
You need:
5 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 5

COMBI.Results = {}
COMBI.Results["Sand"] = 5

GMS.RegisterCombi("Sand5",COMBI,"GrindingStone")

/*---------------------------------------------------------
  Stone to Sand x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sand10"
COMBI.Description = [[Converts 10 stone to 10 sand.
You need:
10 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 10

COMBI.Results = {}
COMBI.Results["Sand"] = 10

GMS.RegisterCombi("Sand10",COMBI,"GrindingStone")

/*---------------------------------------------------------
  Grain to Flour x1
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Flour1"
COMBI.Description = [[Converts 2 Grain Seeds to 1 Flour.
You need:
2 Grain Seeds
]]

COMBI.Req = {}
COMBI.Req["Grain_Seeds"] = 2

COMBI.Results = {}
COMBI.Results["Flour"] = 1

GMS.RegisterCombi("Flour1",COMBI,"GrindingStone")

/*---------------------------------------------------------
  Grain to Flour x5
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Flour5"
COMBI.Description = [[Converts 5 Grain Seeds to 3 Flour.
You need:
5 Grain Seeds
]]

COMBI.Req = {}
COMBI.Req["Grain_Seeds"] = 5

COMBI.Results = {}
COMBI.Results["Flour"] = 3

GMS.RegisterCombi("Flour5",COMBI,"GrindingStone")

/*---------------------------------------------------------
  Grain to Flour x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Flour10"
COMBI.Description = [[Converts 10 Grain Seeds to 7 Flour.
You need:
10 Grain Seeds
]]

COMBI.Req = {}
COMBI.Req["Grain_Seeds"] = 10

COMBI.Results = {}
COMBI.Results["Flour"] = 7

GMS.RegisterCombi("Flour10",COMBI,"GrindingStone")

/*---------------------------------------------------------
  All Grain to Flour
  ---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Flour"
COMBI.Description = [[Converts Grain Seeds to Flour.
You need:
Grain Seeds (25 max)
]]

COMBI.Req = {}
COMBI.Req["Grain_Seeds"] = 1

COMBI.Results = {}
COMBI.Results["Flour"] = 1

COMBI.AllSmelt = true
COMBI.Max = 25

GMS.RegisterCombi("AllFlour",COMBI,"GrindingStone")

/*---------------------------------------------------------

  Generic

---------------------------------------------------------*/
/*---------------------------------------------------------
  Flour
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Flour"
COMBI.Description = [[Flour can be used for making dough.
You need:
1 Stone
2 Grain Seeds
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 1
COMBI.Req["Grain_Seeds"] = 2

COMBI.Results = {}
COMBI.Results["Flour"] = 1
COMBI.Results["Stone"] = 1

GMS.RegisterCombi("Flour",COMBI,"Generic")
/*---------------------------------------------------------
  Spice
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Spices"
COMBI.Description = [[Spice can be used for various meals.
You need:
1 Stone
2 Herbs
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 1
COMBI.Req["Herbs"] = 2

COMBI.Results = {}
COMBI.Results["Spices"] = 1
COMBI.Results["Stone"] = 1

GMS.RegisterCombi("Spices",COMBI,"Generic")
/*---------------------------------------------------------
  Dough
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Dough"
COMBI.Description = [[Dough is used for baking.
You need:
1 Bottle of water
2 Flour
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 1
COMBI.Req["Flour"] = 2

COMBI.Results = {}
COMBI.Results["Dough"] = 1

GMS.RegisterCombi("Dough",COMBI,"Generic")

/*---------------------------------------------------------
  Dough x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Dough x10"
COMBI.Description = [[Dough is used for baking.
You need:
7 Bottles of water
15 Flour
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 7
COMBI.Req["Flour"] = 15

COMBI.Results = {}
COMBI.Results["Dough"] = 10

GMS.RegisterCombi("Doughx10",COMBI,"Generic")
/*---------------------------------------------------------
  Rope
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Rope"
COMBI.Description = [[Rope to use rope tool.
You need:
5 Herbs
1 Bottle of water
2 Wood
]]

COMBI.Req = {}
COMBI.Req["Herbs"] = 5
COMBI.Req["Wood"] = 2
COMBI.Req["Water_Bottles"] = 1

COMBI.Results = {}
COMBI.Results["Rope"] = 1

GMS.RegisterCombi("Rope",COMBI,"Generic")
/*---------------------------------------------------------
  Welder
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Welder"
COMBI.Description = [[Welder to use weld tool.
You need:
10 Wood
10 stone
1 Bottle of water
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 10
COMBI.Req["Stone"] = 10
COMBI.Req["Water_Bottles"] = 1

COMBI.Results = {}
COMBI.Results["Welder"] = 1

GMS.RegisterCombi("Welder",COMBI,"Generic")
/*---------------------------------------------------------
  Concrete
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Concrete"
COMBI.Description = [[Concrete can be used for spawning concrete props.
You need:
5 Sand
2 Bottle of water
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 5
COMBI.Req["Water_Bottles"] = 2

COMBI.Results = {}
COMBI.Results["Concrete"] = 1

GMS.RegisterCombi("Concrete",COMBI,"Generic")
/*---------------------------------------------------------
  Urine
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Urine"
COMBI.Description = [[Drink some water and wait, used in gunpowder production.
You need:
2 Bottles of water
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 2

COMBI.Results = {}
COMBI.Results["Urine_Bottles"] = 1

GMS.RegisterCombi("Urine",COMBI,"Generic")
/*---------------------------------------------------------
  Urine
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Urine x10"
COMBI.Description = [[Drink loads of water and wait, messy, but used in gunpowder production.
You need:
20 Bottles of water
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 20

COMBI.Results = {}
COMBI.Results["Urine_Bottles"] = 10

GMS.RegisterCombi("Urine10",COMBI,"Generic")
/*---------------------------------------------------------
  Medicine
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Medicine"
COMBI.Description = [[To restore your health.
You need:
5 Herbs
2 Bottles of water
1 Bottle of Urine

Health initial quality: 10%]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 2
COMBI.Req["Herbs"] = 5
COMBI.Req["Urine_Bottles"] = 1

COMBI.Results = {}
COMBI.Results["Medicine"] = 1

GMS.RegisterCombi("Medicine",COMBI,"Generic")
/*---------------------------------------------------------

  Cooking

---------------------------------------------------------*/
/*---------------------------------------------------------
  Casserole
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Casserole"
COMBI.Description = [[Put a little spiced trout over the fire to make this delicious casserole.
You need:
1 Trout
3 Herbs

Food initial quality: 40%
]]

COMBI.Req = {}
COMBI.Req["Trout"] = 1
COMBI.Req["Herbs"] = 3
COMBI.FoodValue = 400

GMS.RegisterCombi("Casserole",COMBI,"Cooking")
/*---------------------------------------------------------
  Fried meat
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Fried Meat"
COMBI.Description = [[Simple fried meat.
You need:
1 Meat

Food initial quality: 25%]]

COMBI.Req = {}
COMBI.Req["Meat"] = 1

COMBI.FoodValue = 250

GMS.RegisterCombi("FriedMeat",COMBI,"Cooking")
/*---------------------------------------------------------
  Sushi
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sushi"
COMBI.Description = [[For when you like your fish raw.
You need:
2 Bass

Food initial quality: 30%]]

COMBI.Req = {}
COMBI.Req["Bass"] = 2

COMBI.FoodValue = 300

GMS.RegisterCombi("Sushi",COMBI,"Cooking")
/*---------------------------------------------------------
  Fish soup
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Fish Soup"
COMBI.Description = [[Fish soup, pretty good!
You need:
1 Bass
1 Trout
2 Spices
2 Water Bottles
Cooking Level 2

Food initial quality: 40%]]

COMBI.Req = {}
COMBI.Req["Bass"] = 1
COMBI.Req["Trout"] = 1
COMBI.Req["Spices"] = 2
COMBI.Req["Water_Bottles"] = 2

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 2

COMBI.FoodValue = 400

GMS.RegisterCombi("FishSoup",COMBI,"Cooking")
/*---------------------------------------------------------
  Meatballs
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Meatballs"
COMBI.Description = [[Processed meat.
You need:
1 Meat
1 Spices
1 Bottle of water
Cooking Level 2

Food initial quality: 40%]]

COMBI.Req = {}
COMBI.Req["Meat"] = 1
COMBI.Req["Spices"] = 1
COMBI.Req["Water_Bottles"] = 1

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 2

COMBI.FoodValue = 400

GMS.RegisterCombi("Meatballs",COMBI,"Cooking")
/*---------------------------------------------------------
  Fried fish
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Fried Fish"
COMBI.Description = [[Simple fried fish.
You need:
1 Bass

Food initial quality: 20%]]

COMBI.Req = {}
COMBI.Req["Bass"] = 1
COMBI.FoodValue = 200

GMS.RegisterCombi("FriedFish",COMBI,"Cooking")
/*---------------------------------------------------------
  Berry Pie
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Berry Pie"
COMBI.Description = [[Yummy, berry pie reminds me of home!
You need:
2 Dough
2 Water bottles
5 Berries
Cooking Level 5

Food initial quality: 70%]]

COMBI.Req = {}
COMBI.Req["Dough"] = 2
COMBI.Req["Water_Bottles"] = 2
COMBI.Req["Berries"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 5

COMBI.FoodValue = 700

GMS.RegisterCombi("BerryPie",COMBI,"Cooking")
/*---------------------------------------------------------
  Rock cake
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Rock Cake"
COMBI.Description = [[Crunchy!
You need:
2 Iron
1 Herbs
 
Food initial quality: 5%
]]
 
COMBI.Req = {}
COMBI.Req["Iron"] = 2
COMBI.Req["Herbs"] = 1
COMBI.FoodValue = 50
 
GMS.RegisterCombi("Rock_Cake", COMBI, "Cooking")
/*---------------------------------------------------------
  Salad
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Salad"
COMBI.Description = [[Everything for survival, I guess.
You need:
2 Herbs

Food initial quality: 10%
]]
 
COMBI.Req = {}
COMBI.Req["Herbs"] = 2
COMBI.FoodValue = 100
 
GMS.RegisterCombi("Salad", COMBI, "Cooking")
/*---------------------------------------------------------
  Meal
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Meal"
COMBI.Description = [[The ultimate meal. Delicious!
You need:
5 Herbs
1 Salmon
1 Meat
3 Spices
Cooking Level 20

Food initial quality: 100%
]]
 
COMBI.Req = {}
COMBI.Req["Herbs"] = 5
COMBI.Req["Salmon"] = 1
COMBI.Req["Meat"] = 2
COMBI.Req["Spices"] = 3

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 20

COMBI.FoodValue = 1000
 
GMS.RegisterCombi("Meal", COMBI, "Cooking")
/*---------------------------------------------------------
  Shark soup
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Shark soup"
COMBI.Description = [[Man this is good.
You need:
2 Shark
3 Herbs
2 Spices
Cooking Level 15

Food initial quality: 85%]]

COMBI.Req = {}
COMBI.Req["Shark"] = 2
COMBI.Req["Herbs"] = 3
COMBI.Req["Spices"] = 2

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 15

COMBI.FoodValue = 850

GMS.RegisterCombi("Sharksoup",COMBI,"Cooking")
/*---------------------------------------------------------
  Bread
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Bread"
COMBI.Description = [[Good old bread.
You need:
2 Dough
1 Bottle of water
Cooking Level 5

Food initial quality: 80%
]]
 
COMBI.Req = {}
COMBI.Req["Dough"] = 2
COMBI.Req["Water_Bottles"] = 1

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 5

COMBI.FoodValue = 800

GMS.RegisterCombi("Bread", COMBI, "Cooking")
/*---------------------------------------------------------
  Hamburger
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Hamburger"
COMBI.Description = [[A hamburger! Yummy!
You need:
2 Dough
1 Bottle of water
2 Meat
Cooking Level 3

Food initial quality: 85%
]]
 
COMBI.Req = {}
COMBI.Req["Dough"] = 2
COMBI.Req["Water_Bottles"] = 1
COMBI.Req["Meat"] = 2

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 3

COMBI.FoodValue = 850
 
GMS.RegisterCombi("Burger", COMBI, "Cooking")
/*---------------------------------------------------------

  Weapons crafting

---------------------------------------------------------*/
/*---------------------------------------------------------
  Stone Hatchet
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stone Hatchet"
COMBI.Description = [[This small stone axe is ideal for chopping down trees.
You need:
5 Stone
10 Wood
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 5
COMBI.Req["Wood"] = 10

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_stonehatchet"

GMS.RegisterCombi("Stone_Hatchet",COMBI,"StoneWeapons")
/*---------------------------------------------------------
  Copper Hatchet
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Copper Hatchet"
COMBI.Description = [[This copper axe is ideal for chopping down trees.
You need:
10 Copper
10 Wood
]]

COMBI.Req = {}
COMBI.Req["Copper"] = 10
COMBI.Req["Wood"] = 10

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_copperhatchet"

GMS.RegisterCombi("Copper_Hatchet",COMBI,"CopperWeapons")
/*---------------------------------------------------------
  Iron Hatchet
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Iron Hatchet"
COMBI.Description = [[This iron axe is ideal for chopping down trees.
You need:
25 Iron
5 Wood
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 25
COMBI.Req["Wood"] = 5

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_ironhatchet"

GMS.RegisterCombi("Iron_Hatchet",COMBI,"IronWeapons")
/*---------------------------------------------------------
  Wooden Spoon
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Wooden Spoon"
COMBI.Description = [[Allows you to salvage more seeds from consumed fruit.
You need:
5 Wood
Weapon Crafting Level 3
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 3

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_woodenspoon"

GMS.RegisterCombi("Wooden_Spoon",COMBI,"StoneWeapons")
/*---------------------------------------------------------
  Stone Pickaxe
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stone Pickaxe"
COMBI.Description = [[This stone pickaxe is used for effectively mining stone and copper ore.
You need:
10 Stone
5 Wood
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 10
COMBI.Req["Wood"] = 5
COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_stonepickaxe"

GMS.RegisterCombi("Stone_Pickaxe",COMBI,"StoneWeapons")
/*---------------------------------------------------------
  Copper Pickaxe
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Copper Pickaxe"
COMBI.Description = [[This copper pickaxe is used for effectively mining stone, copper ore and iron ore.
You need:
15 Copper
5 Wood
]]

COMBI.Req = {}
COMBI.Req["Copper"] = 15
COMBI.Req["Wood"] = 5

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_copperpickaxe"

GMS.RegisterCombi("Copper_Pickaxe",COMBI,"CopperWeapons")
/*---------------------------------------------------------
  Iron Pickaxe
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Iron Pickaxe"
COMBI.Description = [[This iron pickaxe is used for effectively mining stone, copper ore and iron ore.
You need:
25 Iron
5 Wood
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 25
COMBI.Req["Wood"] = 5
COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_ironpickaxe"

GMS.RegisterCombi("Iron_Pickaxe",COMBI,"IronWeapons")
/*---------------------------------------------------------
  Fishing rod
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Wooden Fishing Rod"
COMBI.Description = [[This rod of wood can be used to fish from a lake.
You need:
1 Rope
20 Wood
Weapon Crafting Level 4
]]

COMBI.Req = {}
COMBI.Req["Rope"] = 1
COMBI.Req["Wood"] = 20

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 4

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_woodenfishingrod"

GMS.RegisterCombi("Wooden_FishingRod",COMBI,"StoneWeapons")
/*---------------------------------------------------------
  Frying pan
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Frying Pan"
COMBI.Description = [[This kitchen tool is used for more effective cooking.
You need:
20 Copper
5 Wood
Weapon Crafting Level 5
]]

COMBI.Req = {}
COMBI.Req["Copper"] = 20
COMBI.Req["Wood"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 5

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_fryingpan"

GMS.RegisterCombi("Fryingpan",COMBI,"CopperWeapons")
/*---------------------------------------------------------
  Sickle
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sickle"
COMBI.Description = [[This tool effectivizes harvesting.
You need:
5 Iron
15 Wood
Weapon Crafting Level 7
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 5
COMBI.Req["Wood"] = 15

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 7

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_sickle"

GMS.RegisterCombi("Sickle",COMBI,"IronWeapons")
/*---------------------------------------------------------
  Strainer
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Strainer"
COMBI.Description = [[This tool can filter the earth for resources.
You need:
5 Iron
5 Wood
Weapon Crafting Level 10
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 5
COMBI.Req["Wood"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 10

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_strainer"

GMS.RegisterCombi("Strainer",COMBI,"IronWeapons")
/*---------------------------------------------------------
  Shovel
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Shovel"
COMBI.Description = [[This tool can dig up rocks, and decreases forage times.
You need:
15 Copper
15 Wood
Weapon Crafting Level 8
]]

COMBI.Req = {}
COMBI.Req["Copper"] = 15
COMBI.Req["Wood"] = 15

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 8

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_shovel"

GMS.RegisterCombi("Shovel",COMBI,"CopperWeapons")
/*---------------------------------------------------------
  Crowbar
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Crowbar"
COMBI.Description = [[This weapon is initially a tool, but pretty useless for it's original purpose on a stranded Island.
It works well as a weapon, though.
You need:
20 Copper
20 Iron
Weapon Crafting Level 6
]]

COMBI.Req = {}
COMBI.Req["Copper"] = 20
COMBI.Req["Iron"] = 20

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 6

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "weapon_crowbar"

GMS.RegisterCombi("Crowbar",COMBI,"CopperWeapons")
/*---------------------------------------------------------
  Advanced Fishing rod
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Advanced Fishing rod"
COMBI.Description = [[With this Fishing rod you can catch rare fish even faster. You might even catch something big.
You need:
25 Iron
30 Wood
2 Rope
Weapon Crafting Level 15
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 25
COMBI.Req["Wood"] = 30
COMBI.Req["Rope"] = 2

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 15

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_advancedfishingrod"

GMS.RegisterCombi("AdvancedFishingRod",COMBI,"IronWeapons")
/*---------------------------------------------------------
  Toolgun
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Toolgun"
COMBI.Description = [[Vital to long term survival, it allows you to easily build complex structures.
You need:
30 Iron
20 Wood
Weapon Crafting Level 14
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 30
COMBI.Req["Wood"] = 20

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 14

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gmod_tool"

GMS.RegisterCombi("Toolgun",COMBI,"IronWeapons")
/*---------------------------------------------------------

  Gun crafting

---------------------------------------------------------*/
/*---------------------------------------------------------
  Smg
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Smg"
COMBI.Description = [[Will blow the head off the target
You need:
3 Gunslide
2 Gungrip
3 Gunbarrel
3 Gunmagazine
Weapon Crafting Level 20
]]

COMBI.Req = {}
COMBI.Req["Gunslide"] = 3
COMBI.Req["Gungrip"] = 2
COMBI.Req["Gunbarrel"] = 3
COMBI.Req["Gunmagazine"] = 3

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 20

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "weapon_smg1"

GMS.RegisterCombi("smg",COMBI,"Gunmaking")
/*---------------------------------------------------------
  Pistol
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Pistol"
COMBI.Description = [[It's not great, but it does the job
You need:
1 Gunslide
1 Gungrip
1 Gunbarrel
1 Gunmagazine
Weapon Crafting Level 13
]]

COMBI.Req = {}
COMBI.Req["Gunslide"] = 1
COMBI.Req["Gungrip"] = 1
COMBI.Req["Gunbarrel"] = 1
COMBI.Req["Gunmagazine"] = 1

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 13

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "weapon_pistol"

GMS.RegisterCombi("Pistol",COMBI,"Gunmaking")
/*---------------------------------------------------------
  Pistol ammo
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Pistol ammo"
COMBI.Description = [[If you wanna keep using the pistol, you'll need this
You need:
5 Iron
5 Gunpowder
Weapon Crafting Level 13
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 5
COMBI.Req["Gunpowder"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 13

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "item_ammo_pistol"

GMS.RegisterCombi("Pistolammo",COMBI,"Gunmaking")
/*---------------------------------------------------------
  Smg ammo
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Smg ammo"
COMBI.Description = [[If you wanna keep using the smg, you'll need this
You need:
10 Iron
10 Gunpowder
Weapon Crafting Level 20
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 10
COMBI.Req["Gunpowder"] = 10

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 20

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "item_ammo_smg1"

GMS.RegisterCombi("smgammo",COMBI,"Gunmaking")
/*---------------------------------------------------------
  Stunstick
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stunstick"
COMBI.Description = [[This highly advanced, effective melee weapon is useful for hunting down animals and fellow stranded alike.
You need:
40 Iron
Weapon Crafting Level 11
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 40

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 11

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "weapon_stunstick"

GMS.RegisterCombi("Stunstick",COMBI,"Gunmaking")
/*---------------------------------------------------------

  Motorised Utility

---------------------------------------------------------*/

/*---------------------------------------------------------
  Gunslide
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gunslide"
COMBI.Description = [[A piece of a gun
You need:
25 Wood
Weapon Crafting Level 9
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 25

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 9

COMBI.Results = {}
COMBI.Results["Gunslide"] = 1

GMS.RegisterCombi("Gunslide",COMBI,"Utilities")
/*---------------------------------------------------------
  Gunbarrel
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gunbarrel"
COMBI.Description = [[A piece of a gun
You need:
30 Iron
Weapon Crafting Level 11
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 30

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 11

COMBI.Results = {}
COMBI.Results["Gunbarrel"] = 1

GMS.RegisterCombi("Gunbarrel",COMBI,"Utilities")
/*---------------------------------------------------------
  Gungrip
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gungrip"
COMBI.Description = [[A piece of a gun
You need:
30 Iron
Weapon Crafting Level 7
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 30

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 7

COMBI.Results = {}
COMBI.Results["Gungrip"] = 1

GMS.RegisterCombi("Gungrip",COMBI,"Utilities")
/*---------------------------------------------------------
  Gunmagazine
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gunmagazine"
COMBI.Description = [[A piece of a gun
You need:
15 Iron
5 Gunpowder
Weapon Crafting Level 13
]]

COMBI.Req = {}
COMBI.Req["Iron"] = 15
COMBI.Req["Gunpowder"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 13

COMBI.Results = {}
COMBI.Results["Gunmagazine"] = 1

GMS.RegisterCombi("Gunmagazine",COMBI,"Utilities")
/*---------------------------------------------------------
  Saltpetre
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Saltpetre"
COMBI.Description = [[Used in making gunpowder
You need:
1 Urine Bottle
]]

COMBI.Req = {}
COMBI.Req["Urine_Bottles"] = 1

COMBI.Results = {}
COMBI.Results["Saltpetre"] = 1

GMS.RegisterCombi("Saltpetre",COMBI,"Utilities")
/*---------------------------------------------------------
  Saltpetre x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Saltpetre x10"
COMBI.Description = [[Used in making gunpowder
You need:
10 Urine Bottles
]]

COMBI.Req = {}
COMBI.Req["Urine_Bottles"] = 10

COMBI.Results = {}
COMBI.Results["Saltpetre"] = 10

GMS.RegisterCombi("Saltpetre10",COMBI,"Utilities")
/*---------------------------------------------------------
  Gunpowder
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gunpowder"
COMBI.Description = [[Explosive!
You need:
10 Charcoal
10 Saltpetre
5 Sulphur
]]

COMBI.Req = {}
COMBI.Req["Sulphur"] = 5
COMBI.Req["Charcoal"] = 10
COMBI.Req["Saltpetre"] = 10

COMBI.Results = {}
COMBI.Results["Gunpowder"] = 10

GMS.RegisterCombi("Gunpowder",COMBI,"Utilities")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   