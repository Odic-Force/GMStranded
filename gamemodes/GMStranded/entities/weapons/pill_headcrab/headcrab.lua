// TOFIX: vehicles
// TOFIX: looking up jumps backwards

HEADCRAB = {}

HEADCRAB.BURROWIN = 1
HEADCRAB.BURROWOUT = 2
HEADCRAB.BURROWED = 3

HEADCRAB.damage = 25
HEADCRAB.model = Model("models/headcrabclassic.mdl")
HEADCRAB.sounds = {}
HEADCRAB.sounds.attack = Sound("NPC_Headcrab.Attack")
HEADCRAB.sounds.attackHit = Sound("Weapon_Crowbar.Melee_Hit")//Sound("NPC_HeadCrab.Bite")
HEADCRAB.sounds.banghowdy = Sound("Weapon_Bugbait.Splat")
HEADCRAB.sounds.burrowIn = Sound("NPC_Headcrab.BurrowIn")
HEADCRAB.sounds.burrowOut = Sound("NPC_Headcrab.BurrowOut")
HEADCRAB.sounds.idle = Sound("NPC_Headcrab.Alert")
HEADCRAB.sounds.pain = Sound("NPC_Headcrab.Pain")

HEADCRAB.Hooks = {}

// -----------------------------------------------------------------------------
// HELPER FUNCTIONS

function HEADCRAB.Enable(player)
	if player.headcrab then return end
	if CLIENT then
		player.headcrab = true
		return
	end
	GAMEMODE:SetPlayerSpeed(player, 250, 500)
	player:ConCommand("-duck\n")
	HEADCRAB.BangHowdy(player)
	player.headcrab = {}
	player.headcrab.attacking = false
	player.headcrab.attackingTimer = 0
	player.headcrab.burrowed = nil
	player.headcrab.burrowedTimer = 0
	player.headcrab.idleTimer = 0
	player.headcrab.model = player:GetModel()
	player:SetModel(HEADCRAB.model)
	player.headcrab.ghost = HEADCRAB.Ghost(player)
	player:SetNetworkedEntity("headcrab.ghost", player.headcrab.ghost)
	if not player.headcrabHasPrinted then
		player:PrintMessage(HUD_PRINTTALK, "You're a headcrab! AWESOME.\nPrimary for jump attack, secondary to burrow.\nReload to be a noisy bum.\n")
		player.headcrabHasPrinted = true
	end
end

function HEADCRAB.Disable(player)
	player:ConCommand("-duck\n")
	if CLIENT then
		player.headcrab = false
		return
	end
	if not player.headcrab then return end
	HEADCRAB.BangHowdy(player)
	player.headcrab.ghost:Remove()
	player:SetNetworkedEntity("headcrab.ghost", nil)
	player:SetModel(player.headcrab.model)
	player:SetMoveType(MOVETYPE_WALK)
	player.headcrab = nil
end

if CLIENT then
	function HEADCRAB.EnableMessage(um)
		local weapon = LocalPlayer():GetActiveWeapon()
		if not weapon or not weapon:IsValid() or not weapon:IsWeapon() or weapon:GetClass() != "pill_headcrab" then
			return
		end
		HEADCRAB.Enable(LocalPlayer())
	end
	usermessage.Hook("headcrab.enable", HEADCRAB.EnableMessage)

	function HEADCRAB.DisableMessage(um)
		local weapon = LocalPlayer():GetActiveWeapon()
		if weapon and weapon:IsValid() and weapon:IsWeapon() and weapon:GetClass() == "pill_headcrab" then
			return
		end
		HEADCRAB.Disable(LocalPlayer())
	end
	usermessage.Hook("headcrab.disable", HEADCRAB.DisableMessage)
end

function HEADCRAB.Attack(player)
	if not player.headcrab.attacking and CurTime() >= player.headcrab.attackingTimer and not player.headcrab.burrowed then
		player.headcrab.attacking = true
		player.headcrab.attackingTimer = CurTime() + 0.05
		player:EmitSound(HEADCRAB.sounds.attack)
		local v = player:GetForward() * 350
		v.z = math.min(v.z + 400, 500)
		player:SetVelocity(v)
	end
end

