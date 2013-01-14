/*---------------------------------------------------------
  Gmod Stranded
---------------------------------------------------------*/
GMS = {}

GM.Name 	= "Gmod Stranded 2.2.1"
GM.Author 	= "jA_cOp, prop_dynamic, Chewgum, Wokkel"
GM.Email 	= ""
GM.Website 	= "http://gmsbugs.tk/"

team.SetUp(20, "Survivalists", Color(255, 255, 255, 255))
team.SetUp(21, "Anonymous", Color(0, 121, 145, 255))
team.SetUp(22, "The Gummies", Color(255, 23, 0, 255))
team.SetUp(23, "The Dynamics", Color(0, 72, 255, 255))
team.SetUp(24, "Scavengers", Color(8, 255, 0, 255))
team.SetUp(1, "The Stranded", Color(200, 200, 0, 255))

--Tables

GMS_SpawnLists = {}
GMS_SpawnLists["SMP - SoftWood"] =
	{
		"models/NightReaper/Softwood/5x5x5_block_small.mdl",
		"models/NightReaper/Softwood/5x5x25_beam_tiny.mdl",
		"models/NightReaper/Softwood/5x5x50_beam_short.mdl",
		"models/NightReaper/Softwood/5x5x75_beam_medium.mdl",
		"models/NightReaper/Softwood/5x5x100_beam_long.mdl",
		"models/NightReaper/Softwood/10x10x10_block_large.mdl",
		"models/NightReaper/Softwood/10x10x25_beam_tiny.mdl",
		"models/NightReaper/Softwood/10x10x50_beam_short.mdl",
		"models/NightReaper/Softwood/10x10x75_beam_medium.mdl",
		"models/NightReaper/Softwood/10x10x100_beam_long.mdl",
		"models/NightReaper/Softwood/5x25x25_panel_flat.mdl",
		"models/NightReaper/Softwood/5x50x25_panel_flat.mdl",
		"models/NightReaper/Softwood/5x50x50_panel_flat.mdl",
		"models/NightReaper/Softwood/5x75x25_panel_flat.mdl",
		"models/NightReaper/Softwood/5x75x50_panel_flat.mdl",
		"models/NightReaper/Softwood/5x75x75_panel_flat.mdl",
		"models/NightReaper/Softwood/5x100x25_panel_flat.mdl",
		"models/NightReaper/Softwood/5x100x75_panel_flat.mdl",
		"models/NightReaper/Softwood/5x100x50_panel_flat.mdl",
		"models/NightReaper/Softwood/5x100x100_panel_flat.mdl",
		"models/NightReaper/Softwood/5x40x85_door.mdl",
		"models/NightReaper/Softwood/5x50x100_doorway.mdl",
		"models/NightReaper/Softwood/5x100x100_doorway.mdl",
		"models/NightReaper/Softwood/5x100x100_double_doorway.mdl",
		"models/NightReaper/Softwood/5x50x100_window.mdl",
		"models/NightReaper/Softwood/5x50x100_high_window.mdl",
		"models/NightReaper/Softwood/5x50x100_full_window.mdl",
		"models/NightReaper/Softwood/5x100x100_window.mdl",
		"models/NightReaper/Softwood/5x100x100_high_window.mdl",
		"models/NightReaper/Softwood/5x100x100_full_window.mdl"
	}
GMS_SpawnLists["SMP - HardWood"] =
	{
		"models/NightReaper/Hardwood/5x5x5_block_small.mdl",
		"models/NightReaper/Hardwood/5x5x25_beam_tiny.mdl",
		"models/NightReaper/Hardwood/5x5x50_beam_short.mdl",
		"models/NightReaper/Hardwood/5x5x75_beam_medium.mdl",
		"models/NightReaper/Hardwood/5x5x100_beam_long.mdl",
		"models/NightReaper/Hardwood/10x10x10_block_large.mdl",
		"models/NightReaper/Hardwood/10x10x25_beam_tiny.mdl",
		"models/NightReaper/Hardwood/10x10x50_beam_short.mdl",
		"models/NightReaper/Hardwood/10x10x75_beam_medium.mdl",
		"models/NightReaper/Hardwood/10x10x100_beam_long.mdl",
		"models/NightReaper/Hardwood/5x25x25_panel_flat.mdl",
		"models/NightReaper/Hardwood/5x50x25_panel_flat.mdl",
		"models/NightReaper/Hardwood/5x50x50_panel_flat.mdl",
		"models/NightReaper/Hardwood/5x75x25_panel_flat.mdl",
		"models/NightReaper/Hardwood/5x75x50_panel_flat.mdl",
		"models/NightReaper/Hardwood/5x75x75_panel_flat.mdl",
		"models/NightReaper/Hardwood/5x100x25_panel_flat.mdl",
		"models/NightReaper/Hardwood/5x100x75_panel_flat.mdl",
		"models/NightReaper/Hardwood/5x100x50_panel_flat.mdl",
		"models/NightReaper/Hardwood/5x100x100_panel_flat.mdl",
		"models/NightReaper/Hardwood/5x40x85_door.mdl",
		"models/NightReaper/Hardwood/5x50x100_doorway.mdl",
		"models/NightReaper/Hardwood/5x100x100_doorway.mdl",
		"models/NightReaper/Hardwood/5x100x100_double_doorway.mdl",
		"models/NightReaper/Hardwood/5x50x100_window.mdl",
		"models/NightReaper/Hardwood/5x50x100_high_window.mdl",
		"models/NightReaper/Hardwood/5x50x100_full_window.mdl",
		"models/NightReaper/Hardwood/5x100x100_window.mdl",
		"models/NightReaper/Hardwood/5x100x100_high_window.mdl",
		"models/NightReaper/Hardwood/5x100x100_full_window.mdl"
	}
