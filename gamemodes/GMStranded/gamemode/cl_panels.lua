-- The Q Menu
if SERVER then
	AddCSLuaFile( "QMenu/Qmenu.lua" )
	return
end

include( "QMenu/Qmenu.lua" )

Active = false

/*---------------------------------------------------------
  Spawnpanel
---------------------------------------------------------*/
function GM:OnSpawnMenuOpen( )
	if LocalPlayer():GetNWString( "AFK" ) != 1 then
		if MENU == nil or not MENU:IsValid( ) then
			vgui.Create( "GMS_menu" )
		else
			MENU:SetVisible( true )
		end
		gui.EnableScreenClicker( true )
		RestoreCursorPosition( )
	end
end

function GM:OnSpawnMenuClose( )
	if MENU and MENU:IsValid( ) and MENU:IsVisible( ) then
			MENU:SetVisible( false )
		end
		RememberCursorPosition( )
		gui.EnableScreenClicker( false )
end

local PANEL = { }

function PANEL:Init( )

	MENU = self
	self:SetTitle( "Stranded Menu" )
	self.ContentPanel = vgui.Create( "DPropertySheet", self )
	self:ShowCloseButton( false )
	self.ContentPanel:AddSheet( "Construction", vgui.Create( "stranded_PropSpawn", self ), "gui/silkicons/brick_add", true, true )
	self.ContentPanel:AddSheet( "ToolMenu", vgui.Create( "stranded_ToolMenu", self ), "gui/silkicons/wrench", true, true )
	self.ContentPanel:AddSheet( "Planting", vgui.Create( "stranded_PlantSpawn", self ), "gui/silkicons/box", true, true )
	self.ContentPanel:AddSheet( "Tribes", vgui.Create( "stranded_TribesMenu", self ), "gui/silkicons/group", true, true )
	self.ContentPanel:AddSheet( "Commands", vgui.Create( "stranded_Commands", self ), "gui/silkicons/application", true, true )
	self.ContentPanel:AddSheet( "Options", vgui.Create( "stranded_Options", self ), "gui/silkicons/application", true, true )
	self.ContentPanel:AddSheet( "Prop Protection", vgui.Create( "stranded_SPPMenu", self ), "gui/silkicons/shield", true, true )
end

function PANEL:Close( )
	menuup = false
 	self:Remove( )
end

function PANEL:PerformLayout( )

	self:SetSize(ScrW() / 2, ScrH())
	self:SetPos(ScrW() / 2, 0)
	self.ContentPanel:StretchToParent( 4, 26, 4, 4 )
	
	DFrame.PerformLayout( self )

end

vgui.Register( "GMS_menu", PANEL, "DFrame" )

/*---------------------------------------------------------
  Unlock window
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
         self:SetTitle("You unlocked a new ability!")
         self:SetMouseInputEnabled(true)
		 self:MakePopup()
		 
         self.Name = "Name"
         
         self:SetSize(ScrW() / 2, ScrH() / 2)
         self:SetPos(ScrW() / 2 - (self:GetWide() / 2), ScrH() / 2 - (self:GetTall() / 2))

         self.DescWindow = vgui.Create("RichText",self)
         self.DescWindow:SetPos(20,self:GetTall() / 6 + 70)
         self.DescWindow:SetSize(self:GetWide() - 40, self:GetTall() - (self:GetTall() / 6 + 70) - 20)
         self.DescWindow:SetText("Description.")
end
function PANEL:Close()
	self:SetVisible(false)
	gui.EnableScreenClicker(false)
end
function PANEL:Paint()
		
         DFrame.Paint(self)
         draw.SimpleTextOutlined(self.Name,"ScoreboardHead",self:GetWide() / 2,self:GetTall() / 6,Color(10,200,10,255),1,1,0.5,Color(100,100,100,160))
         return true
end

function PANEL:SetUnlock(text)
         local unlock = GMS.FeatureUnlocks[text]
         
         self.Name = unlock.Name
         self.DescWindow:SetText(unlock.Description)
end

vgui.Register("GMS_UnlockWindow",PANEL,"DFrame")
/*---------------------------------------------------------
  GMS dropdown
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
         self.Children = {}
         self.Extended = false
         self.Active = nil
end

function PANEL:SetInitSize(w,h)
         self.InitW = w
         self.InitH = h
         
         self:SetSize(w,h)
end

function PANEL:AddItem(text,value)
         local item = vgui.Create("GMS_DropDown_Item",self)
         item:SetPos(0,self.InitH)
         item:SetSize(self:GetWide(),self.InitH)
         item:SetInfo(text,value)
         
         if !self.Extended then item:SetVisible(false) end
         table.insert(self.Children,item)
end

function PANEL:RemoveItem(text)
         self.Active = nil

         for k,item in pairs(self.Children) do
             if item.Text == text then
                item:Remove()
                item = nil
                table.remove(self.Children,k)
             end
         end
         
         if self.Extended then
            self:Retract()
         else
            self:Extend()
            self:Retract()
         end
end

function PANEL:Clear()
         for k,v in pairs(self.Children) do
             v:Remove()
         end

         self.Children = {}
         self.Active = nil
         self:Retract()
end

function PANEL:SetActive(item)
         if self.Active then
            self.Active.Active = false
         end
         
         if item then item.Active = true end
         self.Active = item
end

function PANEL:Extend()
         self.Extended = true
         local line = self.InitH

         for k,item in pairs(self.Children) do
             item:SetPos(0,line)
             item:SetVisible(true)
             
             line = line + self.InitH
         end
         
         self:SetSize(self.InitW,self.InitH + (#self.Children * self.InitH))
         self:SetZPos(310)
end

function PANEL:Retract()
         self.Extended = false
         
         for k,item in pairs(self.Children) do
             item:SetPos(0,0)
             item:SetVisible(false)
         end
         
         self:SetZPos(300)
         self:SetSize(self.InitW,self.InitH)
end

function PANEL:Paint()
         local col = StrandedColorTheme
         local bordcol = StrandedBorderTheme

         surface.SetDrawColor(0,0,0,255)
         surface.DrawRect(0,0,self:GetWide(),self:GetTall())
         
         surface.SetDrawColor(0,0,0,180)
         surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())
         
         if self.Active then
            draw.SimpleText(self.Active.Text,"Default",5,5,Color(255,255,255,255))
         else
            draw.SimpleText("< select >","Default",5,5,Color(255,255,255,255))
         end

         return true
end

function PANEL:GetValue()
         if self.Active then
            return self.Active.Value or nil
         end
         
         return false
end

function PANEL:GetText()
         if self.Active then
            return self.Active.Text or ""
         end
         
         return ""
end

function PANEL:OnMousePressed(mc)
         if mc != 107 then return end
         if !self.Extended then self:Extend() end
end

vgui.Register("GMS_DropDown",PANEL,"Panel")

/*---------------------------------------------------------
  GMS dropdown item
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
         self.Text = ""
         self.Value = nil
         self.Color = Color(11,11,11,255)
end

function PANEL:SetInfo(text,value)
         self.Text = text
         self.Value = value
end

function PANEL:Paint()
         surface.SetDrawColor(self.Color.r,self.Color.g,self.Color.b,255)
         surface.DrawRect(0,0,self:GetWide(),self:GetTall())

         draw.SimpleText(self.Text,"Default",5,5,Color(255,255,255,255))
         return true
end

function PANEL:OnMousePressed(mc)
         if mc != 107 then return end
         self:GetParent():SetActive(self)
         self:GetParent():Retract()
end

function PANEL:OnCursorEntered()
         self.Color = Color(55,55,55,255)
end

function PANEL:OnCursorExited()
         self.Color = Color(11,11,11,255)
end


vgui.Register("GMS_DropDown_Item",PANEL,"Panel")
/*---------------------------------------------------------
  Resource Drop window
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
         self:SetTitle("Drop Resources")
		 self:SetDeleteOnClose(false)
         self:SetKeyboardInputEnabled(true)
         self:SetMouseInputEnabled(true)
		 self:MakePopup()
         
         self:SetSize(ScrW() / 2, ScrH() / 2)
         self:SetPos(ScrW() / 2 - (self:GetWide() / 2), ScrH() / 2 - (self:GetTall() / 2))

         self.ResourceEntry = vgui.Create("DMultiChoice",self)
         self.ResourceEntry:SetSize(self:GetWide() / 4, 20)
         self.ResourceEntry:SetPos(self:GetWide() / 20, self:GetTall() / 2 - 10)

         local lbl = vgui.Create("DLabel",self)
         lbl:SetPos(self:GetWide() / 20, self:GetTall() / 2 - 35)
         lbl:SetSize(self:GetWide() / 4,20)
         lbl:SetText("Specify resource")
         //lbl:SetFont("ScoreboardText")

         self.AmountEntry = vgui.Create("DTextEntry",self)
         self.AmountEntry:SetSize(self:GetWide() / 6, 20)
         self.AmountEntry:SetPos(self:GetWide() / 20 + self.ResourceEntry:GetWide() + self:GetWide() / 20, self:GetTall() / 2 - 10)
         
         local lbl = vgui.Create("DLabel",self)
         lbl:SetPos(self:GetWide() / 20 + self.ResourceEntry:GetWide() + self:GetWide() / 20, self:GetTall() / 2 - 35)
         lbl:SetSize(self:GetWide() / 6,20)
         lbl:SetText("Specify amount")
         //lbl:SetFont("ScoreboardText")

         local button = vgui.Create("gms_CommandButton",self)
         button:SetSize(self:GetWide() / 3,self:GetTall() / 6)
         button:SetPos(self:GetWide() / 2 - (button:GetWide() / 2), self:GetTall() / 1.5)
         button:SetText("Drop")

         function button.DoClick(button)
               LocalPlayer():ConCommand("gms_DropResources "..string.Trim(self.ResourceEntry.TextEntry:GetValue()).." "..string.Trim(self.AmountEntry:GetValue()).."\n")
               button:GetParent():SetVisible(false)
               self.AmountEntry:SetText("")
               self.ResourceEntry:SetText("")
         end
end

function PANEL:RefreshList()
         self.ResourceEntry:Clear()

         for k,v in pairs(Resources) do
             if v > 0 then
                self.ResourceEntry:AddChoice(k,k)
             end
         end
end

vgui.Register("GMS_ResourceDropWindow",PANEL,"DFrame")

/*---------------------------------------------------------
  Admin menu
---------------------------------------------------------*/
local PANEL = {}

