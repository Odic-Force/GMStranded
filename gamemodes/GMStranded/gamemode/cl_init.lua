/*---------------------------------------------------------

  Gmod Stranded

---------------------------------------------------------*/
DeriveGamemode( "sandbox" )
include( 'shared.lua' )
include( 'cl_scoreboard.lua' )

--Custom panels
include( 'cl_panels.lua' )
--Unlocks
include( 'unlocks.lua' )
--Combis
include( 'combinations.lua' )
--VGUI
include( 'vgui/ToolMenuButton.lua' )


--Clientside player variables

--Colours(NeedHud, and 2 others)
StrandedColorTheme = Color(0,0,0,240)
StrandedBorderTheme = Color(0,0,0,180)

surface.CreateFont( "ScoreboardSub", {
	font = "Verdana",
	size = 15,
	weight = 600,
	antialias = true,
} )

surface.CreateFont( "ScoreboardText", {
	font = "Verdana",
	size = 15,
	weight = 600,
	antialias = true,
} )

surface.CreateFont( "ScoreboardHead", {
	font = "Verdana",
	size = 15,
	weight = 600,
	antialias = true,
} )

Tribes = {}
Skills = {}
Resources = {}
Experience = {}
FeatureUnlocks = {}
MaxResources = 25

local PlayerMeta = FindMetaTable("Player")
/*---------------------------------------------------------
  General / utility
---------------------------------------------------------*/
--Hide other sandbox stuff
function GM:HUDShouldDraw(name)
    if name != "CHudHealth" and name != "CHudBattery" then
        return true
    end
end

function GM:HUDPaint()
	self.BaseClass:HUDPaint()
	if ProcessCompleteTime then
		local wid = ScrW() / 3
		local hei = ScrH() / 30
		surface.SetDrawColor( 30, 30, 30,150 )
		surface.DrawRect( ScrW() * 0.5 - wid * 0.5, ScrH() / 30, wid, hei )

		local width = ( ( RealTime() - ProcessStart) / ProcessCompleteTime ) * wid
		if width > wid then GAMEMODE.StopProgressBar() end
		surface.SetDrawColor( 0, 200, 0, 255)
		surface.DrawRect( ScrW() * 0.5 - wid * 0.5, ScrH() / 30, width, hei )

		surface.SetDrawColor( 27, 167, 219,255 )
		surface.DrawOutlinedRect( ScrW() * 0.5 - wid * 0.5, ScrH() / 30, wid, hei )

		draw.SimpleText( CurrentProcess, "ScoreboardText", ScrW() * 0.5, hei * 1.5, Color( 255, 255, 255, 255 ), 1, 1 )
	end

end

--Create the HUD
function GM.CreateHUD()
	Hunger = 1000
	Sleepiness = 1000
	Thirst = 1000
	GAMEMODE.NeedHud = vgui.Create("gms_NeedHud")
	GAMEMODE.SkillsHud = vgui.Create("gms_SkillsHud")
	GAMEMODE.ResourcesHud = vgui.Create("gms_ResourcesHud")
	GAMEMODE.LoadingBar = vgui.Create("gms_LoadingBar")
	GAMEMODE.LoadingBar:SetVisible(false)
	GAMEMODE.SavingBar = vgui.Create("gms_SavingBar")
	GAMEMODE.SavingBar:SetVisible(false)
end

usermessage.Hook("gms_CreateInitialHUD",GM.CreateHUD)

--Make Progress bar
function GM.MakeProgressBar(um)
	CurrentProcess = um:ReadString()
	ProcessStart = RealTime()
	ProcessCompleteTime = um:ReadShort()
end

usermessage.Hook("gms_MakeProcessBar",GM.MakeProgressBar)

--Stop progress bar
function GM.StopProgressBar()
	ProcessCompleteTime = false
end

usermessage.Hook("gms_StopProcessBar",GM.StopProgressBar)