GMS_SpawnLists["SMP - Concrete"] =
	{
		"models/NightReaper/Concrete/5x5x5_block_small.mdl",
		"models/NightReaper/Concrete/5x5x25_beam_tiny.mdl",
		"models/NightReaper/Concrete/5x5x50_beam_short.mdl",
		"models/NightReaper/Concrete/5x5x75_beam_medium.mdl",
		"models/NightReaper/Concrete/5x5x100_beam_long.mdl",
		"models/NightReaper/Concrete/10x10x10_block_large.mdl",
		"models/NightReaper/Concrete/10x10x25_beam_tiny.mdl",
		"models/NightReaper/Concrete/10x10x50_beam_short.mdl",
		"models/NightReaper/Concrete/10x10x75_beam_medium.mdl",
		"models/NightReaper/Concrete/10x10x100_beam_long.mdl",
		"models/NightReaper/Concrete/5x25x25_panel_flat.mdl",
		"models/NightReaper/Concrete/5x50x25_panel_flat.mdl",
		"models/NightReaper/Concrete/5x50x50_panel_flat.mdl",
		"models/NightReaper/Concrete/5x75x25_panel_flat.mdl",
		"models/NightReaper/Concrete/5x75x50_panel_flat.mdl",
		"models/NightReaper/Concrete/5x75x75_panel_flat.mdl",
		"models/NightReaper/Concrete/5x100x25_panel_flat.mdl",
		"models/NightReaper/Concrete/5x100x75_panel_flat.mdl",
		"models/NightReaper/Concrete/5x100x50_panel_flat.mdl",
		"models/NightReaper/Concrete/5x100x100_panel_flat.mdl",
		"models/NightReaper/Concrete/5x40x85_door.mdl",
		"models/NightReaper/Concrete/5x50x100_doorway.mdl",
		"models/NightReaper/Concrete/5x100x100_doorway.mdl",
		"models/NightReaper/Concrete/5x100x100_double_doorway.mdl",
		"models/NightReaper/Concrete/5x50x100_window.mdl",
		"models/NightReaper/Concrete/5x50x100_high_window.mdl",
		"models/NightReaper/Concrete/5x50x100_full_window.mdl",
		"models/NightReaper/Concrete/5x100x100_window.mdl",
		"models/NightReaper/Concrete/5x100x100_high_window.mdl",
		"models/NightReaper/Concrete/5x100x100_full_window.mdl"
	}
GMS_SpawnLists["SMP - Miscellaneous"] =
	{
		"models/NightReaper/Glass/1x40x40_glass.mdl",
		"models/NightReaper/Glass/1x40x50_glass.mdl",
		"models/NightReaper/Glass/1x90x40_glass.mdl",
		"models/NightReaper/Glass/1x90x50_glass.mdl",
		"models/NightReaper/Glass/1x90x90_glass.mdl"
	}
GMS_SpawnLists["Wood - Tables/Desks"] =
	{
		"models/props_c17/FurnitureDrawer003a.mdl",
		"models/props_c17/FurnitureDrawer002a.mdl",
		"models/props_c17/FurnitureTable003a.mdl",
		"models/props_c17/FurnitureDrawer001a.mdl",
		"models/props_c17/FurnitureTable001a.mdl",
		"models/props_c17/FurnitureTable002a.mdl",
		"models/props_interiors/Furniture_Desk01a.mdl",
		"models/props_interiors/Furniture_Vanity01a.mdl",
		"models/props_wasteland/cafeteria_table001a.mdl"
	}