PANEL.CmdButtons = {}
PANEL.CmdButtons["gms_admin_makefood"] = "Spawn food"
PANEL.CmdButtons["gms_admin_makerock"] = "Spawn rock"
PANEL.CmdButtons["gms_admin_maketree"] = "Spawn tree"
PANEL.CmdButtons["gms_admin_makebush"] = "Spawn random plant"
PANEL.CmdButtons["gms_admin_saveallcharacters"] = "Save all characters"

function PANEL:Init()
	self:SetTitle("Admin Menu")
	self:SetDeleteOnClose(false)
	self:SetKeyboardInputEnabled(true)
	self:SetMouseInputEnabled(true)
	self:MakePopup()
	local size = ScrH() / 30
	local space = 10
	self:SetSize(ScrW() / 1.5, ScrH() - 100)
	self:SetPos(ScrW() / 2 - (self:GetWide() / 2), 50)

	local line = 30
	local tab = 0

	//Populate area command stuff
	local button = vgui.Create("gms_CommandButton",self)
	button:SetSize(self:GetWide() / 5, size)
	button:SetPos(10, line)
	button:SetText("Populate Area")

	local tab = tab + button:GetWide() + space + 10

	self.PopulateType = vgui.Create("DMultiChoice",self)
	self.PopulateType:SetSize(button:GetWide(),button:GetTall())
	self.PopulateType:SetPos(tab,line)
	self.PopulateType:AddChoice("Trees","forest")
	self.PopulateType:AddChoice("Rocks","rocks")
	self.PopulateType:AddChoice("Random_Plant","plant")

	local label = vgui.Create("DLabel",self)
	label:SetPos(tab,line - 20)
	label:SetSize(button:GetWide(),20)
	label:SetText("Type")

	local tab = tab + self.PopulateType:GetWide() + space

	self.PopulateAmount = vgui.Create("DTextEntry",self)
	self.PopulateAmount:SetSize(button:GetWide(),button:GetTall())
	self.PopulateAmount:SetPos(tab,line)

	local label = vgui.Create("DLabel",self)
	label:SetPos(tab,line - 20)
	label:SetSize(button:GetWide(),20)
	label:SetText("Amount")

	local tab = tab + self.PopulateType:GetWide() + space

	self.PopulateRadius = vgui.Create("DTextEntry",self)
	self.PopulateRadius:SetSize(button:GetWide(),button:GetTall())
	self.PopulateRadius:SetPos(tab,line)

	local label = vgui.Create("DLabel",self)
	label:SetPos(tab,line - 20)
	label:SetSize(button:GetWide(),20)
	label:SetText("Max radius")

	function button:DoClick()
		local p = self:GetParent()
		local strType = p.PopulateType.TextEntry:GetValue() or ""
		RunConsoleCommand("gms_admin_PopulateArea", strType, string.Trim(p.PopulateAmount:GetValue()), string.Trim(p.PopulateRadius:GetValue()))
	end

	//Set ConVar stuff
	line = line + button:GetTall() + 30
	local tab = 0
	local button = vgui.Create("gms_CommandButton",self)
	button:SetSize(self:GetWide() / 5, size)
	button:SetPos(10, line)
	button:SetText("Set Convar")

	local tab = tab + button:GetWide() + space + 10

	self.ConVarList = vgui.Create("DMultiChoice",self)
	self.ConVarList:SetSize(button:GetWide() * 2 + space,button:GetTall())
	self.ConVarList:SetPos(tab,line)

	for k,v in pairs(GMS.ConVarList) do
	self.ConVarList:AddChoice(v,v)
	end

	local label = vgui.Create("DLabel",self)
	label:SetPos(tab,line - 20)
	label:SetSize(button:GetWide(),20)
	label:SetText("Convar")

	local tab = tab + self.ConVarList:GetWide() + space

	self.ConVarValue = vgui.Create("DTextEntry",self)
	self.ConVarValue:SetSize(button:GetWide(),button:GetTall())
	self.ConVarValue:SetPos(tab,line)

	local label = vgui.Create("DLabel",self)
	label:SetPos(tab,line - 20)
	label:SetSize(button:GetWide(),20)
	label:SetText("Value")

	function button:DoClick()
		local p = self:GetParent()
		local ConVar = p.ConVarList.TextEntry:GetValue() or ""
		RunConsoleCommand(ConVar, string.Trim(p.ConVarValue:GetValue()))
	end
	//Save game stuff
	line = line + button:GetTall() + 30
	local tab = space
	local button = vgui.Create("gms_CommandButton",self)
	button:SetSize(self:GetWide() / 5, size)
	button:SetPos(tab, line)
	button:SetText("Save Game")

	local tab = tab + button:GetWide() + space

	self.SaveGameEntry = vgui.Create("TextEntry",self)
	self.SaveGameEntry:SetSize(button:GetWide(),button:GetTall())
	self.SaveGameEntry:SetPos(tab,line)

	local label = vgui.Create("Label",self)
	label:SetPos(tab,line - 20)
	label:SetSize(button:GetWide(),20)
	label:SetText("Save name")

	function button:DoClick()
		self:GetParent():SetVisible(false)
		RunConsoleCommand("gms_admin_savemap", self:GetParent().SaveGameEntry:GetValue())
	end

	//Load game stuff
	line = line + button:GetTall() + 30
	local tab = space
	local button = vgui.Create("gms_CommandButton",self)
	button:SetSize(self:GetWide() / 5, size)
	button:SetPos(tab, line)
	button:SetText("Load Game")

	local tab = tab + button:GetWide() + space

	local Dbutton = vgui.Create("gms_CommandButton",self)
	Dbutton:SetSize(self:GetWide() / 5, size)
	Dbutton:SetPos(tab, line)
	Dbutton:SetText("Delete")

	local tab = tab + button:GetWide() + space

	self.LoadGameEntry = vgui.Create("GMS_DropDown",self)
	self.LoadGameEntry:SetInitSize(button:GetWide(),button:GetTall())
	self.LoadGameEntry:SetPos(tab,line)

	local label = vgui.Create("Label",self)
	label:SetPos(tab,line - 20)
	label:SetSize(button:GetWide(),20)
	label:SetText("Load name")

	function button:DoClick()
		self:GetParent():SetVisible(false)
		local name = self:GetParent().LoadGameEntry:GetValue() or ""
		RunConsoleCommand("gms_admin_loadmap", name)
	end

	function Dbutton:DoClick()
		local name = self:GetParent().LoadGameEntry:GetValue() or ""
		RunConsoleCommand("gms_admin_deletemap", name)
	end

	//Spawn antlion barrow stuff
	line = line + button:GetTall() + 30
	local tab = space
	local button = vgui.Create("gms_CommandButton",self)
	button:SetSize(self:GetWide() / 5, size)
	button:SetPos(tab, line)
	button:SetText("Make antlion barrow")

	local tab = tab + button:GetWide() + space

	self.MaxAntlions = vgui.Create("DTextEntry",self)
	self.MaxAntlions:SetSize(button:GetWide(),button:GetTall())
	self.MaxAntlions:SetPos(tab,line)

	local label = vgui.Create("DLabel",self)
	label:SetPos(tab,line - 20)
	label:SetSize(button:GetWide(),20)
	label:SetText("Max antlions")

	function button:DoClick()
		RunConsoleCommand("gms_admin_MakeAntlionBarrow", string.Trim(self:GetParent().MaxAntlions:GetValue()))
	end


	//Static command buttons
	line = line + button:GetTall() + 10

	for cmd,txt in pairs(self.CmdButtons) do
		local button = vgui.Create("gms_CommandButton",self)
		button:SetSize(self:GetWide() / 5, size)
		button:SetPos(10, line)
		button:SetConCommand(cmd.."\n")
		button:SetText(txt)

		line = line + button:GetTall() + 10
	end
