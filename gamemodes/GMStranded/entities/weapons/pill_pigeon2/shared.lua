if CLIENT then
	include("pigeon.lua")
	SWEP.PrintName = "Pigeon Pill"
	SWEP.Slot = 0
	SWEP.SlotPos = 5
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
SWEP.Instructions = "Left click to poop, right click to eat.\nJump to start flying, jump again to speed up."

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize, SWEP.Secondary.ClipSize = -1, -1
SWEP.Primary.DefaultClip, SWEP.Secondary.DefaultClip = -1, -1
SWEP.Primary.Automatic, SWEP.Primary.Automatic = false, false
SWEP.Primary.Ammo, SWEP.Secondary.Ammo = "none", "none"
SWEP.ViewModel = Model("models/weapons/v_bugbait.mdl")
SWEP.WorldModel = Model("models/weapons/w_bugbait.mdl")

function SWEP:Initialize()
	PIGEON.HooksEnable()
end

function SWEP:Destroy()
	PIGEON.HooksDisable()
end

function SWEP:Deploy()
	PIGEON.Enable(self.Owner)
	if CLIENT then return end
	self.Owner:DrawViewModel(false) // this doesn't seem to work in deploy...
	timer.Create("viewmodel" .. self.Owner:UniqueID(), 0.01, 1, self.Owner.DrawViewModel, self.Owner, false) // so i use a timer
	self.Owner:DrawWorldModel(false)
	// ensure pigeon is enabled since deploy isn't called correctly on the
	// clientside when a player spawns with a weapon
	umsg.Start("pigeon.enable", self.Owner)
	umsg.End()
	return true
end

function SWEP:Holster()
	PIGEON.Disable(self.Owner)
	if CLIENT then return end
	if self.Owner:Health() <= 0 then
		// holster isn't called correctly on the client
		// when they die with the weapon in their hands
		umsg.Start("pigeon.disable", self.Owner)
		umsg.End()
	end
	self.Owner:DrawViewModel(true)
	self.Owner:DrawWorldModel(true)
	return true
end

function SWEP:PrimaryAttack()
	if CLIENT then return false end
	PIGEON.Attack(self.Owner)
end

function SWEP:Reload()
	if CLIENT then return false end
	PIGEON.Idle(self.Owner)
end

function SWEP:SecondaryAttack()
	if CLIENT then return false end
	PIGEON.Burrow(self.Owner)
end

function SWEP:Think()
	if CLIENT then return end
	
	if not self.Owner:Crouching() then
		self.Owner:ConCommand("+duck\n")
	end
	
	PIGEON.AttackThink(self.Owner)
	PIGEON.BurrowThink(self.Owner)
	
	if self.Owner:Health() < 60 then
		self.Owner:SetMoveType(2)
	end

end