GMS_SpawnLists["Wood - Shelving/Storage"] =
	{
		"models/props_c17/FurnitureShelf001b.mdl",
		"models/props_wasteland/prison_shelf002a.mdl",
		"models/props_junk/wood_crate001a.mdl",
		"models/props_junk/wood_crate001a_damaged.mdl",
		"models/props_junk/wood_crate002a.mdl",
		"models/props_wasteland/laundry_cart002.mdl",
		"models/props_c17/FurnitureShelf001a.mdl",
		"models/props_interiors/Furniture_shelf01a.mdl",
		"models/props_c17/shelfunit01a.mdl",
		"models/props_c17/FurnitureDresser001a.mdl"
	}
GMS_SpawnLists["Wood - Seating"] =
	{
		"models/props_c17/FurnitureChair001a.mdl",
		"models/props_interiors/Furniture_chair01a.mdl",
		"models/props_c17/playground_swingset_seat01a.mdl",
		"models/props_c17/playground_teetertoter_seat.mdl",
		"models/props_wasteland/cafeteria_bench001a.mdl",
		"models/props_trainstation/BenchOutdoor01a.mdl",
		"models/props_c17/bench01a.mdl",
		"models/props_trainstation/bench_indoor001a.mdl"
	}
GMS_SpawnLists["Wood - Doors/Plating/Beams"] =
	{
		"models/props_debris/wood_board02a.mdl",
		"models/props_debris/wood_board04a.mdl",
		"models/props_debris/wood_board06a.mdl",
		"models/props_debris/wood_board01a.mdl",
		"models/props_debris/wood_board03a.mdl",
		"models/props_debris/wood_board05a.mdl",
		"models/props_debris/wood_board07a.mdl",
		"models/props_junk/wood_pallet001a.mdl",
		"models/props_wasteland/wood_fence02a.mdl",
		"models/props_wasteland/wood_fence01a.mdl",
		"models/props_c17/Frame002a.mdl",
		"models/props_wasteland/barricade001a.mdl",
		"models/props_wasteland/barricade002a.mdl",
		"models/props_docks/channelmarker_gib01.mdl",
		"models/props_docks/channelmarker_gib04.mdl",
		"models/props_docks/channelmarker_gib03.mdl",
		"models/props_docks/channelmarker_gib02.mdl",
		"models/props_docks/dock01_pole01a_128.mdl",
		"models/props_docks/dock02_pole02a_256.mdl",
		"models/props_docks/dock01_pole01a_256.mdl",
		"models/props_docks/dock02_pole02a.mdl",
		"models/props_docks/dock03_pole01a_256.mdl",
		"models/props_docks/dock03_pole01a.mdl"
	}
GMS_SpawnLists["Iron - Cargo/Tanks"] =
	{
		"models/props_wasteland/cargo_container01.mdl",
		"models/props_wasteland/cargo_container01b.mdl",
		"models/props_wasteland/cargo_container01c.mdl",
		"models/props_wasteland/horizontalcoolingtank04.mdl",
		"models/props_wasteland/coolingtank02.mdl",
		"models/props_wasteland/coolingtank01.mdl",
		"models/props_junk/TrashDumpster01a.mdl",
		"models/props_junk/TrashDumpster02.mdl"
	}
GMS_SpawnLists["Iron - Kitchen/Appliances"] =
	{
		"models/props_interiors/SinkKitchen01a.mdl",
		"models/props_interiors/Radiator01a.mdl",
		"models/props_c17/FurnitureWashingmachine001a.mdl",
		"models/props_c17/FurnitureFridge001a.mdl",
		"models/props_interiors/refrigerator01a.mdl",
		"models/props_c17/FurnitureBoiler001a.mdl",
		"models/props_c17/FurnitureFireplace001a.mdl",
		"models/props_wasteland/kitchen_counter001d.mdl",
		"models/props_wasteland/kitchen_counter001b.mdl",
		"models/props_wasteland/kitchen_counter001a.mdl",
		"models/props_wasteland/kitchen_counter001c.mdl",
		"models/props_wasteland/kitchen_stove001a.mdl",
		"models/props_wasteland/kitchen_stove002a.mdl",
		"models/props_wasteland/kitchen_fridge001a.mdl",
		"models/props_wasteland/laundry_dryer001.mdl",
		"models/props_wasteland/laundry_dryer002.mdl",
		"models/props_wasteland/laundry_washer003.mdl",
		"models/props_wasteland/laundry_washer001a.mdl",
		"models/props_wasteland/laundry_basket001.mdl",
		"models/props_wasteland/laundry_basket002.mdl"
	}
