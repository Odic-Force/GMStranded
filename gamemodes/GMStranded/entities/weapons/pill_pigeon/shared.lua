if CLIENT then
	include("pigeon.lua")
	SWEP.PrintName = "Crow Pill"
	SWEP.Slot = 5
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
		draw.SimpleText("j", "TitleFont", x + wide / 2, y + tall * 0.2, Color(255, 210, 0, 255), TEXT_ALIGN_CENTER)
	end
else
	AddCSLuaFile("shared.lua")
	AddCSLuaFile("pigeon.lua")
	include("pigeon.lua")
	SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end

SWEP.Author = "grea$emonkey"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Press reload to make a cute sound.\nJump to start flying, jump again to speed up."

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize, SWEP.Secondary.ClipSize = -1, -1
SWEP.Primary.DefaultClip, SWEP.Secondary.DefaultClip = -1, -1
SWEP.Primary.Automatic, SWEP.Primary.Automatic = false, false
SWEP.Primary.Ammo, SWEP.Secondary.Ammo = "none", "none"
SWEP.ViewModel = Model("models/weapons/v_crowbar.mdl")
SWEP.WorldModel = Model("models/weapons/w_crowbar.mdl")

function SWEP:Initialize()
	CROW.HooksEnable()
end

function SWEP:Destroy()
	CROW.HooksDisable()
end

function SWEP:Deploy()
	CROW.Enable(self.Owner)
	if CLIENT then return end
	self.Owner:DrawViewModel(false)
	timer.Create("viewmodel" .. self.Owner:UniqueID(), 0.01, 1, self.Owner.DrawViewModel, self.Owner, false)
	self.Owner:DrawWorldModel(false)
	umsg.Start("CROW.enable", self.Owner)
	umsg.End()
	return true
end

function SWEP:Holster()
	CROW.Disable(self.Owner)
	if CLIENT then return end
	if self.Owner:Health() <= 0 then
		umsg.Start("CROW.disable", self.Owner)
		umsg.End()
	end
	return true
end

function SWEP:Reload()
	if CLIENT then return false end
	CROW.Idle(self.Owner)
end

function SWEP:SecondaryAttack()
	if CLIENT then return false end
	CROW.Burrow(self.Owner)
end

function SWEP:Think()
	if CLIENT then return end
	
	if not self.Owner:Crouching() then
		self.Owner:ConCommand("+duck\n")
	end
	
	CROW.AttackThink(self.Owner)
	CROW.BurrowThink(self.Owner)
	
	if self.Owner:Health() < 60 then
		self.Owner:SetMoveType(2)
	end

end