end

vgui.Register("GMS_AdminMenu",PANEL,"DFrame")

/*---------------------------------------------------------
  Loading bar
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
         self:SetSize(ScrW() / 2.7,ScrH() / 10)
         self:SetPos(ScrW() / 2 - (self:GetWide() / 2),ScrH() / 2 - (self:GetTall() / 2))
         
         self.Dots = "."
         self.Message = ""
end

function PANEL:Paint()
         //Background
         draw.RoundedBox(8,0,0,self:GetWide(),self:GetTall(),Color(100,100,100,150))

         //Text
         draw.SimpleText("Loading"..self.Dots, "ScoreboardHead",self:GetWide() / 2, self:GetTall() / 2,Color(255,255,255,255),1,1)
         draw.SimpleText(self.Text, "ScoreboardText",self:GetWide() / 2, self:GetTall() / 1.2,Color(255,255,255,255),1,1)
         return true
end

function PANEL:Show(msg)
         self.IsStopped = false
         
         self.Text = msg
         timer.Simple(0.5,function() self:UpdateDots(self) end)
         self:SetVisible(true)
end

function PANEL:Hide()
         self.IsStopped = true
         self:SetVisible(false)
end

function PANEL:UpdateDots()
         if self.IsStopped then return end

         if self.Dots == "...." then
            self.Dots = "."
         else
            self.Dots = self.Dots.."."
         end

         timer.Simple(0.5,function() self:UpdateDots(self) end)
end

vgui.Register("gms_LoadingBar",PANEL,"Panel")

/*---------------------------------------------------------
 Saving bar
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
         self:SetSize(ScrW() / 2.7,ScrH() / 10)
         self:SetPos(ScrW() / 2 - (self:GetWide() / 2),ScrH() / 2 - (self:GetTall() / 2))
         
         self.Dots = "."
         self.Message = ""
end

function PANEL:Paint()
         //Background
         draw.RoundedBox(8,0,0,self:GetWide(),self:GetTall(),Color(100,100,100,150))

         //Text
         draw.SimpleText("Saving"..self.Dots, "ScoreboardHead",self:GetWide() / 2, self:GetTall() / 2,Color(255,255,255,255),1,1)
         draw.SimpleText(self.Text, "ScoreboardText",self:GetWide() / 2, self:GetTall() / 1.2,Color(255,255,255,255),1,1)
         return true
end

function PANEL:Show(msg)
         self.IsStopped = false
         
         self.Text = msg
         timer.Simple(0.5,function() self:UpdateDots(self) end)
         self:SetVisible(true)
end

function PANEL:Hide()
         self.IsStopped = true
         self:SetVisible(false)
end

function PANEL:UpdateDots()
         if self.IsStopped then return end

         if self.Dots == "...." then
            self.Dots = "."
         else
            self.Dots = self.Dots.."."
         end

         timer.Simple(0.5,function() self:UpdateDots(self) end)
end

vgui.Register("gms_SavingBar",PANEL,"Panel")

/*---------------------------------------------------------
  Tribe Menu
---------------------------------------------------------*/

local PANEL = {}

function PANEL:Init()
         self:SetTitle("Create-A-Tribe")
		 self:SetDeleteOnClose(false)
         self:SetKeyboardInputEnabled(true)
         self:SetMouseInputEnabled(true)
         self:MakePopup()
         self:SetSize(ScrW() / 4, 350)
         self:SetPos(ScrW() / 2 - (self:GetWide() / 2), 50)
		 self:Center()
         
         local line = 30
         local tab = 0         
        
	local tnamelabel = vgui.Create("DLabel", self)
		tnamelabel:SetPos(5,30)
		tnamelabel:SetText("Tribe name")
		
	local tname = vgui.Create("DTextEntry",self)
		tname:SetSize(self:GetWide()-10, 30)
        tname:SetPos(5, 50)
		
	local tpwlabel = vgui.Create("DLabel", self)
		tpwlabel:SetPos(5,85)
		tpwlabel:SetText("Tribe password")
		
	local tpw = vgui.Create("DTextEntry",self)
		tpw:SetSize(self:GetWide()-10, 30)
        tpw:SetPos(5, 105)
		
	local tcollabel = vgui.Create("DLabel", self)
		tcollabel:SetPos(5,140)
		tcollabel:SetText("Tribe color")
		
	local tcolor = vgui.Create("DColorMixer",self)
		tcolor:SetSize(self:GetWide()+15, 150)
        tcolor:SetPos(5, 160)
		
	local button = vgui.Create("DButton",self)
         button:SetSize(self:GetWide()-10, 30)
         button:SetPos(5, 315)
         button:SetText("Create Tribe!")
		 button.DoClick = function()
			RunConsoleCommand("gms_createtribe", tname:GetValue(), tcolor:GetColor().r, tcolor:GetColor().g, tcolor:GetColor().b, tpw:GetValue())
			self:SetVisible(false)
		 end
end

vgui.Register("GMS_TribeMenu",PANEL,"DFrame")