GMS_SpawnLists["Iron - Shelving/Storage"] =
	{
		"models/props_c17/FurnitureShelf002a.mdl",
		"models/props_lab/filecabinet02.mdl",
		"models/props_wasteland/controlroom_filecabinet002a.mdl",
		"models/props_wasteland/controlroom_storagecloset001a.mdl",
		"models/props_wasteland/kitchen_shelf002a.mdl",
		"models/props_wasteland/kitchen_shelf001a.mdl",
		"models/props_c17/display_cooler01a.mdl"
	}
GMS_SpawnLists["Iron - Lighting"] =
	{
		"models/props_c17/light_cagelight02_on.mdl",
		"models/props_c17/light_cagelight01_on.mdl",
		"models/props_wasteland/prison_lamp001c.mdl",
		"models/props_wasteland/prison_lamp001a.mdl",
		"models/props_wasteland/prison_lamp001b.mdl",
		"models/props_c17/lamp_standard_off01.mdl",
		"models/props_c17/lamp_bell_on.mdl",
		"models/props_c17/light_decklight01_on.mdl",
		"models/props_c17/light_floodlight02_off.mdl",
		"models/props_wasteland/light_spotlight02_base.mdl",
		"models/props_wasteland/light_spotlight02_lamp.mdl",
		"models/props_wasteland/light_spotlight01_base.mdl",
		"models/props_wasteland/light_spotlight01_lamp.mdl",
		"models/props_trainstation/Column_Light001b.mdl",
		"models/props_trainstation/Column_Light001a.mdl",
		"models/props_trainstation/light_128wallMounted001a.mdl",
		"models/props_c17/LampFixture01a.mdl",
		"models/props_c17/lamppost03a_on.mdl",
		"models/props_c17/Traffic_Light001a.mdl",
		"models/props_trainstation/TrackLight01.mdl",
		"models/props_trainstation/light_Signal002a.mdl",
		"models/props_trainstation/light_Signal001a.mdl",
		"models/props_trainstation/light_Signal001b.mdl"
	}
GMS_SpawnLists["Iron - Containers"] =
	{
		"models/props_junk/garbage_metalcan001a.mdl",
		"models/props_junk/garbage_metalcan002a.mdl",
		"models/props_junk/PopCan01a.mdl",
		"models/props_interiors/pot01a.mdl",
		"models/props_c17/metalPot002a.mdl",
		"models/props_interiors/pot02a.mdl",
		"models/props_c17/metalPot001a.mdl",
		"models/props_junk/metal_paintcan001a.mdl",
		"models/props_junk/metalgascan.mdl",
		"models/props_junk/MetalBucket01a.mdl",
		"models/props_junk/MetalBucket02a.mdl",
		"models/props_trainstation/trashcan_indoor001b.mdl",
		"models/props_trainstation/trashcan_indoor001a.mdl",
		"models/props_c17/oildrum001.mdl",
		"models/props_c17/canister01a.mdl",
		"models/props_c17/canister02a.mdl",
		"models/props_c17/canister_propane01a.mdl"
	}
GMS_SpawnLists["Iron - Signs"] =
	{
		"models/props_c17/streetsign005d.mdl",
		"models/props_c17/streetsign005c.mdl",
		"models/props_c17/streetsign005b.mdl",
		"models/props_c17/streetsign004f.mdl",
		"models/props_c17/streetsign004e.mdl",
		"models/props_c17/streetsign003b.mdl",
		"models/props_c17/streetsign002b.mdl",
		"models/props_c17/streetsign001c.mdl",
		"models/props_trainstation/TrackSign01.mdl",
		"models/props_trainstation/clock01.mdl",
		"models/props_trainstation/trainstation_clock001.mdl"
	}
GMS_SpawnLists["Copper - Signs"] =
	{
		"models/props_trainstation/TrackSign02.mdl",
		"models/props_trainstation/TrackSign03.mdl",
		"models/props_trainstation/TrackSign10.mdl",
		"models/props_trainstation/TrackSign09.mdl",
		"models/props_trainstation/TrackSign08.mdl",
		"models/props_trainstation/TrackSign07.mdl"
	}