function HEADCRAB.AttackDamage(player, tr)
	if tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
		player:EmitSound(HEADCRAB.sounds.attackHit)
	end
	if tr.Entity.TakeDamage then
		tr.Entity:TakeDamage(HEADCRAB.damage, player)
   	else
		bullet = {}
		bullet.Num = 1
		bullet.Src = player:GetShootPos()
		bullet.Dir = (tr.Entity:GetPos() - player:GetShootPos()):Normalize()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force = 1
		bullet.Damage = HEADCRAB.damage * 2
		player:FireBullets(bullet) 
   	end
	local ed = EffectData()
	ed:SetEntity(tr.Entity)
	ed:SetNormal(tr.HitNormal)
	ed:SetOrigin(tr.HitPos)
	ed:SetStart(tr.HitPos)
	util.Effect("BloodImpact", ed)
end

function HEADCRAB.AttackThink(player)
	if not player.headcrab.attacking then return end
	if not player:OnGround() then
		local t = {}
		t.start = player:GetPos()
		t.endpos = t.start + player:GetForward() * 20
		t.filter = player
		local tr = util.TraceEntity(t, player.headcrab.ghost)
		if tr.Hit and tr.HitNonWorld and tr.Entity and tr.Entity:IsValid() then
			player.headcrab.attacking = false
			HEADCRAB.AttackDamage(player, tr)
		else
			t.endpos = t.start + Vector(0, 0, -20)
			tr = util.TraceEntity(t, player.headcrab.ghost)
			if tr.Hit and tr.HitNonWorld and tr.Entity and tr.Entity:IsValid() then
				player.headcrab.attacking = false
				HEADCRAB.AttackDamage(player, tr)
			end
		end
	else
		player.headcrab.attacking = false
	end
	player.headcrab.attackingTimer = CurTime() + 0.05
end

function HEADCRAB.BangHowdy(player)
	local ed = EffectData()
	ed:SetOrigin(player:GetPos())
	ed:SetStart(player:GetPos())
	ed:SetScale(1000)
	//util.Effect("Explosion", ed)
	util.Effect("cball_explode", ed)
	player:EmitSound(HEADCRAB.sounds.banghowdy)
end

function HEADCRAB.Burrow(player)
	if player.headcrab.burrowed != HEADCRAB.BURROWED and CurTime() < player.headcrab.burrowedTimer then return end
	if not player.headcrab.burrowed then
		if player.headcrab.attacking or not player:OnGround() then
			return
		end 
		local t = {}
		t.start = player:GetPos()
		t.endpos = t.start + Vector(0, 0, -20)
		t.filter = player
		local tr = util.TraceLine(t)
		if not tr.HitWorld or not (tr.MatType == MAT_DIRT or tr.MatType == MAT_FOLIAGE or tr.MatType == MAT_SAND) then
			player:PrintMessage(HUD_PRINTTALK, "You can't burrow into that. Look for some dirt!")
			return
		end
		player:EmitSound(HEADCRAB.sounds.burrowIn)
		player:SetMoveType(MOVETYPE_NONE)
		player.headcrab.burrowed = HEADCRAB.BURROWIN
		player.headcrab.burrowedTimer = CurTime() + 1.4
	else
		player:EmitSound(HEADCRAB.sounds.burrowOut)
		player:DrawShadow(true)
		player.headcrab.ghost:DrawShadow(true)
		player.headcrab.burrowed = HEADCRAB.BURROWOUT
		player.headcrab.burrowedTimer = CurTime() + 1.5
	end
end

function HEADCRAB.BurrowThink(player)
	if not player.headcrab.burrowed then return end
	if CurTime() >= player.headcrab.burrowedTimer then
		if player.headcrab.burrowed == HEADCRAB.BURROWIN then
			player:DrawShadow(false)
			player.headcrab.ghost:DrawShadow(false)
			player.headcrab.burrowed = HEADCRAB.BURROWED
		elseif player.headcrab.burrowed == HEADCRAB.BURROWOUT then
			player:SetMoveType(MOVETYPE_WALK)
			player.headcrab.burrowed = false
		elseif player.headcrab.burrowed == HEADCRAB.BURROWED then
			local health = player:Health()
			if health < player:GetMaxHealth() then player:SetHealth(health + 1) end
			player.headcrab.burrowedTimer = CurTime() + 1
		end
	end
end

function HEADCRAB.Ghost(player)
	local e = ents.Create("prop_dynamic")
	e:SetAngles(player:GetAngles())
	e:SetCollisionGroup(COLLISION_GROUP_NONE)
	e:SetColor(Color(255, 255, 255, 0))
	e:SetMoveType(MOVETYPE_NONE)
	e:SetModel(HEADCRAB.model)
	e:SetParent(player)
	e:SetPos(player:GetPos())
	e:SetRenderMode(RENDERMODE_TRANSALPHA)
	e:SetSolid(SOLID_NONE)
	e:Spawn()
	return e
end