/*---------------------------------------------------------
  Need HUD
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
         self:SetPos(0,0)
         self:SetSize(ScrW() / 6,ScrH() / 12)
         
         self:SetVisible(true)
end

function PANEL:Paint()
         local col = StrandedColorTheme
         local bordcol = StrandedBorderTheme

         surface.SetDrawColor(col.r,col.g,col.b,math.Clamp(col.a - 60,1,255))
         surface.DrawRect(0,0,self:GetWide(),self:GetTall())

         surface.SetDrawColor(bordcol.r,bordcol.g,bordcol.b,math.Clamp(bordcol.a - 60,1,255))
         surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())

         local line = self:GetTall() / 10

         //Health
         local h = (LocalPlayer():Health() / 200) * (self:GetWide() - ((self:GetWide() / 14) * 2))
         surface.SetDrawColor(0,0,0,255)
         surface.DrawRect(self:GetWide() / 14, line, self:GetWide() - ((self:GetWide() / 14) * 2), self:GetTall() / 8)

         surface.SetDrawColor(170,0,0,255)
         surface.DrawRect(self:GetWide() / 14, line, h, self:GetTall() / 8)
		 
		 draw.SimpleTextOutlined("Health","DefaultSmall",self:GetWide() / 2,line+4,Color(255,255,255,255),1,1,0.5,Color(100,100,100,140))
         local line = line + (self:GetTall() / 8) + (self:GetTall() / 10)

         //Hunger
         local h = (Hunger / 1000) * (self:GetWide() - ((self:GetWide() / 14) * 2))
         surface.SetDrawColor(0,0,0,255)
         surface.DrawRect(self:GetWide() / 14, line, self:GetWide() - ((self:GetWide() / 14) * 2), self:GetTall() / 8)

         surface.SetDrawColor(0,170,0,255)
         surface.DrawRect(self:GetWide() / 14, line, h, self:GetTall() / 8)
		 
		 draw.SimpleTextOutlined("Hunger","DefaultSmall",self:GetWide() / 2,line+4,Color(255,255,255,255),1,1,0.5,Color(100,100,100,140))
         local line = line + (self:GetTall() / 8) + (self:GetTall() / 10)
         
         //Thirst
         local h = (Thirst / 1000) * (self:GetWide() - ((self:GetWide() / 14) * 2))
         surface.SetDrawColor(0,0,0,255)
         surface.DrawRect(self:GetWide() / 14, line, self:GetWide() - ((self:GetWide() / 14) * 2), self:GetTall() / 8)
         
         surface.SetDrawColor(0,0,170,255)
         surface.DrawRect(self:GetWide() / 14, line, h, self:GetTall() / 8)
		 
		 draw.SimpleTextOutlined("Thirst","DefaultSmall",self:GetWide() / 2,line+4,Color(255,255,255,255),1,1,0.5,Color(100,100,100,140))
         local line = line + (self:GetTall() / 8) + (self:GetTall() / 10)
         
         //Sleepiness
         local h = (Sleepiness / 1000) * (self:GetWide() - ((self:GetWide() / 14) * 2))
         surface.SetDrawColor(0,0,0,255)
         surface.DrawRect(self:GetWide() / 14, line, self:GetWide() - ((self:GetWide() / 14) * 2), self:GetTall() / 8)
         
         surface.SetDrawColor(170,0,140,255)
         surface.DrawRect(self:GetWide() / 14, line, h, self:GetTall() / 8)
		 
		 draw.SimpleTextOutlined("Fatigue","DefaultSmall",self:GetWide() / 2,line+4,Color(255,255,255,255),1,1,0.5,Color(100,100,100,140))
         local line = line + (self:GetTall() / 8) + (self:GetTall() / 10)
         return true
end

vgui.Register("gms_NeedHud",PANEL,"DPanel")

/*---------------------------------------------------------
  Skills panel
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
         self:SetPos(0,GAMEMODE.NeedHud:GetTall())
         self:SetSize(ScrW() / 6,ScrH() / 20)

         self:SetVisible(true)
         
         self.Extended = false
         self.SkillLabels = {}
end

function PANEL:Paint()
         local col = StrandedColorTheme
         local bordcol = StrandedBorderTheme

         surface.SetDrawColor(col.r,col.g,col.b,math.Clamp(col.a - 60,1,255))
         surface.DrawRect(0,0,self:GetWide(),self:GetTall())

         surface.SetDrawColor(bordcol.r,bordcol.g,bordcol.b,math.Clamp(bordcol.a - 60,1,255))
         surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())
         
         draw.SimpleText("Skills (F1)","ScoreboardSub",5,5,Color(255,255,255,255))
         return true
end

function PANEL:RefreshSkills()
         for k,v in pairs(self.SkillLabels) do
             v:Remove()
         end
         
         self.SkillLabels = {}
         self.Line = ScrH() / 20
         self.Tab = 0

         for k,v in pairs(Skills) do
             local lbl = vgui.Create("gms_SkillPanel",self)
             lbl:SetPos(self.Tab,self.Line)
             lbl:SetSize( self:GetWide(), ScrH() / 15)
             local val = string.gsub(k,"_"," ")
             lbl:SetSkill(val)

             self.Line = self.Line + lbl:GetTall()
             table.insert(self.SkillLabels,lbl)
             if !self.Extended then lbl:SetVisible(false) end
         end

         if self.Extended then 
            self:SetSize(ScrW() / 6, ScrH() / 20 + (table.Count(Skills) * ScrH() / 15)) 
            GAMEMODE:RecalculateHUDPos()
         end
end

function PANEL:ToggleExtend()
         if !self.Extended then

            self:SetSize(ScrW() / 6, ScrH() / 20 + (table.Count(Skills) * ScrH() / 15))
            self.Extended = true

            GAMEMODE:RecalculateHUDPos()
            for k,v in pairs(self.SkillLabels) do
                v:SetVisible(true)
            end
         else
            self:SetSize(ScrW() / 6, ScrH() / 20)
            self.Extended = false

            GAMEMODE:RecalculateHUDPos()
            for k,v in pairs(self.SkillLabels) do
                v:SetVisible(false)
            end
         end
end

function PANEL:OnMousePressed(mc)
         if mc == 107 then
            self:ToggleExtend()
         end
end

vgui.Register("gms_SkillsHud",PANEL,"Panel")

function GM:RecalculateHUDPos()
         GAMEMODE.ResourcesHud:SetPos(0,GAMEMODE.NeedHud:GetTall() + GAMEMODE.SkillsHud:GetTall())
end

/*---------------------------------------------------------
  Skill Sub-Panel
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
end

function PANEL:Paint()
         draw.SimpleText(self.TxtSkill..": "..Skills[self.Skill],"ScoreboardText",5,0,Color(255,255,255,255))
         
         //XP bar background
         surface.SetDrawColor(00,0,00,170)
         surface.DrawRect(10, self:GetTall() / 2, self:GetWide() - 20, self:GetTall() / 2 - 10)

         //XP bar
         local XP = Experience[self.Skill] / 100 * (self:GetWide() - 20)
         surface.SetDrawColor(10,255,10,255)
         surface.DrawRect(10, self:GetTall() / 2, XP , self:GetTall() / 2 - 10)
         
         //Draw XP
         draw.SimpleText(Experience[self.Skill].." / 100","Default",self:GetWide() / 2, self:GetTall() / 2 + ((self:GetTall() / 2 - 10) / 2),Color(255,255,255,255),1,1)

         //XP bar outline
         surface.SetDrawColor(0,0,0,140)
         surface.DrawOutlinedRect(10, self:GetTall() / 2, self:GetWide() - 20, self:GetTall() / 2 - 10)

         //Box outline
         surface.SetDrawColor(0,0,0,140)
         surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())
         return true
end

function PANEL:SetSkill(str)
    self.TxtSkill = str
    self.Skill = string.gsub(str," ","_")
end
vgui.Register("gms_SkillPanel",PANEL,"Panel")

/*---------------------------------------------------------
  Resource panel
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0,GAMEMODE.NeedHud:GetTall() + ScrH() / 20)
    self:SetSize(ScrW() / 6,ScrH() / 20)
    self:SetVisible(true)
    self.Extended = false
    self.ResourceLabels = {}
end

function PANEL:Paint()
    local col = StrandedColorTheme
    local bordcol = StrandedBorderTheme
    surface.SetDrawColor(col.r,col.g,col.b,math.Clamp(col.a - 60,1,255))
    surface.DrawRect(0,0,self:GetWide(),self:GetTall())
    surface.SetDrawColor(bordcol.r,bordcol.g,bordcol.b,math.Clamp(bordcol.a - 60,1,255))
    surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())
    draw.SimpleText("Resources (F2)","ScoreboardSub",5,5,Color(255,255,255,255))
    return true
end

function PANEL:RefreshResources()
    for k,v in pairs(self.ResourceLabels) do
        v:Remove()
	end
    self.ResourceLabels = {}
    self.Line = ScrH() / 20
    self.Tab = 5
    self.IntResources = 0
    local count = 0
    for k,v in pairs(Resources) do
        if v > 0 then
            local lbl = vgui.Create("Label",self)
            lbl:SetPos(self.Tab,self.Line)
            lbl:SetSize(self:GetWide(),20)
            local val = string.gsub(k,"_"," ")
            lbl:SetText(val..":  "..v)
            //lbl:SetFont("ScoreboardText")
            self.IntResources = self.IntResources + v
            self.Line = self.Line + 20
            table.insert(self.ResourceLabels,lbl)
            if !self.Extended then 
				lbl:SetVisible(false) 
			end
        end
		count = count + 1
    end
    local lbl = vgui.Create("Label",self)
	lbl:SetPos(self.Tab,self.Line + 20)
    lbl:SetSize(self:GetWide(),20)
    lbl:SetText("Total:  "..self.IntResources.." / "..MaxResources)
    //lbl:SetFont("ScoreboardText")
    table.insert(self.ResourceLabels,lbl)
	
    if !self.Extended then 
		lbl:SetVisible(false) 
	end
	
    if self.Extended then
        self:SetSize(ScrW() / 6, ScrH() / 20 + (count * 20) + 60)
        GAMEMODE:RecalculateHUDPos()
    end
end

function PANEL:ToggleExtend()
    if !self.Extended then
        self:SetSize(ScrW() / 6, ScrH() / 20 + (table.Count(Resources) * 20) + 60)
        self.Extended = true
        GAMEMODE:RecalculateHUDPos()
		for k,v in pairs(self.ResourceLabels) do
			v:SetVisible(true)
		end
    else
		self:SetSize(ScrW() / 6, ScrH() / 20)
        self.Extended = false
        GAMEMODE:RecalculateHUDPos()
		for k,v in pairs(self.ResourceLabels) do
			v:SetVisible(false)
		end
    end
end

function PANEL:OnMousePressed(mc)
    if mc == 107 then
        self:ToggleExtend()
    end
end
vgui.Register("gms_ResourcesHud",PANEL,"Panel")

/*---------------------------------------------------------
  Command button
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
end

function PANEL:DoClick()
    LocalPlayer():ConCommand(self.Command.."\n")
    surface.PlaySound(Sound("ui/buttonclickrelease.wav"))
end

function PANEL:SetConCommand(cmd)
	self.Command = cmd
end

function PANEL:OnCursorEntered()
    surface.PlaySound(Sound("ui/buttonrollover.wav"))
end
vgui.Register("gms_CommandButton",PANEL,"DButton")
/*---------------------------------------------------------
  Info Panel
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Paint()
    local bordcol = StrandedBorderTheme
    surface.SetDrawColor(50,50,25,255)
    surface.DrawRect(0,0,self:GetWide(),self:GetTall())
    surface.SetDrawColor(bordcol.r,bordcol.g,bordcol.b,bordcol.a)
    surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())
    return true
end
vgui.Register("GMS_InfoPanel",PANEL,"Panel")
/*---------------------------------------------------------
  Combination Window
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetKeyboardInputEnabled(true)
    self:SetMouseInputEnabled(true)
	self:SetDeleteOnClose(false)
	self:MakePopup()
    self:SetPos(100,50)
    self:SetSize(ScrW() - 200, ScrH() - 100)
    local space = self:GetTall() / 30
    --Add bordered subwindows
    self.CombiList = vgui.Create("DPanel",self)
		self.CombiList:SetPos(self:GetWide() / 30,self:GetTall() / 20)
		local x,y = self.CombiList:GetPos()
		self.CombiList:SetSize(self:GetWide() - (self:GetWide() / 30) * 2, self:GetTall() / 1.5 - space - y)
    self.Info = vgui.Create("DPanel",self)
        self.Info:SetPos(self:GetWide() / 30, self:GetTall() / 1.5)
        local x2,y2 = self.Info:GetPos()
        self.Info:SetSize(self:GetWide() - (x2 * 2), self:GetTall() / 3 - space - y)
        self.Info:SetZPos(290)
    self.Info.NameLabel = vgui.Create("DLabel",self.Info)
        self.Info.NameLabel:SetPos(10,5)
        self.Info.NameLabel:SetSize(self.Info:GetWide(),20)
        self.Info.NameLabel:SetFont("ScoreboardSub")
    self.Info.DescLabel = vgui.Create("DLabel",self.Info)
        self.Info.DescLabel:SetName("GMS_TempLblName")
        self.Info.DescLabel:LoadControlsFromString([["GMS_TempLblName"{"GMS_TempLblName"{"wrap" "1"}}]])
        self.Info.DescLabel:SetPos(10,20)
        self.Info.DescLabel:SetSize(self.Info:GetWide(),self.Info:GetTall() - 20)
        self.Info.NameLabel:SetText("Select a recipe")
        self.Info.DescLabel:SetText("")
    local button = vgui.Create("gms_CommandButton",self)
        button:SetPos(self:GetWide() / 30,y2 + self.Info:GetTall() + 5)
        button:SetSize(self:GetWide() / 6, self:GetTall() / 17 - 10)
        button:SetText("Make")
    function button:DoClick()
        local p = self:GetParent()
        local combi = p.CombiGroupName or ""
        local active = p.ActiveCombi or ""
        LocalPlayer():ConCommand("gms_MakeCombination "..combi.." "..active.."\n")
    end
        --Make limits
    self.IconSize = 80
    self.Spacing = 10
    self.MaxLines = math.Round(self.CombiList:GetTall() / (self.IconSize + self.Spacing))
    self.MaxPerLine = math.Round(self.CombiList:GetWide() / (self.IconSize + self.Spacing))
    self.CombiPanels = {}
end

function PANEL:SetTable(str)
    self:SetTitle(str)
    self.CombiGroupName = str		 
    self.CombiGroup = GMS.Combinations[str]
    self:Clear()
    local line = self.Spacing
    local tab = self.Spacing
    local num = 0
	for name,tbl in pairs(self.CombiGroup) do
		local icon = vgui.Create("GMS_CombiIcon",self.CombiList)
        icon:SetPos(tab,line)
        icon:SetSize(self.IconSize,self.IconSize)
        icon:SetInfo(name,tbl)
        icon:SetZPos(400)
        table.insert(self.CombiPanels,icon)
        tab = tab + self.Spacing + icon:GetWide()
        num = num + 1
		if num >= self.MaxPerLine then
			tab = self.Spacing
            line = line + self.Spacing + self.IconSize
			num = 0
        end
	end
    self:ClearActive()
end

function PANEL:SetActive(combi,tbl)
    self.ActiveCombi = combi
    self.ActiveTable = tbl
    self.Info.NameLabel:SetText(tbl.Name)
    self.Info.DescLabel:SetText(tbl.Description)
end

function PANEL:ClearActive()
    self.ActiveCombi = nil
    self.ActiveTable = nil 
    self.Info.NameLabel:SetText("Select a recipe")
    self.Info.DescLabel:SetText("")
end

function PANEL:Clear()
    for k,v in pairs(self.CombiPanels) do
        v:Remove()
    end
	self.CombiPanels = {}
end
vgui.Register("GMS_CombinationWindow",PANEL,"DFrame")
/*---------------------------------------------------------
  Empty Combi Icon
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Paint()
    local bordcol = StrandedBorderTheme
    surface.SetDrawColor(0,0,0,255)
    surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	surface.SetDrawColor(bordcol.r,bordcol.g,bordcol.b,bordcol.a)
    surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())
    return true
end

function PANEL:OnMousePressed(mc)
    if mc != 107 then return end
    surface.PlaySound(Sound("ui/buttonclickrelease.wav"))
    self:GetParent():GetParent():ClearActive()
end
vgui.Register("GMS_EmptyCombiIcon",PANEL,"DPanel")

/*---------------------------------------------------------
  Combi Icon
---------------------------------------------------------*/
local PANEL = {}
PANEL.TexID = Material( "gui/gmod_logo" )