GMS_SpawnLists["Iron - Rails"] =
	{
		"models/props_trainstation/handrail_64decoration001a.mdl",
		"models/props_c17/Handrail04_short.mdl",
		"models/props_c17/Handrail04_Medium.mdl",
		"models/props_c17/Handrail04_corner.mdl",
		"models/props_c17/Handrail04_long.mdl",
		"models/props_c17/Handrail04_SingleRise.mdl",
		"models/props_c17/Handrail04_DoubleRise.mdl"
	}
GMS_SpawnLists["Copper - Fencing"] =
	{
		"models/props_wasteland/interior_fence002a.mdl",
		"models/props_wasteland/interior_fence002e.mdl",
		"models/props_wasteland/interior_fence001g.mdl",
		"models/props_wasteland/interior_fence002f.mdl",
		"models/props_wasteland/interior_fence002c.mdl",
		"models/props_wasteland/interior_fence002d.mdl",
		"models/props_wasteland/interior_fence004b.mdl",
		"models/props_wasteland/interior_fence004a.mdl",
		"models/props_wasteland/exterior_fence002a.mdl",
		"models/props_wasteland/exterior_fence003a.mdl",
		"models/props_wasteland/exterior_fence003b.mdl",
		"models/props_wasteland/exterior_fence002c.mdl",
		"models/props_wasteland/exterior_fence002d.mdl",
		"models/props_wasteland/exterior_fence001a.mdl",
		"models/props_wasteland/exterior_fence002e.mdl"
	}
GMS_SpawnLists["Iron - Doors/Plating/Beams"] =
	{
		"models/props_c17/door02_double.mdl",
		"models/props_c17/door01_left.mdl",
		"models/props_borealis/borealis_door001a.mdl",
		"models/props_interiors/refrigeratorDoor02a.mdl",
		"models/props_interiors/refrigeratorDoor01a.mdl",
		"models/props_building_details/Storefront_Template001a_Bars.mdl",
		"models/props_c17/gate_door01a.mdl",
		"models/props_c17/gate_door02a.mdl",
		"models/props_junk/ravenholmsign.mdl",
		"models/props_debris/metal_panel02a.mdl",
		"models/props_debris/metal_panel01a.mdl",
		"models/props_junk/TrashDumpster02b.mdl",
		"models/props_lab/blastdoor001a.mdl",
		"models/props_lab/blastdoor001b.mdl",
		"models/props_lab/blastdoor001c.mdl",
		"models/props_trainstation/trainstation_post001.mdl",
		"models/props_c17/signpole001.mdl",
		"models/props_junk/harpoon002a.mdl",
		"models/props_c17/metalladder002b.mdl",
		"models/props_c17/metalladder002.mdl",
		"models/props_c17/metalladder003.mdl",
		"models/props_c17/metalladder001.mdl",
		"models/props_junk/iBeam01a.mdl",
		"models/props_junk/iBeam01a_cluster01.mdl"
	}
GMS_SpawnLists["Iron - Vehicles"] =
	{
		"models/props_junk/Wheebarrow01a.mdl",
		"models/props_junk/PushCart01a.mdl",
		"models/props_wasteland/gaspump001a.mdl",
		"models/props_wasteland/wheel01.mdl",
		"models/props_wasteland/wheel01a.mdl",
		"models/props_wasteland/wheel03b.mdl",
		"models/props_wasteland/wheel02b.mdl",
		"models/props_wasteland/wheel02a.mdl",
		"models/props_wasteland/wheel03a.mdl",
		"models/props_citizen_tech/windmill_blade002a.mdl",
		"models/airboat.mdl",
		"models/buggy.mdl",
		"models/props_vehicles/car002a_physics.mdl",
		"models/props_vehicles/car001b_hatchback.mdl",
		"models/props_vehicles/car001a_hatchback.mdl",
		"models/props_vehicles/car003a_physics.mdl",
		"models/props_vehicles/car003b_physics.mdl",
		"models/props_vehicles/car004a_physics.mdl",
		"models/props_vehicles/car004b_physics.mdl",
		"models/props_vehicles/car005a_physics.mdl",
		"models/props_vehicles/car005b_physics.mdl",
		"models/props_vehicles/van001a_physics.mdl",
		"models/props_vehicles/truck003a.mdl",
		"models/props_vehicles/truck002a_cab.mdl",
		"models/props_vehicles/trailer002a.mdl",
		"models/props_vehicles/truck001a.mdl",
		"models/props_vehicles/generatortrailer01.mdl",
		"models/props_vehicles/apc001.mdl",
		"models/combine_apc_wheelcollision.mdl",
		"models/props_vehicles/trailer001a.mdl",
		"models/props_trainstation/train003.mdl",
		"models/props_trainstation/train002.mdl",
		"models/props_combine/combine_train02a.mdl",
		"models/props_combine/CombineTrain01a.mdl",
		"models/props_combine/combine_train02b.mdl",
		"models/props_trainstation/train005.mdl"
	}
