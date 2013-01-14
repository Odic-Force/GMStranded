/*---------------------------------------------------------
  ChatCommand system
---------------------------------------------------------*/
GMS.ChatCommands = {}
function GMS.RegisterChatCmd( cmd, tbl )
    GMS.ChatCommands[cmd] = tbl
end

function GMS.RunChatCmd( ply, ... )
	if # arg > 0 and GMS.ChatCommands[ arg[1] ] != nil then
		if ply:GetNWString( "AFK" ) != 1 or (ply:GetNWString( "AFK" ) == 1 and	arg[1] == "!afk")  then
			local cmd = arg[1]
			table.remove( arg, 1)
			GMS.ChatCommands[cmd]:Run( ply, unpack( arg ) )
			return ""
		end
	end
end

/*---------------------------------------------------------
  Help List
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!help"
CHATCMD.Desc = "- This help command"
function CHATCMD:Run( ply, ... )
	ply:PrintMessage( HUD_PRINTTALK, "GMStranded Added Chat Commands:" )
	for _, v in pairs(GMS.ChatCommands) do
		if v.Command != nil and v.Desc != nil then
			ply:PrintMessage( HUD_PRINTTALK, "    "..v.Command.." "..v.Desc )
		end
	end
	ply:PrintMessage( HUD_PRINTTALK, "Open console to read easier." )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Resource Drop
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!drop"
CHATCMD.Desc = "<ResourceType> <Amount> - No amount will drop all"
CHATCMD.Function = GM.DropResource
CHATCMD.CCName = "GMS_DropResources"
function CHATCMD:Run( ply, ... )
	arg[2] = {arg[1],arg[2]}
	arg[1] = self.CCName
	self.Function( ply, unpack(arg) )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Sleep
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!sleep"
CHATCMD.Desc = "- Goto sleep"
CHATCMD.Function = GM.PlayerSleep
CHATCMD.CCName = "GMS_Sleep"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Stuck
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!stuck"
CHATCMD.Desc = "- For when you are stuck"
CHATCMD.Function = GM.PlayerStuck
CHATCMD.CCName = "GMS_Stuck"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Admin Resource Drop
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!adrop"
CHATCMD.Desc = "<ResourceType> <Amount> - drops a specified of resources out of nowhere. Admin only."
CHATCMD.Function = GM.ADropResource
CHATCMD.CCName = "GMS_ADropResources"
function CHATCMD:Run( ply, ... )
	arg[2] = {arg[1],arg[2]}
	arg[1] = self.CCName
	self.Function( ply, unpack(arg) )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)      

/*---------------------------------------------------------
  Admin Tool Drop
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!atool"
CHATCMD.Desc = "<ToolName> - drops a tool. Admin only."
CHATCMD.Function = GM.ADropTool
CHATCMD.CCName = "GMS_ADropTools"
function CHATCMD:Run( ply, ... )
	arg[2] = {arg[1],arg[2]}
	arg[1] = self.CCName
	self.Function( ply, unpack(arg) )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)


/*---------------------------------------------------------
  Wakeup
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!wakeup"
CHATCMD.Desc = "- Wakeup from sleep"
CHATCMD.Function = GM.PlayerWake
CHATCMD.CCName = "GMS_WakeUp"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  CampFire
---------------------------------------------------------*/
local CHATCMD = {}
CHATCMD.Command = "!campfire"
CHATCMD.Desc = "- Make wood into a camp fire"
CHATCMD.Function = GM.MakeCampfire
CHATCMD.CCName = "GMS_Makefire"
function CHATCMD:Run( ply )
	self.Function( ply )
end
GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Drink
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!drink"
CHATCMD.Desc = "- Drink a water bottle"
CHATCMD.Function = GM.DrinkFromBottle
CHATCMD.CCName = "GMS_DrinkBottle"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Plant Melon
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!melon"
CHATCMD.Desc = "- Plant a watermelon"
CHATCMD.Function = GM.PlantMelon
CHATCMD.CCName = "GMS_PlantMelon"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Plant Banana
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!banana"
CHATCMD.Desc = "- Plant a banana"
CHATCMD.Function = GM.PlantBanana
CHATCMD.CCName = "GMS_PlantBanana"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Plant Orange
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!orange"
CHATCMD.Desc = "- Plant an orange"
CHATCMD.Function = GM.PlantOrange
CHATCMD.CCName = "GMS_PlantOrange"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Plant Grain
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!grain"
CHATCMD.Desc = "- Plant grain"
CHATCMD.Function = GM.PlantGrain
CHATCMD.CCName = "GMS_PlantGrain"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Plant Berry Bush
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!berrybush"
CHATCMD.Desc = "- Plant berry bush"
CHATCMD.Function = GM.PlantBush
CHATCMD.CCName = "GMS_PlantBush"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Plant Tree
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!tree"
CHATCMD.Desc = "- Plant tree"
CHATCMD.Function = GM.PlantTree
CHATCMD.CCName = "GMS_PlantTree"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Drop Weapon
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!dropweapon"
CHATCMD.Desc = "- Drop your weapon"
CHATCMD.Function = GM.DropWeapon
CHATCMD.CCName = "gms_DropWeapon"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
	Resource Take
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!take"
CHATCMD.Desc = "<ResourceType> <Amount> - No amount will take as much as you can carry"
CHATCMD.Function = GM.TakeResource
CHATCMD.CCName = "GMS_TakeResources"
function CHATCMD:Run( ply, ... )
	arg[2] = {arg[1],arg[2]}
	arg[1] = self.CCName
	self.Function( ply, unpack(arg) )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Take Medicine
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!medicine"
CHATCMD.Desc = "- Take a Medicine"
CHATCMD.Function = GM.TakeAMedicine
CHATCMD.CCName = "GMS_TakeMedicine"
function CHATCMD:Run( ply )
	self.Function( ply )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)

/*---------------------------------------------------------
  Go Afk
---------------------------------------------------------*/
local CHATCMD = {}

CHATCMD.Command = "!afk"
CHATCMD.Desc = "- Go away from keyboard"
CHATCMD.Function = GM.AFK
CHATCMD.CCName = "GMS_afk"
function CHATCMD:Run( ply )
	self.Function( ply )
	ply:ConCommand( "-menu" )
end

GMS.RegisterChatCmd(CHATCMD.Command,CHATCMD)