function PANEL:Paint()
    local bordcol = StrandedBorderTheme
    surface.SetDrawColor(200,200,200,255)
    surface.DrawRect(0,0,self:GetWide(),self:GetTall())
    surface.SetTexture(self.TexID)
    surface.DrawTexturedRect(0,5,self:GetWide(),self:GetTall())
    surface.SetDrawColor(bordcol.r,bordcol.g,bordcol.b,bordcol.a)
    surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())
    local hasskill = true
    if self.CombiTable.SkillReq then
        for k,v in pairs(self.CombiTable.SkillReq) do
            if GetSkill(k) < v then
                hasskill = false
            end
        end
    end
    local hasres = true
    if self.CombiTable.Req then
        for k,v in pairs(self.CombiTable.Req) do
            if GetResource(k) < v then
                hasres = false
            end
        end
    end
	if !hasskill then
        surface.SetDrawColor(200,200,0,150)
        surface.DrawRect(0,0,self:GetWide(),self:GetTall())
    elseif !hasres then
        surface.SetDrawColor(200,0,0,100)
        surface.DrawRect(0,0,self:GetWide(),self:GetTall())
    end
    local x = self:GetWide()/2
    local y = self:GetTall()/2 
    draw.SimpleTextOutlined(self.CombiTable.Name,"DefaultSmall",x,y,Color(255,255,255,255),1,1,0.5,Color(100,100,100,140))		 
	return true
end

function PANEL:SetInfo(name,tbl)
    if tbl.Texture then 
		self.TexID = Material( tbl.Texture ) 
	end
    self.Combi = name
    self.CombiTable = tbl
end

function PANEL:OnMousePressed(mc)
         if mc != 107 then return end
         surface.PlaySound(Sound("ui/buttonclickrelease.wav"))
         self:GetParent():GetParent():SetActive(self.Combi,self.CombiTable)
end

function PANEL:OnCursorEntered()
         for k,icon in pairs(self:GetParent():GetParent().CombiPanels) do
             icon:SetZPos(400)
         end
         
         self:SetZPos(410)
         self.BeingHovered = true
         surface.PlaySound(Sound("ui/buttonrollover.wav"))
end

function PANEL:OnCursorExited()
         self.BeingHovered = false
end

vgui.Register("GMS_CombiIcon",PANEL,"DPanel")

/*---------------------------------------------------------
   Derma Stranded Theme LOL
---------------------------------------------------------*/
local SKIN = {}

SKIN.bg_color 					= Color( 0, 0, 0, 180 )
SKIN.bg_color_dark				= Color( 0, 0, 0, 170 )

SKIN.fontFrame					= "ScoreboardText"

SKIN.control_color 				= Color( 0, 0, 0, 180 )
SKIN.control_color_highlight	= Color(65, 65, 65, 255)
SKIN.control_color_active 		= Color( 0, 0, 0, 180 )
SKIN.control_color_bright 		= Color( 0, 0, 0, 180 )
SKIN.control_color_dark 		= Color( 0, 0, 0, 180 )