GMS_SpawnLists["Iron - Seating"] =
	{
		"models/props_c17/chair_stool01a.mdl",
		"models/props_c17/chair02a.mdl",
		"models/props_c17/chair_office01a.mdl",
		"models/props_wasteland/controlroom_chair001a.mdl",
		"models/props_c17/chair_kleiner03a.mdl",
		"models/props_trainstation/traincar_seats001.mdl",
		"models/props_c17/FurnitureBed001a.mdl",
		"models/props_wasteland/prison_bedframe001b.mdl",
		"models/props_c17/FurnitureBathtub001a.mdl",
		"models/props_interiors/BathTub01a.mdl"
	}
GMS_SpawnLists["Iron - Misc/Buttons"] =
	{
		"models/props_c17/TrapPropeller_Lever.mdl",
		"models/props_c17/TrapPropeller_Engine.mdl",
		"models/props_c17/TrapPropeller_Blade.mdl",
		"models/props_junk/sawblade001a.mdl",
		"models/props_trainstation/payphone001a.mdl",
		"models/props_wasteland/prison_throwswitchlever001.mdl",
		"models/props_wasteland/prison_throwswitchbase001.mdl",
		"models/props_wasteland/tram_lever01.mdl",
		"models/props_wasteland/tram_leverbase01.mdl",
		"models/props_wasteland/panel_leverHandle001a.mdl",
		"models/props_wasteland/panel_leverBase001a.mdl",
		"models/props_lab/tpplug.mdl",
		"models/props_lab/tpplugholder_single.mdl",
		"models/props_lab/tpplugholder.mdl",
		"models/props_c17/cashregister01a.mdl"
	}
GMS_SpawnLists["Wood - PHX"] =
	{
		"models/props_phx/construct/wood/wood_boardx1.mdl",
		"models/props_phx/construct/wood/wood_boardx2.mdl",
		"models/props_phx/construct/wood/wood_boardx4.mdl",
		"models/props_phx/construct/wood/wood_panel1x1.mdl",
		"models/props_phx/construct/wood/wood_panel1x2.mdl",
		"models/props_phx/construct/wood/wood_panel2x2.mdl",
		"models/props_phx/construct/wood/wood_panel2x4.mdl",
		"models/props_phx/construct/wood/wood_panel4x4.mdl",
		"models/props_phx/construct/wood/wood_wire1x1.mdl",
		"models/props_phx/construct/wood/wood_wire1x1x1.mdl",
		"models/props_phx/construct/wood/wood_wire1x1x2.mdl",
		"models/props_phx/construct/wood/wood_wire1x1x2b.mdl",
		"models/props_phx/construct/wood/wood_wire1x2.mdl",
		"models/props_phx/construct/wood/wood_wire1x2b.mdl",
		"models/props_phx/construct/wood/wood_wire1x2x2b.mdl",
		"models/props_phx/construct/wood/wood_wire2x2.mdl",
		"models/props_phx/construct/wood/wood_wire2x2b.mdl",
		"models/props_phx/construct/wood/wood_wire2x2x2b.mdl"
	}
GMS_SpawnLists["Iron - PHX"] =
	{
		"models/props_phx/construct/metal_plate1.mdl",
		"models/props_phx/construct/metal_plate1x2.mdl",
		"models/props_phx/construct/metal_plate2x2.mdl",
		"models/props_phx/construct/metal_plate2x4.mdl",
		"models/props_phx/construct/metal_plate4x4.mdl",
		"models/props_phx/construct/metal_wire1x1.mdl",
		"models/props_phx/construct/metal_wire1x1x1.mdl",
		"models/props_phx/construct/metal_wire1x1x2.mdl",
		"models/props_phx/construct/metal_wire1x1x2b.mdl",
		"models/props_phx/construct/metal_wire1x2.mdl",
		"models/props_phx/construct/metal_wire1x2b.mdl",
		"models/props_phx/construct/metal_wire1x2x2b.mdl",
		"models/props_phx/construct/metal_wire2x2.mdl",
		"models/props_phx/construct/metal_wire2x2b.mdl",
		"models/props_phx/construct/metal_wire2x2x2b.mdl"
	}
