if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if (CLIENT) then
	SWEP.PrintName			= "Strainer"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	SWEP.Slot = 4
	SWEP.SlotPos		= 5
end

SWEP.Author		= "Stranded Team"
SWEP.Contact		= ""
SWEP.Purpose		= "Get fine materials."
SWEP.Instructions	= "Use on/with some materials to filter them."


SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"

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
    self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
    local tr = self.Owner:TraceFromEyes(150)
    if tr.HitWorld then
        if (tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS or tr.MatType == MAT_SAND) then
            self.Owner:DoProcess("FilterGround",3)
        end
    end
end

function SWEP:Deploy()
    timer.Simple(0.1,function() self:HideWeapon(self,false) end)
    return true
end

function SWEP:HideWeapon(bool)
    if SERVER and self.Owner then self.Owner:DrawViewModel(bool) end
end

function SWEP:Holster()
    timer.Simple(0.1,self.HideWeapon,self,true)
    return true
end