SKIN.texGradientUp				= Material( "gui/gradient_up" )
SKIN.texGradientDown			= Material( "gui/gradient_down" )

SKIN.combobox_selected			= SKIN.listview_selected

SKIN.panel_transback			= Color( 160, 160, 160, 90 )
SKIN.tooltip					= Color( 255, 245, 175, 255 )

SKIN.colPropertySheet 			= Color( 0, 0, 0, 180 )
SKIN.colTab			 			= SKIN.colPropertySheet
SKIN.colTabInactive				= Color( 0, 0, 0, 180 )
SKIN.colTabShadow				= Color( 0, 0, 0, 255)
SKIN.colTabText		 			= Color( 255, 255, 255, 255 )
SKIN.colTabTextInactive			= Color( 255, 255, 255, 255 )
SKIN.fontTab					= "ScoreboardText"

SKIN.colCollapsibleCategory		= Color( 0, 0, 0, 180 )

SKIN.colCategoryText			= Color( 255, 255, 255, 255 )
SKIN.colCategoryTextInactive	= Color( 255, 255, 255, 255 )
SKIN.fontCategoryHeader			= "ScoreboardText"

SKIN.colNumberWangBG			= Color( 0, 0, 0, 180 )
SKIN.colTextEntryBG				= Color( 0, 0, 0, 255 )
SKIN.colTextEntryBorder			= Color( 0, 0, 0, 255 )
SKIN.colTextEntryText			= Color( 255, 255, 255, 255 )
SKIN.colTextEntryTextHighlight	= Color( 255, 255, 255, 180 )
SKIN.colTextEntryTextHighlight	= Color( 255, 255, 255, 180 )

SKIN.colMenuBG					= Color( 255, 255, 255, 180 )
SKIN.colMenuBorder				= Color( 255, 255, 255, 180 )

SKIN.colButtonText				= Color( 255, 255, 255, 255 )
SKIN.colButtonTextDisabled		= Color( 255, 255, 255, 255 )
SKIN.colButtonBorder			= Color( 0, 0, 0, 180 )
SKIN.colButtonBorderHighlight	= Color(65, 65, 65, 255)
SKIN.colButtonBorderShadow		= Color( 0, 0, 0, 100 )
SKIN.fontButton					= "ScoreboardText"


/*---------------------------------------------------------
   DrawGenericBackground
---------------------------------------------------------*/
function SKIN:DrawGenericBackground( x, y, w, h, color )

	draw.RoundedBox( 4, x, y, w, h, color )

end

/*---------------------------------------------------------
   DrawButtonBorder
---------------------------------------------------------*/
function SKIN:DrawButtonBorder( x, y, w, h, depressed )

	if ( !depressed ) then
	
		// Highlight
		surface.SetDrawColor( self.colButtonBorderHighlight )
		surface.DrawRect( x+1, y+1, w-2, 1 )
		surface.DrawRect( x+1, y+1, 1, h-2 )
		
		// Corner
		surface.DrawRect( x+2, y+2, 1, 1 )
	
		// Shadow
		surface.SetDrawColor( self.colButtonBorderShadow )
		surface.DrawRect( w-2, y+2, 1, h-2 )
		surface.DrawRect( x+2, h-2, w-2, 1 )
		
	else
	
		local col = self.colButtonBorderShadow
	
		for i=1, 5 do
		
			surface.SetDrawColor( col.r, col.g, col.b, (255 - i * (255/5) ) )
			surface.DrawOutlinedRect( i, i, w-i, h-i )
		
		end
		
	end	

	surface.SetDrawColor( self.colButtonBorder )
	surface.DrawOutlinedRect( x, y, w, h )

end

/*---------------------------------------------------------
   DrawDisabledButtonBorder
---------------------------------------------------------*/
function SKIN:DrawDisabledButtonBorder( x, y, w, h, depressed )

	surface.SetDrawColor( 0, 0, 0, 150 )
	surface.DrawOutlinedRect( x, y, w, h )
	
end

/*---------------------------------------------------------
	Frame
---------------------------------------------------------*/
function SKIN:PaintFrame( panel )

	local color = self.bg_color

	self:DrawGenericBackground( 0, 0, panel:GetWide(), panel:GetTall(), color )
	
	surface.SetDrawColor( 0, 0, 0, 150 )
	surface.DrawRect( 0, 22, panel:GetWide(), 1 )

end

function SKIN:LayoutFrame( panel )

	panel.lblTitle:SetFont( self.fontFrame )
	
	panel.btnClose:SetPos( panel:GetWide() - 22, 4 )
	panel.btnClose:SetSize( 18, 18 )
	
	panel.lblTitle:SetPos( 8, 2 )
	panel.lblTitle:SetSize( panel:GetWide() - 25, 20 )

end

/*---------------------------------------------------------
	Button
---------------------------------------------------------*/
function SKIN:PaintButton( panel )

	local w, h = panel:GetSize()

	if ( panel.m_bBackground ) then
	
		local col = self.control_color
		
		if ( panel:GetDisabled() ) then
			col = self.control_color_dark
		elseif ( panel.Depressed || panel:GetSelected() ) then
			col = self.control_color_active
		elseif ( panel.Hovered ) then
			col = self.control_color_highlight
		end
		
		surface.SetDrawColor( col.r, col.g, col.b, col.a )
		panel:DrawFilledRect()
	
	end

end
function SKIN:PaintOverButton( panel )

	local w, h = panel:GetSize()
	
	if ( panel.m_bBorder ) then
		if ( panel:GetDisabled() ) then
			self:DrawDisabledButtonBorder( 0, 0, w, h )
		else
			self:DrawButtonBorder( 0, 0, w, h, panel.Depressed || panel:GetSelected() )
		end
	end

end


function SKIN:SchemeButton( panel )

	panel:SetFont( self.fontButton )
	
	if ( panel:GetDisabled() ) then
		panel:SetTextColor( self.colButtonTextDisabled )
	else
		panel:SetTextColor( self.colButtonText )
	end
	
	DLabel.ApplySchemeSettings( panel )

end

/*---------------------------------------------------------
	SysButton
---------------------------------------------------------*/
function SKIN:PaintPanel( panel )

	if ( panel.m_bPaintBackground ) then
	
		local w, h = panel:GetSize()
		self:DrawGenericBackground( 0, 0, w, h, self.panel_transback )
		
	end	

end

/*---------------------------------------------------------
	SysButton
---------------------------------------------------------*/
function SKIN:PaintSysButton( panel )

	self:PaintButton( panel )
	self:PaintOverButton( panel ) // Border

end

function SKIN:SchemeSysButton( panel )

	panel:SetFont( "Marlett" )
	DLabel.ApplySchemeSettings( panel )
	
end

/*---------------------------------------------------------
	PaneList
---------------------------------------------------------*/
function SKIN:PaintPanelList( panel )

	if ( panel.m_bBackground ) then
		draw.RoundedBox( 4, 0, 0, panel:GetWide(), panel:GetTall(), self.bg_color_dark )
	end

end

/*---------------------------------------------------------
	ScrollBar
---------------------------------------------------------*/
function SKIN:PaintVScrollBar( panel )

	surface.SetDrawColor( self.bg_color.r, self.bg_color.g, self.bg_color.b, self.bg_color.a )
	surface.DrawRect( 0, 0, panel:GetWide(), panel:GetTall() )

end

function SKIN:LayoutVScrollBar( panel )

	local Wide = panel:GetWide()
	local Scroll = panel:GetScroll() / panel.CanvasSize
	local BarSize = panel:BarScale() * (panel:GetTall() - (Wide * 2))
	local Track = panel:GetTall() - (Wide * 2) - BarSize
	Track = Track + 1
	
	Scroll = Scroll * Track
	
	panel.btnGrip:SetPos( 0, Wide + Scroll )
	panel.btnGrip:SetSize( Wide, BarSize )
	
	panel.btnUp:SetPos( 0, 0, Wide, Wide )
	panel.btnUp:SetSize( Wide, Wide )
	
	panel.btnDown:SetPos( 0, panel:GetTall() - Wide, Wide, Wide )
	panel.btnDown:SetSize( Wide, Wide )

end

/*---------------------------------------------------------
	ScrollBarGrip
---------------------------------------------------------*/
function SKIN:PaintScrollBarGrip( panel )

	surface.SetDrawColor( self.control_color.r, self.control_color.g, self.control_color.b, self.control_color.a )
	surface.DrawRect( 0, 0, panel:GetWide(), panel:GetTall() )

	self:DrawButtonBorder( 0, 0, panel:GetWide(), panel:GetTall() )

end