GMS.TreeModels = {
                 "models/props/de_inferno/tree_large.mdl",
                 "models/props/de_inferno/tree_small.mdl",
                 "models/props_foliage/tree_deciduous_03a.mdl",
                 "models/props_foliage/tree_deciduous_01a.mdl",
                 "models/props_foliage/oak_tree01.mdl",
                 "models/props_foliage/tree_cliff_01a.mdl",
		 "models/props_foliage/tree_deciduous_01a-lod.mdl"
	--HL2:EP2
	--"models/props_foliage/tree_pine04.mdl"
}
                 
GMS.AdditionalTreeModels = {"models/props_foliage/tree_deciduous_02a.mdl"}
                 
GMS.EdibleModels = {
                   "models/props/cs_italy/orange.mdl",
                   "models/props_junk/watermelon01.mdl",
                   "models/props/cs_italy/bananna_bunch.mdl"
                   }
                   
GMS.RockModels = {
                   "models/props_wasteland/rockgranite02a.mdl",
                   "models/props_wasteland/rockgranite02b.mdl",
                   "models/props_wasteland/rockgranite02c.mdl",
                   "models/props_wasteland/rockgranite03a.mdl",
                   "models/props_wasteland/rockgranite03b.mdl",
                   "models/props_wasteland/rockgranite03c.mdl",
                   "models/props_wasteland/rockcliff01b.mdl",
                   "models/props_wasteland/rockcliff01c.mdl",
                   "models/props_wasteland/rockcliff01e.mdl",
                   "models/props_wasteland/rockcliff01f.mdl",
                   "models/props_wasteland/rockcliff01g.mdl",
                   "models/props_wasteland/rockcliff01J.mdl",
                   "models/props_wasteland/rockcliff01k.mdl",
                   "models/props_wasteland/rockcliff05a.mdl",
                   "models/props_wasteland/rockcliff05b.mdl",
                   "models/props_wasteland/rockcliff05e.mdl",
                   "models/props_wasteland/rockcliff05f.mdl",
                   "models/props_wasteland/rockcliff06d.mdl",
                   "models/props_wasteland/rockcliff06i.mdl"
				   }
                   
GMS.AdditionalRockModels = {
							"models/props_canal/rock_riverbed01a.mdl",
                            "models/props_canal/rock_riverbed01b.mdl",
                            "models/props_canal/rock_riverbed01c.mdl",
                            "models/props_canal/rock_riverbed01d.mdl",
                            "models/props_canal/rock_riverbed02a.mdl",
                            "models/props_canal/rock_riverbed02b.mdl",
                            "models/props_canal/rock_riverbed02c.mdl",
                            "models/props_wasteland/rockcliff_cluster01b.mdl",
                            "models/props_wasteland/rockcliff_cluster02a.mdl",
                            "models/props_wasteland/rockcliff_cluster02b.mdl",
                            "models/props_wasteland/rockcliff_cluster02c.mdl",
                            "models/props_wasteland/rockcliff_cluster03a.mdl",
                            "models/props_wasteland/rockcliff_cluster03b.mdl",
                            "models/props_wasteland/rockcliff_cluster03c.mdl",
                            "models/props_wasteland/rockcliff05a.mdl"
	-- HL2: EP2
	--"models/cliffs/rocks_large03.mdl"
                            }
                   
GMS.SmallRockModel = "models/props_junk/rock001a.mdl"

GMS.PickupProhibitedClasses = {"gms_seed"}
                   
GMS.MaterialResources = {}
GMS.MaterialResources[MAT_CONCRETE] = "Concrete"
GMS.MaterialResources[MAT_METAL] = "Iron"
GMS.MaterialResources[MAT_DIRT] = "Wood"
GMS.MaterialResources[MAT_VENT] = "Copper"
GMS.MaterialResources[MAT_GRATE] = "Copper"
GMS.MaterialResources[MAT_TILE] = "Stone"
GMS.MaterialResources[MAT_SLOSH] = "Wood"
GMS.MaterialResources[MAT_WOOD] = "Wood"
GMS.MaterialResources[MAT_COMPUTER] = "Copper"
GMS.MaterialResources[MAT_GLASS] = "Glass"
GMS.MaterialResources[MAT_FLESH] = "Wood"
GMS.MaterialResources[MAT_BLOODYFLESH] = "Wood"
GMS.MaterialResources[MAT_CLIP] = "Wood"
GMS.MaterialResources[MAT_ANTLION] = "Wood"
GMS.MaterialResources[MAT_ALIENFLESH] = "Wood"
GMS.MaterialResources[MAT_FOLIAGE] = "Wood"
GMS.MaterialResources[MAT_SAND] = "Wood"
GMS.MaterialResources[MAT_PLASTIC] = "Plastic"