//Start a loading bar
function GM.MakeLoadingBar(um)
	GAMEMODE.LoadingBar:Show(um:ReadString())
end

usermessage.Hook("gms_MakeLoadingBar",GM.MakeLoadingBar)

//Stop loading bar
function GM.StopLoadingBar(um)
	GAMEMODE.LoadingBar:Hide()
end

usermessage.Hook("gms_StopLoadingBar",GM.StopLoadingBar)


//Start a saving bar
function GM.MakeSavingBar(um)
	GAMEMODE.SavingBar:Show(um:ReadString())
end

usermessage.Hook("gms_MakeSavingBar",GM.MakeSavingBar)

//Stop saving bar
function GM.StopSavingBar(um)
	GAMEMODE.SavingBar:Hide()
end

usermessage.Hook("gms_StopSavingBar",GM.StopSavingBar)

--Get skill
function GetSkill(skill)
	return Skills[skill] or 0
end

--Set skill
function GM.SetSkill(um)
	Skills[um:ReadString()] = um:ReadShort()

	MaxResources = 25 + (GetSkill("Survival") * 5)

	GAMEMODE.SkillsHud:RefreshSkills()
end

usermessage.Hook("gms_SetSkill",GM.SetSkill)

--Get XP
function GetXP(skill)
	return Experience[skill] or 0
end

--Set XP
function GM.SetXP(um)
	Experience[um:ReadString()] = um:ReadShort()
end

usermessage.Hook("gms_SetXP",GM.SetXP)

--Get resource
function GetResource(resource)
	return Resources[resource] or 0
end

--Set Resource
function GM.SetResource(um)
	local res = um:ReadString()
	local amount = um:ReadShort()

	Resources[res] = amount
	GAMEMODE.ResourcesHud:RefreshResources()
end

usermessage.Hook("gms_SetResource",GM.SetResource)

--Set max resources
function GM.SetMaxResources(um)
	MaxResources = um:ReadShort()
	GAMEMODE.ResourcesHud:RefreshResources()
end

usermessage.Hook("gms_SetMaxResources",GM.SetMaxResources)

--Toggle skills menu
function GM.ToggleSkillsMenu(um)
	GAMEMODE.SkillsHud:ToggleExtend()
end

usermessage.Hook("gms_ToggleSkillsMenu",GM.ToggleSkillsMenu)

--Toggle Resources menu
function GM.ToggleResourcesMenu(um)
	GAMEMODE.ResourcesHud:ToggleExtend()
end

usermessage.Hook("gms_ToggleResourcesMenu",GM.ToggleResourcesMenu)

--Open combi menu
function GM.OpenCombiMenu(um)
	local GM = GAMEMODE
	if !GM.CombiMenu then GM.CombiMenu = vgui.Create("GMS_CombinationWindow") end
	GM.CombiMenu:SetTable(um:ReadString())
	GM.CombiMenu:SetVisible(true)
end

usermessage.Hook("gms_OpenCombiMenu",GM.OpenCombiMenu)

--Close combi menu
function GM.CloseCombiMenu(um)
	local GM = GAMEMODE
	if !GM.CombiMenu then GM.CombiMenu = vgui.Create("GMS_CombinationWindow") end
	GM.CombiMenu:SetVisible(false)
end

usermessage.Hook("gms_CloseCombiMenu",GM.CloseCombiMenu)

--Other stuff
function string.Capitalize(str)
	local str = string.Explode("_",str)
	for k,v in pairs(str) do
		str[k] = string.upper(string.sub(v,1,1))..string.sub(v,2)
	end

	str = string.Implode("_",str)
	return str
end

function TraceFromEyes(dist)
	local trace = {}
	trace.start = self:GetShootPos()
	trace.endpos = trace.start + (self:GetAimVector() * dist)
	trace.filter = self

	return util.TraceLine(trace)
end

--Derma Skin
function GM:ForceDermaSkin()
	return "StrandedDermaSkin"
end 