/*---------------------------------------------------------
	ScrollBar
---------------------------------------------------------*/
function SKIN:PaintMenu( panel )

	surface.SetDrawColor( self.colMenuBG )
	panel:DrawFilledRect( 0, 0, w, h )

end

function SKIN:PaintOverMenu( panel )

	surface.SetDrawColor( self.colMenuBorder )
	panel:DrawOutlinedRect( 0, 0, w, h )

end

function SKIN:LayoutMenu( panel )

	local w = panel:GetMinimumWidth()
	
	// Find the widest one
	for k, pnl in pairs( panel.Panels ) do
	
		pnl:PerformLayout()
		w = math.max( w, pnl:GetWide() )
	
	end

	panel:SetWide( w )
	
	local y = 0
	
	for k, pnl in pairs( panel.Panels ) do
	
		pnl:SetWide( w )
		pnl:SetPos( 0, y )
		pnl:InvalidateLayout( true )
		
		y = y + pnl:GetTall()
	
	end
	
	panel:SetTall( y )

end

/*---------------------------------------------------------
	ScrollBar
---------------------------------------------------------*/
function SKIN:PaintMenuOption( panel )

	if ( panel.m_bBackground && panel.Hovered ) then
	
		local col = nil
		
		if ( panel.Depressed ) then
			col = self.control_color_bright
		else
			col = self.control_color_active
		end
		
		surface.SetDrawColor( col.r, col.g, col.b, col.a )
		surface.DrawRect( 0, 0, panel:GetWide(), panel:GetTall() )
	
	end
	
end

function SKIN:LayoutMenuOption( panel )

	// This is totally messy. :/

	panel:SizeToContents()

	panel:SetWide( panel:GetWide() + 30 )
	
	local w = math.max( panel:GetParent():GetWide(), panel:GetWide() )

	panel:SetSize( w, 18 )
	
	if ( panel.SubMenuArrow ) then
	
		panel.SubMenuArrow:SetSize( panel:GetTall(), panel:GetTall() )
		panel.SubMenuArrow:CenterVertical()
		panel.SubMenuArrow:AlignRight()
		
	end
	
end
function SKIN:SchemeMenuOption( panel )

	panel:SetFGColor( 40, 40, 40, 255 )
	
end

/*---------------------------------------------------------
	TextEntry
---------------------------------------------------------*/
function SKIN:PaintTextEntry( panel )

	if ( panel.m_bBackground ) then
	
		surface.SetDrawColor( self.colTextEntryBG )
		surface.DrawRect( 0, 0, panel:GetWide(), panel:GetTall() )
	
	end
	
	panel:DrawTextEntryText( panel.m_colText, panel.m_colHighlight, panel.m_colCursor )
	
	if ( panel.m_bBorder ) then
	
		surface.SetDrawColor( self.colTextEntryBorder )
		surface.DrawOutlinedRect( 0, 0, panel:GetWide(), panel:GetTall() )
	
	end

	
end

function SKIN:SchemeTextEntry( panel )

	panel:SetTextColor( self.colTextEntryText )
	panel:SetHighlightColor( self.colTextEntryTextHighlight )
	panel:SetCursorColor( Color( 0, 0, 100, 255 ) )

end

/*---------------------------------------------------------
	Label
---------------------------------------------------------*/
function SKIN:PaintLabel( panel )
	return false
end

function SKIN:SchemeLabel( panel )

	local col = nil

	if ( panel.Hovered && panel:GetTextColorHovered() ) then
		col = panel:GetTextColorHovered()
	else
		col = panel:GetTextColor()
	end
	
	if ( col ) then
		panel:SetFGColor( col.r, col.g, col.b, col.a )
	else
		panel:SetFGColor( 200, 200, 200, 255 )
	end

end

function SKIN:LayoutLabel( panel )

	panel:ApplySchemeSettings()
	
	if ( panel.m_bAutoStretchVertical ) then
		panel:SizeToContentsY()
	end
	
end

/*---------------------------------------------------------
	CategoryHeader
---------------------------------------------------------*/
function SKIN:PaintCategoryHeader( panel )
		
end

function SKIN:SchemeCategoryHeader( panel )
	
	panel:SetTextInset( 5 )
	panel:SetFont( self.fontCategoryHeader )
	
	if ( panel:GetParent():GetExpanded() ) then
		panel:SetTextColor( self.colCategoryText )
	else
		panel:SetTextColor( self.colCategoryTextInactive )
	end
	
end

/*---------------------------------------------------------
	CategoryHeader
---------------------------------------------------------*/
function SKIN:PaintCollapsibleCategory( panel )
	
	draw.RoundedBox( 4, 0, 0, panel:GetWide(), panel:GetTall(), self.colCollapsibleCategory )
	
end

/*---------------------------------------------------------
	Tab
---------------------------------------------------------*/
function SKIN:PaintTab( panel )

	// This adds a little shadow to the right which helps define the tab shape..
	draw.RoundedBox( 4, 0, 0, panel:GetWide(), panel:GetTall() + 8, self.colTabShadow )
	
	if ( panel:GetPropertySheet():GetActiveTab() == panel ) then
		draw.RoundedBox( 4, 1, 0, panel:GetWide()-2, panel:GetTall() + 8, self.colTab )
	else
		draw.RoundedBox( 4, 0, 0, panel:GetWide()-1, panel:GetTall() + 8, self.colTabInactive  )
	end
	
end
function SKIN:SchemeTab( panel )

	panel:SetFont( self.fontTab )

	local ExtraInset = 10

	if ( panel.Image ) then
		ExtraInset = ExtraInset + panel.Image:GetWide()
	end
	
	panel:SetTextInset( ExtraInset )
	panel:SizeToContents()
	panel:SetSize( panel:GetWide() + 10, panel:GetTall() + 8 )
	
	local Active = panel:GetPropertySheet():GetActiveTab() == panel
	
	if ( Active ) then
		panel:SetTextColor( self.colTabText )
	else
		panel:SetTextColor( self.colTabTextInactive )
	end
	
	panel.BaseClass.ApplySchemeSettings( panel )
		
end

function SKIN:LayoutTab( panel )

	panel:SetTall( 22 )

	if ( panel.Image ) then
	
		local Active = panel:GetPropertySheet():GetActiveTab() == panel
		
		local Diff = panel:GetTall() - panel.Image:GetTall()
		panel.Image:SetPos( 7, Diff * 0.6 )
		
		if ( !Active ) then
			panel.Image:SetImageColor( Color( 170, 170, 170, 155 ) )
		else
			panel.Image:SetImageColor( Color( 255, 255, 255, 255 ) )
		end
	
	end	
	
end

/*---------------------------------------------------------
	PropertySheet
---------------------------------------------------------*/
function SKIN:PaintPropertySheet( panel )

	local ActiveTab = panel:GetActiveTab()
	local Offset = 0
	if ( ActiveTab ) then Offset = ActiveTab:GetTall() end
	
	// This adds a little shadow to the right which helps define the tab shape..
	draw.RoundedBox( 4, 0, Offset, panel:GetWide(), panel:GetTall()-Offset, self.colPropertySheet )
	
end

/*---------------------------------------------------------
	ListViewLine
---------------------------------------------------------*/
function SKIN:PaintListViewLine( panel )

	local Col = nil
	
	if ( panel:IsSelected() ) then
	
		Col = self.listview_selected
		
	elseif ( panel.Hovered ) then
	
		Col = self.listview_hover
		
	elseif ( panel.m_bAlt ) then
	
		Col = self.bg_alt2
		
	else
	
		return
				
	end
		
	surface.SetDrawColor( Col.r, Col.g, Col.b, Col.a )
	surface.DrawRect( 0, 0, panel:GetWide(), panel:GetTall() )
	
end

/*---------------------------------------------------------
	ListViewLabel
---------------------------------------------------------*/
function SKIN:LayoutListViewLabel( panel )

	panel:SetTextInset( 10 )
	
	if ( panel.Line:IsSelected() ) then
		panel:SetTextColor( self.text_bright )
	else
		panel:SetTextColor( self.text_normal )
	end
		
end

/*---------------------------------------------------------
	Form
---------------------------------------------------------*/
function SKIN:PaintForm( panel )

	local color = self.bg_color_sleep

	self:DrawGenericBackground( 0, 9, panel:GetWide(), panel:GetTall()-9, self.bg_color )

end
function SKIN:SchemeForm( panel )

	panel.Label:SetFont( "TabLarge" )
	panel.Label:SetTextColor( Color( 255, 255, 255, 255 ) )

end

function SKIN:LayoutForm( panel )

end