GMS.Skills = {}
table.insert(GMS.Skills,"Mining")
--table.insert(GMS.Skills,"Smithing")
table.insert(GMS.Skills,"Harvesting")
table.insert(GMS.Skills,"Cooking")
table.insert(GMS.Skills,"Lumbering")
--table.insert(GMS.Skills,"Carpentry")
table.insert(GMS.Skills,"Survival")
--table.insert(GMS.Skills,"Technology")

GMS.Resources = {}
table.insert(GMS.Resources,"Copper_Ore")
table.insert(GMS.Resources,"Iron_Ore")
table.insert(GMS.Resources,"Stone")
table.insert(GMS.Resources,"Copper")
table.insert(GMS.Resources,"Iron")
table.insert(GMS.Resources,"Metal")
table.insert(GMS.Resources,"Charcoal")
table.insert(GMS.Resources,"Sulphur")
table.insert(GMS.Resources,"Urine_Bottles")
table.insert(GMS.Resources,"Medicine")
table.insert(GMS.Resources,"Saltpetre")
table.insert(GMS.Resources,"Charcoal")
table.insert(GMS.Resources,"Gunslide")
table.insert(GMS.Resources,"Gungrip")
table.insert(GMS.Resources,"Gunbarrel")
table.insert(GMS.Resources,"Gunmagazine")
table.insert(GMS.Resources,"Gunpowder")
table.insert(GMS.Resources,"Wood")
table.insert(GMS.Resources,"Seeds")
table.insert(GMS.Resources,"Sprouts")
table.insert(GMS.Resources,"Trout")
table.insert(GMS.Resources,"Bass")
table.insert(GMS.Resources,"Salmon")
table.insert(GMS.Resources,"Shark")
table.insert(GMS.Resources,"Herbs")
table.insert(GMS.Resources,"Raw_Meat")
table.insert(GMS.Resources,"Glass")
table.insert(GMS.Resources,"Plastic")

GMS.ConVarList = {
                  "gms_FreeBuild",
                  "gms_AllTools",
                  "gms_AutoSave",
                  "gms_AutoSaveTime",
                  "gms_physgun",
                  "gms_ReproduceTrees",
                  "gms_MaxReproducedTrees",
                  "gms_AllowSWEPSpawn",
                  "gms_AllowSENTSpawn",
				  "gms_Alerts",
				  "gms_SpreadFire",
				  "gms_FadeRocks",
				  "gms_CostsScale",
				  "gms_Campfire",
				  "gms_PlantLimit"
                  }

GMS.SavedClasses = {"prop_physics",
                    "prop_physics_override",
                    "prop_physics_multiplayer",
                    "prop_dynamic",
                    "prop_effect",
                    "gms_stoneworkbench",
					"gms_copperworkbench",
					"gms_ironworkbench",
                    "gms_stove",
                    "gms_buildsite",
                    "gms_resourcedrop",
                    "gms_stonefurnace",
					"gms_copperfurnace",
					"gms_ironfurnace",
					"gms_antlionbarrow",
					"gms_loot",
					"gms_factory",
					"gms_gunchunks",
					"gms_gunlab",
					"gms_seed",
					"gms_grindingstone",
					"gms_mail",
					"gms_waterfountain"					
					
                    }

GMS.StructureEntities = {"gms_stoneworkbench",
					"gms_copperworkbench",
					"gms_ironworkbench",
                    "gms_stove",
                    "gms_buildsite",
                    "gms_stonefurnace",
					"gms_copperfurnace",
					"gms_ironfurnace",
					"gms_factory",
					"gms_gunchunks",
					"gms_gunlab",
					"gms_grindingstone",
					"gms_waterfountain"
						}
					
GMS.SleepingFurniture = {
	"models/props_interiors/Furniture_Couch01a.mdl",
	"models/props_c17/FurnitureCouch002a.mdl",
	"models/props_c17/FurnitureCouch001a.mdl",
	"models/props_c17/FurnitureBed001a.mdl",
	"models/props_wasteland/prison_bedframe001b.mdl",
	"models/props_trainstation/traincar_seats001.mdl"
}

GMS.ProhibitedStools = {
	"hydraulic",
	"motor",
	"muscle",
	"nail",
	"pulley",
	"slider",
	"balloon",
	"button",
	"duplicator",
	"dynamite",
	"emitter",
	"hoverball",
	"ignite",
	"keepupright",
	"magnetise",
	"nocollide",
	"physprop",
	"spawner",
	"thruster",
	"turret",
	"wheel",
	"eyeposer",
	"faceposer",
	"finger",
	"inflator",
	"statue",
	"trails"
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               