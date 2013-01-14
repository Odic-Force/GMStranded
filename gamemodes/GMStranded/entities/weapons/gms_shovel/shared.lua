if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if (CLIENT) then
	SWEP.PrintName			= "Shovel"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	SWEP.Slot = 3
	SWEP.SlotPos		= 3
end



SWEP.Author		= "Stranded Team"
SWEP.Contact		= ""
SWEP.Purpose		= "Dig."
SWEP.Instructions	= "Use primary to dig."


SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/v_shovel.mdl"
SWEP.WorldModel			= "models/weapons/w_shovel.mdl"

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
    local tr = self.Owner:TraceFromEyes(150)

    if tr.HitWorld then
        if (tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS or tr.MatType == MAT_SAND) then
            if tr.MatType == MAT_SAND then
                self.Owner:DoProcess("Dig",5,{Sand=True})
            else
                self.Owner:DoProcess("Dig",5)
            end
        else
            self.Owner:SendMessage("Can't dig on this terrain!",3,Color(200,0,0,255))
            self.Owner:EmitSound(Sound("physics/concrete/concrete_impact_hard"..math.random(1,3)..".wav"))
        end
    end
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end