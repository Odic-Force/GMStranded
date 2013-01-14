if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if (CLIENT) then
	SWEP.PrintName			= "Stone Pickaxe"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	SWEP.Slot = 2
	SWEP.SlotPos		= 2
end

SWEP.Author		= "Stranded Team"
SWEP.Contact		= ""
SWEP.Purpose		= "Effective mining tool."
SWEP.Instructions	= "Primary fire: Mine from a rock or rocky surface."


SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/v_stone_pickaxe.mdl"
SWEP.WorldModel			= "models/weapons/w_stone_pickaxe.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

/*---------------------------------------------------------
	Initialize
---------------------------------------------------------*/
function SWEP:Initialize()
end
/*---------------------------------------------------------
	Reload
---------------------------------------------------------*/
function SWEP:Reload()
end

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
    if CLIENT then return end
    self.Weapon:SetNextPrimaryFire(CurTime() + 1)
    self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
    self.Owner:EmitSound(Sound("weapons/iceaxe/iceaxe_swing1.wav"))

    local trace = {}
    trace.start = self.Owner:GetShootPos()
    trace.endpos = trace.start + (self.Owner:GetAimVector() * 150)
    trace.filter = self.Owner

    local tr = util.TraceLine(trace)
    if !tr.HitNonWorld then return end
    if !tr.Entity then return end

    if tr.Entity:IsRockModel() or tr.Entity:GetModel() == GMS.SmallRockModel then
        local data = {}
        data.Entity = tr.Entity
        data.Chance = 50
        data.MinAmount = 1
        data.MaxAmount = 3
        self.Owner:DoProcess("Mining",2,data)
    end
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end