function HEADCRAB.Idle(player)
	if CurTime() >= player.headcrab.idleTimer then
		player.headcrab.idleTimer = CurTime() + 2
		player:EmitSound(HEADCRAB.sounds.idle)
	end
end

// =============================================================================
// HOOKS

function HEADCRAB.HooksEnable()
	if CLIENT then
		hook.Add("CalcView", "HEADCRAB.CalcView", HEADCRAB.Hooks.CalcView)
	else
		hook.Add("KeyPress", "HEADCRAB.KeyPress", HEADCRAB.Hooks.KeyPress)
		hook.Add("PlayerHurt", "HEADCRAB.PlayerHurt", HEADCRAB.Hooks.Hurt)
		hook.Add("PlayerSetModel", "HEADCRAB.PlayerSetModel", HEADCRAB.Hooks.SetModel)
		hook.Add("SetPlayerAnimation", "HEADCRAB.SetPlayerAnimation", HEADCRAB.Hooks.SetAnimation)
		hook.Add("UpdateAnimation", "HEADCRAB.UpdateAnimation", HEADCRAB.Hooks.UpdateAnimation)
	end
end

function HEADCRAB.HooksDisable()
	if CLIENT then
		hook.Remove("CalcView", "HEADCRAB.CalcView")
	else
		hook.Remove("KeyPress","HEADCRAB.KeyPress")
		hook.Remove("PlayerHurt", "HEADCRAB.PlayerHurt")
		hook.Remove("PlayerSetModel", "HEADCRAB.PlayerSetModel")
		hook.Remove("SetPlayerAnimation", "HEADCRAB.SetPlayerAnimation")
		hook.Remove("UpdateAnimation", "HEADCRAB.UpdateAnimation")
	end
end

// CLIENT HOOKS

function HEADCRAB.Hooks.CalcView(player, pos, ang, fov)
	if not player.headcrab then
		return
	end
	ang = player:GetAimVector():Angle()
	local ghost = player:GetNetworkedEntity("headcrab.ghost")
	if ghost and ghost:IsValid() then
		if GetViewEntity() == player then
			ghost:SetColor(Color(255,255,255,255))
		else
			ghost:SetColor(Color(255, 255, 255, 0))
			return
		end
	end
	local t = {}
	t.start = player:GetPos() + ang:Up() * 20
	t.endpos = t.start + ang:Forward() * -50
	t.filter = player
	local tr = util.TraceLine(t)
	pos = tr.HitPos
	if tr.Fraction < 1 then
		pos = pos + tr.HitNormal * 2
	end
	return GAMEMODE:CalcView(player, pos, ang, fov)
end

// SERVER HOOKS

function HEADCRAB.Hooks.Hurt(player, attacker)
	if player.headcrab then
		player:EmitSound(HEADCRAB.sounds.pain)
	end
end

function HEADCRAB.Hooks.KeyPress(player, key)
	if not player.headcrab then return end
	if key == IN_JUMP then
		player:GetActiveWeapon():PrimaryAttack()
	end
end

function HEADCRAB.Hooks.SetAnimation(player, animation)
	if player.headcrab then
		return false
	end
end

function HEADCRAB.Hooks.SetModel(player)
	if player.headcrab then
		return false
	end
end

function HEADCRAB.Hooks.UpdateAnimation(player)
	if not player.headcrab then
		return
	end
	local rate = 1
	local sequence = "idle01"
	local speed = player:GetVelocity():Length()
	if not player.headcrab.burrowed then
		if player:OnGround() then
			if speed > 0 then
				sequence = "run1"
				if speed > 300 then
					rate = 1.5
				end
			end
		else
			if player:WaterLevel() > 1 then
				sequence = "drown"
			else
				sequence = "jumpattack_broadcast"
			end
		end
	else
		if player.headcrab.burrowed == HEADCRAB.BURROWIN then
			sequence = "burrowin"
		elseif player.headcrab.burrowed == HEADCRAB.BURROWOUT then
			sequence = "burrowout"
		else
			sequence = "burrowidle"
		end
	end
	local sequenceIndex = player:LookupSequence(sequence)
	if player:GetSequence() != sequenceIndex then
		player:ResetSequence(sequenceIndex)
	end
	sequenceIndex = player.headcrab.ghost:LookupSequence(sequence)
	if player.headcrab.ghost:GetSequence() != sequenceIndex then
		player.headcrab.ghost:Fire("setanimation", sequence, 0)
	end
	player:SetPlaybackRate(rate)
	player.headcrab.ghost:SetPlaybackRate(rate)
end