/*---------------------------------------------------------
	MultiChoice
---------------------------------------------------------*/
function SKIN:LayoutMultiChoice( panel )

	panel.TextEntry:SetSize( panel:GetWide(), panel:GetTall() )
	
	panel.DropButton:SetSize( panel:GetTall(), panel:GetTall() )
	panel.DropButton:SetPos( panel:GetWide() - panel:GetTall(), 0 )
	
	panel.DropButton:SetZPos( 1 )
	panel.DropButton:SetDrawBackground( false )
	panel.DropButton:SetDrawBorder( false )
	
	panel.DropButton:SetTextColor( Color( 30, 100, 200, 255 ) )
	panel.DropButton:SetTextColorHovered( Color( 50, 150, 255, 255 ) )
	
end

/*
NumberWangIndicator
*/

function SKIN:DrawNumberWangIndicatorText( panel, wang, x, y, number, alpha )

	local alpha = math.Clamp( alpha ^ 0.5, 0, 1 ) * 255
	local col = self.text_dark
	
	// Highlight round numbers
	local dec = (wang:GetDecimals() + 1) * 10
	if ( number / dec == math.ceil( number / dec ) ) then
		col = self.text_highlight
	end

	draw.SimpleText( number, "Default", x, y, Color( col.r, col.g, col.b, alpha ) )
	
end

function SKIN:PaintNumberWangIndicator( panel )
	
	/*
	
		Please excuse the crudeness of this code.
	
	*/

	if ( panel.m_bTop ) then
		surface.SetMaterial( self.texGradientUp )
	else
		surface.SetMaterial( self.texGradientDown )
	end
	
	surface.SetDrawColor( self.colNumberWangBG )
	surface.DrawTexturedRect( 0, 0, panel:GetWide(), panel:GetTall() )
	
	local wang = panel:GetWang()
	local CurNum = math.floor( wang:GetFloatValue() )
	local Diff = CurNum - wang:GetFloatValue()
		
	local InsetX = 3
	local InsetY = 5
	local Increment = wang:GetTall()
	local Offset = Diff * Increment
	local EndPoint = panel:GetTall()
	local Num = CurNum
	local NumInc = 1
	
	if ( panel.m_bTop ) then
	
		local Min = wang:GetMin()
		local Start = panel:GetTall() + Offset
		local End = Increment * -1
		
		CurNum = CurNum + NumInc
		for y = Start, Increment * -1, End do
	
			CurNum = CurNum - NumInc
			if ( CurNum < Min ) then break end
					
			self:DrawNumberWangIndicatorText( panel, wang, InsetX, y + InsetY, CurNum, y / panel:GetTall() )
		
		end
	
	else
	
		local Max = wang:GetMax()
		
		for y = Offset - Increment, panel:GetTall(), Increment do
			
			self:DrawNumberWangIndicatorText( panel, wang, InsetX, y + InsetY, CurNum, 1 - ((y+Increment) / panel:GetTall()) )
			
			CurNum = CurNum + NumInc
			if ( CurNum > Max ) then break end
		
		end
	
	end
	

end

function SKIN:LayoutNumberWangIndicator( panel )

	panel.Height = 200

	local wang = panel:GetWang()
	local x, y = wang:LocalToScreen( 0, wang:GetTall() )
	
	if ( panel.m_bTop ) then
		y = y - panel.Height - wang:GetTall()
	end
	
	panel:SetPos( x, y )
	panel:SetSize( wang:GetWide() - wang.Wanger:GetWide(), panel.Height)

end

/*---------------------------------------------------------
	CheckBox
---------------------------------------------------------*/
function SKIN:PaintCheckBox( panel )

	local w, h = panel:GetSize()

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawRect( 1, 1, w-2, h-2 )

	surface.SetDrawColor( 30, 30, 30, 255 )
	//=
	surface.DrawRect( 1, 0, w-2, 1 )
	surface.DrawRect( 1, h-1, w-2, 1 )
	//||
	surface.DrawRect( 0, 1, 1, h-2 )
	surface.DrawRect( w-1, 1, 1, h-2 )
	
	surface.DrawRect( 1, 1, 1, 1 )
	surface.DrawRect( w-2, 1, 1, 1 )
	
	surface.DrawRect( 1, h-2, 1, 1 )
	surface.DrawRect( w-2, h-2, 1, 1 )

end

function SKIN:SchemeCheckBox( panel )

	panel:SetTextColor( Color( 0, 0, 0, 255 ) )
	DSysButton.ApplySchemeSettings( panel )
	
end

/*---------------------------------------------------------
	Slider
---------------------------------------------------------*/
function SKIN:PaintSlider( panel )

end


/*---------------------------------------------------------
	NumSlider
---------------------------------------------------------*/
function SKIN:PaintNumSlider( panel )

	local w, h = panel:GetSize()
	
	self:DrawGenericBackground( 0, 0, w, h, Color( 255, 255, 255, 20 ) )
	
	surface.SetDrawColor( 0, 0, 0, 200 )
	surface.DrawRect( 3, h/2, w-6, 1 )
	
end


/*---------------------------------------------------------
	NumSlider
---------------------------------------------------------*/
function SKIN:PaintComboBoxItem( panel )

	if ( panel:GetSelected() ) then
		local col = self.combobox_selected
		surface.SetDrawColor( col.r, col.g, col.b, col.a )
		panel:DrawFilledRect()
	end

end

function SKIN:SchemeComboBoxItem( panel )
	panel:SetTextColor( Color( 0, 0, 0, 255 ) )
end

/*---------------------------------------------------------
	ComboBox
---------------------------------------------------------*/
function SKIN:PaintComboBox( panel )
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	panel:DrawFilledRect()
		
	surface.SetDrawColor( 0, 0, 0, 255 )
	panel:DrawOutlinedRect()
	
end

/*---------------------------------------------------------
	ScrollBar
---------------------------------------------------------*/
function SKIN:PaintBevel( panel )

	local w, h = panel:GetSize()

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawOutlinedRect( 0, 0, w-1, h-1)
	
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawOutlinedRect( 1, 1, w-1, h-1)

end

/*---------------------------------------------------------
	TinyButton
---------------------------------------------------------*/
function SKIN:PaintTinyButton( panel )

	if ( panel.m_bBackground ) then
	
		surface.SetDrawColor( 255, 255, 255, 255 )
		panel:DrawFilledRect()
	
	end
	
	if ( panel.m_bBorder ) then

		surface.SetDrawColor( 0, 0, 0, 255 )
		panel:DrawOutlinedRect()
	
	end

end

function SKIN:SchemeTinyButton( panel )

	panel:SetFont( "Default" )
	
	if ( panel:GetDisabled() ) then
		panel:SetTextColor( Color( 0, 0, 0, 50 ) )
	else
		panel:SetTextColor( Color( 0, 0, 0, 255 ) )
	end
	
	DLabel.ApplySchemeSettings( panel )
	
	panel:SetFont( "DefaultSmall" )

end

/*---------------------------------------------------------
	TinyButton
---------------------------------------------------------*/
function SKIN:PaintTreeNodeButton( panel )

	if ( panel.m_bSelected ) then

		surface.SetDrawColor( 50, 200, 255, 150 )
		panel:DrawFilledRect()
	
	elseif ( panel.Hovered ) then

		surface.SetDrawColor( 255, 255, 255, 100 )
		panel:DrawFilledRect()
	
	end
	
	

end

function SKIN:SchemeTreeNodeButton( panel )

	DLabel.ApplySchemeSettings( panel )

end

/*---------------------------------------------------------
	Tooltip
---------------------------------------------------------*/
function SKIN:PaintTooltip( panel )

	local w, h = panel:GetSize()
	
	DisableClipping( true )
	
	-- This isn't great, but it's not like we're drawing 1000's of tooltips all the time
	for i=1, 4 do
	
		local BorderSize = i*2
		local BGColor = Color( 0, 0, 0, (255 / i) * 0.3 )
		
		self:DrawGenericBackground( BorderSize, BorderSize, w, h, BGColor )
		panel:DrawArrow( BorderSize, BorderSize )
		self:DrawGenericBackground( -BorderSize, BorderSize, w, h, BGColor )
		panel:DrawArrow( -BorderSize, BorderSize )
		self:DrawGenericBackground( BorderSize, -BorderSize, w, h, BGColor )
		panel:DrawArrow( BorderSize, -BorderSize )
		self:DrawGenericBackground( -BorderSize, -BorderSize, w, h, BGColor )
		panel:DrawArrow( -BorderSize, -BorderSize )
		
	end


	self:DrawGenericBackground( 0, 0, w, h, self.tooltip )
	panel:DrawArrow( 0, 0 )

	DisableClipping( false )
end

derma.DefineSkin( "StrandedDermaSkin", "StrandedDermaSkin", SKIN ) 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  