/*---------------------------------------------------------
  Stranded-Like info messages
---------------------------------------------------------*/
GM.InfoMessages = {}
GM.InfoMessageLine = 0

function GM.SendMessage(um)
	local text = um:ReadString()
	local dur = um:ReadShort()
	local col = um:ReadString()
	local str = string.Explode(",",col)
	local col = Color(tonumber(str[1]),tonumber(str[2]),tonumber(str[3]),tonumber(str[4]))

	for k,v in pairs(GAMEMODE.InfoMessages) do
		v.drawline = v.drawline + 1
	end

	local message = {}
	message.Text = text
	message.Col = col
	message.Tab = 5
	message.drawline = 1

	GAMEMODE.InfoMessages[#GAMEMODE.InfoMessages + 1] = message
	GAMEMODE.InfoMessageLine = GAMEMODE.InfoMessageLine + 1



	timer.Simple(dur, function() GAMEMODE.DropMessage(message) end)
end

usermessage.Hook("gms_sendmessage",GM.SendMessage)

function CheckName(ent,nametable)
	for k, v in pairs(nametable) do
		if ent:GetClass() == v then return true end		
	end
end

function GM.GMS_ResourceDropsHUD()
	local ply = LocalPlayer()
	local str = nil
	local draw_loc = nil
	local w, h = nil, nil
	local tr = nil
	local cent = nil
	local pos = ply:GetShootPos()

	for _, v in ipairs(ents.GetAll()) do
		//match = CheckName(v,GMS.StructureEntities)
		if v:GetClass() == "gms_resourcedrop" then
			cent = v:LocalToWorld(v:OBBCenter())
			
			tr = {}
			tr.start = pos
			tr.endpos = cent
			tr.filter = ply

			if (cent-pos):Length() <= 200 and util.TraceLine(tr).Entity == v then
				str = (v.Res or "Loading")..": "..tostring(v.Amount or 0)
				draw_loc = cent:ToScreen()
				surface.SetFont("ChatFont")
				w, h = surface.GetTextSize(str)
 				draw.RoundedBox( 4, draw_loc.x-(w/2)-3, draw_loc.y-(h/2)-3, w+6, h+6, Color(50,50,50,200) )
				surface.SetTextColor( 255, 255, 255, 200 )
				surface.SetTextPos( draw_loc.x-(w/2), draw_loc.y-(h/2) )
				surface.DrawText( str )
			end
		end

		if match then
			
			cent = v:LocalToWorld(v:OBBCenter())
			local minimum = v:LocalToWorld(v:OBBMins())
			local maximum = v:LocalToWorld(v:OBBMaxs())
			local loc = Vector(0,0,0)
			local distance = (maximum - minimum):Length()
			if distance < 200 then distance = 200 end
			
			tr2 = {}
			tr2.start = pos
			tr2.endpos = Vector(cent.x,cent.y,pos.z)
			tr2.filter = ply
			


			if (cent-pos):Length() <= distance and (util.TraceLine(tr2).Entity == v or !util.TraceLine(tr2).Hit) then
				str = (v:GetNetworkedString('Name') or "Loading")
				if v:GetClass() == "gms_buildsite" then
				str = str..v:GetNetworkedString('Resources')
				end
				if minimum.z <= maximum.z then
					if pos.z > maximum.z then
						loc.z = maximum.z
					elseif pos.z < minimum.z then
						loc.z = minimum.z
					else
						loc.z = pos.z
					end
				else
					if pos.z < maximum.z then
						loc.z = maximum.z
					elseif pos.z > minimum.z then
						loc.z = minimum.z
					else
						loc.z = pos.z
					end
				end
				draw_loc = Vector(cent.x,cent.y,loc.z):ToScreen()
				surface.SetFont("ChatFont")
				w, h = surface.GetTextSize(str)
 				draw.RoundedBox( 4, draw_loc.x-(w/2)-3, draw_loc.y-(h/2)-3, w+6, h+6, Color(50,50,50,200) )
				surface.SetTextColor( 255, 255, 255, 200 )
				surface.SetTextPos( draw_loc.x-(w/2), draw_loc.y-(h/2) )
				surface.DrawText( str )
			end
		end
	end
end
hook.Add( "HUDPaint", "GMS_ResourceDropsHUD", GM.GMS_ResourceDropsHUD )

function GM.DrawMessages()
	for k,msg in pairs(GAMEMODE.InfoMessages) do
		local txt = msg.Text
		local line = ScrH() / 2 + (msg.drawline * 20)
		local tab = msg.Tab
		local col = msg.Col
		draw.SimpleTextOutlined(txt,"ScoreboardText",tab,line,col,0,0,0.5,Color(100,100,100,150))

		if msg.Fading then
			msg.Tab = msg.Tab - (msg.InitTab - msg.Tab - 0.05)

			if msg.Tab > ScrW() + 10 then
				GAMEMODE.RemoveMessage(msg)
			end
		end
	end
end

hook.Add("HUDPaint","gms_drawmessages",GM.DrawMessages)

function GM.DropMessage(msg)
	msg.InitTab = msg.Tab
	msg.Fading = true
end

function GM.RemoveMessage(msg)
	for k,v in pairs(GAMEMODE.InfoMessages) do
		if v == msg then
			GAMEMODE.InfoMessages[k] = nil
			GAMEMODE.InfoMessageLine = GAMEMODE.InfoMessageLine - 1
			table.remove(GAMEMODE.InfoMessages,k)
		end
	end
end
/*---------------------------------------------------------
  Prop fading
---------------------------------------------------------*/
GM.FadingProps = {}
function GM.AddFadingProp(um)
	local mdl = um:ReadString()
	local pos = um:ReadVector()
	local dir = um:ReadVector()
	local speed = um:ReadShort()

	if !mdl or !pos or !dir or !speed then return end

	local ent = ents.Create("prop_physics")
	ent:SetModel(mdl)
	ent:SetPos(pos)
	ent:SetAngles(dir:Angle())
	ent:Spawn()

	ent.Alpha = 255
	ent.Speed = speed

	table.insert(GAMEMODE.FadingProps,ent)
end

usermessage.Hook("gms_CreateFadingProp",GM.AddFadingProp)

function GM.FadeFadingProps()
	local GM = GAMEMODE

	for k,v in pairs(GM.FadingProps) do
		if v.Alpha <= 0 then
			v.Entity:Remove()
			table.remove(GM.FadingProps,k)
		else
			v.Alpha = v.Alpha - (1 * v.Speed)
			v.Entity:SetColor(Color(255,255,255,v.Alpha))
		end
	end
end

hook.Add("Think","gms_FadeFadingPropsHook",GM.FadeFadingProps)

/*---------------------------------------------------------
  Achievement Messages
---------------------------------------------------------*/
GM.AchievementMessages = {}

function GM.SendAchievement(um)
	local text = um:ReadString()

	local tbl = {}
	tbl.Text = text
	tbl.Alpha = 255

	table.insert(GAMEMODE.AchievementMessages,tbl)
end

usermessage.Hook("gms_sendachievement",GM.SendAchievement)


function GM.DrawAchievementMessages()
	for k,msg in pairs(GAMEMODE.AchievementMessages) do
		msg.Alpha = msg.Alpha - 1
		draw.SimpleTextOutlined(msg.Text,"ScoreboardHead",ScrW() / 2,ScrH() / 2,Color(255,255,255,msg.Alpha),1,1,0.5,Color(100,100,100,msg.Alpha))

		if msg.Alpha <= 0 then
			table.remove(GAMEMODE.AchievementMessages,k)
		end
	end
end

hook.Add("HUDPaint","gms_drawachievementmessages",GM.DrawAchievementMessages)
/*---------------------------------------------------------
  Needs
---------------------------------------------------------*/
function GM.SetNeeds(um)
	Sleepiness = um:ReadShort()
	Hunger = um:ReadShort()
	Thirst = um:ReadShort()
end
usermessage.Hook("gms_setneeds",GM.SetNeeds)

function GM.DecNeeds()

	if Sleepiness > 0 then Sleepiness = Sleepiness - 1 end
	if Thirst > 0 then Thirst = Thirst - 3 end
	if Hunger > 0 then Hunger = Hunger - 1 end
	timer.Simple(1,GAMEMODE.DecNeeds)

end
timer.Simple(1,GM.DecNeeds)
/*---------------------------------------------------------
  Help Menu
---------------------------------------------------------*/
function GM.OpenHelpMenu()
	local GM = GAMEMODE

	GM.HelpMenu = vgui.Create("DFrame")
	GM.HelpMenu:MakePopup()
	GM.HelpMenu:SetMouseInputEnabled(true)
	GM.HelpMenu:SetPos(50,50)
	GM.HelpMenu:SetSize(ScrW() - 100, ScrH() - 100)

	GM.HelpMenu:SetTitle("Welcome to GMStranded 2.2")

	GM.HelpMenu.HTML = vgui.Create("HTML",GM.HelpMenu)
	GM.HelpMenu.HTML:SetSize(GM.HelpMenu:GetWide() - 50, GM.HelpMenu:GetTall() - 50)
	GM.HelpMenu.HTML:SetPos(25,25)
	GM.HelpMenu.HTML:SetHTML(file.Read("GMStranded/Help/help.htm", "DATA"))
end

concommand.Add("gms_help",GM.OpenHelpMenu)

/*---------------------------------------------------------
  Sleep
---------------------------------------------------------*/
function GM.SleepOverlay()
	if !SleepFadeIn and !SleepFadeOut then return end

	if SleepFadeIn and SleepFade < 250 then
		SleepFade = SleepFade + 5
	elseif SleepFadeIn and SleepFade >= 255 then
		SleepFadeIn = false
	end

	if SleepFadeOut and SleepFade > 0 then
		SleepFade = SleepFade - 5
	elseif SleepFadeOut and SleepFade <= 0 then
		SleepFadeOut = false
	end

	surface.SetDrawColor(0,0,0,SleepFade)
	surface.DrawRect(0,0,ScrW(),ScrH())

	draw.SimpleText("Use the command \"!wakeup\" to wake up.","ScoreboardSub",ScrW() / 2, ScrH() / 2, Color(255,255,255,SleepFade),1,1)
end

hook.Add("HUDPaint","gms_sleepoverlay",GM.SleepOverlay)

function GM.StartSleep(um)
	SleepFadeIn = true
	SleepFade = 0
end

usermessage.Hook("gms_startsleep",GM.StartSleep)

function GM.StopSleep(um)
	SleepFadeOut = true
	SleepFade = 255
end

usermessage.Hook("gms_stopsleep",GM.StopSleep)

/*---------------------------------------------------------
  AFK
---------------------------------------------------------*/

function GM.AFKOverlay()
	if !AFKFadeIn and !AFKFadeOut then return end

	if AFKFadeIn and AFKFade < 250 then
		AFKFade = AFKFade + 5
	elseif AFKFadeIn and AFKFade >= 255 then
		AFKFadeIn = false
	end

	if AFKFadeOut and AFKFade > 0 then
		AFKFade = AFKFade - 5
	elseif AFKFadeOut and AFKFade <= 0 then
		AFKFadeOut = false
	end

	surface.SetDrawColor(0,0,0,AFKFade)
	surface.DrawRect(0,0,ScrW(),ScrH())

	draw.SimpleText("Use the command \"!afk\" to stop being afk.","ScoreboardSub",ScrW() / 2, ScrH() / 2, Color(255,255,255,AFKFade),1,1)
end

hook.Add("HUDPaint","gms_afkoverlay",GM.AFKOverlay)

function GM.StartAFK(um)
	AFKFadeIn = true
	AFKFade = 0
end

usermessage.Hook("gms_startafk",GM.StartAFK)

function GM.StopAFK(um)
	AFKFadeOut = true
	AFKFade = 255
end

usermessage.Hook("gms_stopafk",GM.StopAFK)

/*---------------------------------------------------------
  Unlock system
---------------------------------------------------------*/
function GM.AddUnlock(um)
	local text = um:ReadString()
	local GM = GAMEMODE

	if !GM.UnlockWindow then GM.UnlockWindow = vgui.Create("GMS_UnlockWindow") end

	GM.UnlockWindow:SetMouseInputEnabled(true)
	GM.UnlockWindow:SetUnlock(text)
	GM.UnlockWindow:SetVisible(true)
end

usermessage.Hook("gms_AddUnlock",GM.AddUnlock)

/*---------------------------------------------------------
  Drop resource menu
---------------------------------------------------------*/
function GM.OpenDropResourceWindow()
	local GM = GAMEMODE

	if !GM.ResourceWindow then GM.ResourceWindow = vgui.Create("GMS_ResourceDropWindow") end

	GM.ResourceWindow:RefreshList()
	GM.ResourceWindow:SetVisible(!GM.ResourceWindow:IsVisible())
end

concommand.Add("gms_OpenDropResourceWindow",GM.OpenDropResourceWindow)

/*---------------------------------------------------------
  Admin menu
---------------------------------------------------------*/
function GM.OpenAdminMenu()
	if !LocalPlayer():IsAdmin() then return end
	local GM = GAMEMODE

	if !GM.AdminMenu then
	GM.AdminMenu = vgui.Create("GMS_AdminMenu")
	GM.AdminMenu:SetVisible(false)
	end
	

	GM.AdminMenu:SetVisible(!GM.AdminMenu:IsVisible())
end

concommand.Add("gms_admin",GM.OpenAdminMenu)

function GM.AddLoadGame(um)
	local GM = GAMEMODE
	if !GM.AdminMenu then GM.AdminMenu = vgui.Create("GMS_AdminMenu") end

	local str = um:ReadString()
	GM.AdminMenu.LoadGameEntry:AddItem(str,str)

	GM.AdminMenu:SetVisible(false)
end

usermessage.Hook("gms_AddLoadGameToList",GM.AddLoadGame)

function GM.RemoveLoadGame(um)
	local GM = GAMEMODE
	if !GM.AdminMenu then GM.AdminMenu = vgui.Create("GMS_AdminMenu") end

	local str = um:ReadString()
	GM.AdminMenu.LoadGameEntry:RemoveItem(str)

end

usermessage.Hook("gms_RemoveLoadGameFromList",GM.RemoveLoadGame)

/*---------------------------------------------------------
  Tribe menu
---------------------------------------------------------*/
function GM.OpenTribeMenu()
         local GM = GAMEMODE

         if !GM.TribeMenu then GM.TribeMenu = vgui.Create("GMS_TribeMenu") end

         GM.TribeMenu:SetVisible(!GM.TribeMenu:IsVisible())
end

concommand.Add("gms_tribemenu",GM.OpenTribeMenu)

/*---------------------------------------------------------
   Tribe system
---------------------------------------------------------*/
function GM.getTribes(data)
	team.SetUp(data:ReadShort(),data:ReadString(),Color(data:ReadShort(),data:ReadShort(),data:ReadShort(),255))
end
usermessage.Hook("recvTribes",GM.getTribes)

function GM.ReceiveTribe(data)
	local name = data:ReadString()
	local id = data:ReadShort()
	local red = data:ReadShort()
	local green = data:ReadShort()
	local blue = data:ReadShort()
	team.SetUp(id,name,Color(red,green,blue,255))
end
usermessage.Hook("newTribe",GM.ReceiveTribe)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      