// TOFIX: vehicles
// TOFIX: looking up jumps backwards

PIGEON = {}

PIGEON.BURROWIN = 1
PIGEON.BURROWOUT = 2
PIGEON.BURROWED = 3

PIGEON.damage = 25
PIGEON.model = Model("models/pigeon.mdl")
PIGEON.sounds = {}
PIGEON.sounds.attack = Sound("Weapon_Bugbait.Splat")
PIGEON.sounds.attackHit = Sound("Weapon_Crowbar.Melee_Hit")//Sound("NPC_Pigeon.Bite")
PIGEON.sounds.banghowdy = Sound("Weapon_Bugbait.Splat")
PIGEON.sounds.burrowIn = Sound("NPC_Pigeon.BurrowIn")
PIGEON.sounds.burrowOut = Sound("NPC_Pigeon.BurrowOut")
PIGEON.sounds.idle = Sound("bird_sounds/pigeon_idle2.wav", 100, 100)
PIGEON.sounds.pain = Sound("bird_sounds/pigeon_idle4.wav", 100, 100)

PIGEON.Hooks = {}

// -----------------------------------------------------------------------------
// HELPER FUNCTIONS

function PIGEON.Enable(player)
	if player.pigeon then return end
	if CLIENT then
		player.pigeon = true
		return
	end
	GAMEMODE:SetPlayerSpeed(player, 250, 500)
	player:ConCommand("-duck\n")
	PIGEON.BangHowdy(player)
	player.pigeon = {}
	player.pigeon.attacking = false
	player.pigeon.attackingTimer = 0
	player.pigeon.burrowed = nil
	player.pigeon.burrowedTimer = 0
	player.pigeon.idleTimer = 0
	player.pigeon.model = player:GetModel()
	player:SetModel(PIGEON.model)
	player.pigeon.ghost = PIGEON.Ghost(player)
	player:SetNetworkedEntity("pigeon.ghost", player.pigeon.ghost)
	if not player.pigeonHasPrinted then
		player:PrintMessage(HUD_PRINTTALK, "You're a pigeon! AWESOME!\nUse primary to poop, and secondary to eat.\nJump to start flying and then jump again to speed up.\nSprint to hop forward.\nReload to make a cute noise.\n")
		player.pigeonHasPrinted = true
	end
	player.pigeon.LastEatenTimer = CurTime() + 15
end

function PIGEON.Disable(player)
	player:ConCommand("-duck\n")
	if CLIENT then
		player.pigeon = false
		return
	end
	if not player.pigeon then return end
	PIGEON.BangHowdy(player)
	player.pigeon.ghost:Remove()
	player:SetNetworkedEntity("pigeon.ghost", nil)
	player:SetModel(player.pigeon.model)
	player:SetMoveType(MOVETYPE_WALK)
	player.pigeon = nil
end

if CLIENT then
	function PIGEON.EnableMessage(um)
		local weapon = LocalPlayer():GetActiveWeapon()
		if not weapon or not weapon:IsValid() or not weapon:IsWeapon() or weapon:GetClass() != "pill_pigeon" then
			return
		end
		PIGEON.Enable(LocalPlayer())
	end
	usermessage.Hook("pigeon.enable", PIGEON.EnableMessage)

	function PIGEON.DisableMessage(um)
		local weapon = LocalPlayer():GetActiveWeapon()
		if weapon and weapon:IsValid() and weapon:IsWeapon() and weapon:GetClass() == "pill_pigeon" then
			return
		end
		PIGEON.Disable(LocalPlayer())
	end
	usermessage.Hook("pigeon.disable", PIGEON.DisableMessage)
end

function PIGEON.Attack(player)
	if not player.pigeon.attacking and CurTime() >= player.pigeon.attackingTimer and not player.pigeon.burrowed then
		player.pigeon.attacking = true
		player.pigeon.attackingTimer = CurTime() + 1
		player:EmitSound(PIGEON.sounds.attack)
		local birdpoop = ents.Create("birdpoop")
		birdpoop:Spawn()
		birdpoop:Activate()
		birdpoop:SetColor(Color(255,255,255,255))
		birdpoop:SetPos(player:GetPos() + Vector(0,0,-1))
		birdpoop:SetOwner(player)
	end
end

function PIGEON.AttackDamage(player, tr)
	if tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
		player:EmitSound(PIGEON.sounds.attackHit)
	end
end

function PIGEON.AttackThink(player)
	if not player.pigeon.attacking then return end
	if not player:OnGround() then
		local t = {}
		t.start = player:GetPos()
		t.endpos = t.start + player:GetForward() * 10
		t.filter = player
		local tr = util.TraceEntity(t, player.pigeon.ghost)
		if tr.Hit and tr.HitNonWorld and tr.Entity and tr.Entity:IsValid() then
			player.pigeon.attacking = false
			PIGEON.AttackDamage(player, tr)
		else
			t.endpos = t.start + Vector(0, 0, -20)
			tr = util.TraceEntity(t, player.pigeon.ghost)
			if tr.Hit and tr.HitNonWorld and tr.Entity and tr.Entity:IsValid() then
				player.pigeon.attacking = false
				PIGEON.AttackDamage(player, tr)
			end
		end
	else
		player.pigeon.attacking = false
	end
	if player.pigeon.LastEatenTimer >= CurTime() then
		player.pigeon.attackingTimer = CurTime() + 2
	else
		player.pigeon.attackingTimer = CurTime() + 8
	end
end

function PIGEON.BangHowdy(player)
	local ed = EffectData()
	ed:SetOrigin(player:GetPos())
	ed:SetStart(player:GetPos())
	ed:SetScale(1000)
	//util.Effect("Explosion", ed)
	util.Effect("cball_explode", ed)
	player:EmitSound(PIGEON.sounds.banghowdy)
end

function PIGEON.Burrow(player)
	if player.pigeon.burrowed != PIGEON.BURROWED and CurTime() < player.pigeon.burrowedTimer then return end
	if not player.pigeon.burrowed then
		if player.pigeon.attacking or not player:OnGround() then
			return
		end 
		local t = {}
		t.start = player:GetPos()
		t.endpos = t.start + Vector(0, 0, -20)
		t.filter = player
		local tr = util.TraceLine(t)
		if not tr.HitWorld or not (tr.MatType == MAT_DIRT or tr.MatType == MAT_FOLIAGE or tr.MatType == MAT_SAND) then
			player:PrintMessage(HUD_PRINTTALK, "You can't eat that. Look for some dirt!")
			return
		end
		player:EmitSound(PIGEON.sounds.burrowIn)
		player:SetMoveType(MOVETYPE_WALK)
		player.pigeon.burrowed = PIGEON.BURROWIN
		player.pigeon.burrowedTimer = CurTime() + 0.5
	else
		player:EmitSound(PIGEON.sounds.burrowOut)
		player:DrawShadow(true)
		player.pigeon.ghost:DrawShadow(true)
		player.pigeon.burrowed = PIGEON.BURROWOUT
		player.pigeon.burrowedTimer = CurTime() + 0.5
	end
	player.pigeon.LastEatenTimer = CurTime() + 15
end


function PIGEON.BurrowThink(player)
	local health = player:Health()
	if health >= player:GetMaxHealth() then
		player.pigeon.burrowed = false
	end
	if not player.pigeon.burrowed then return end
	if CurTime() >= player.pigeon.burrowedTimer then
		if player.pigeon.burrowed == PIGEON.BURROWIN then
			player:DrawShadow(false)
			player.pigeon.ghost:DrawShadow(false)
			player.pigeon.burrowed = PIGEON.BURROWED
		elseif player.pigeon.burrowed == PIGEON.BURROWOUT then
			player:SetMoveType(MOVETYPE_WALK)
			player.pigeon.burrowed = false
		elseif player.pigeon.burrowed == PIGEON.BURROWED then
			if health < player:GetMaxHealth() then player:SetHealth(health + 2) end
			player.pigeon.burrowedTimer = CurTime() + 1
		end
	end
end

function PIGEON.Ghost(player)
	local e = ents.Create("prop_dynamic")
	e:SetAngles(player:GetAngles())
	e:SetCollisionGroup(COLLISION_GROUP_NONE)
	e:SetColor(Color(255, 255, 255, 0))
	e:SetMoveType(MOVETYPE_NONE)
	e:SetModel(PIGEON.model)
	e:SetParent(player)
	e:SetPos(player:GetPos())
	e:SetRenderMode(RENDERMODE_TRANSALPHA)
	e:SetSolid(SOLID_NONE)
	e:Spawn()
	return e
end

function PIGEON.Idle(player)
	if CurTime() >= player.pigeon.idleTimer then
		player.pigeon.idleTimer = CurTime() + 2
		player:EmitSound("bird_sounds/pigeon_idle2.wav", 100, 100)
	end
end

// =============================================================================
// HOOKS

function PIGEON.HooksEnable()
	if CLIENT then
		hook.Add("CalcView", "PIGEON.CalcView", PIGEON.Hooks.CalcView)
	else
		hook.Add("KeyPress", "PIGEON.KeyPress", PIGEON.Hooks.KeyPress)
		hook.Add("PlayerHurt", "PIGEON.PlayerHurt", PIGEON.Hooks.Hurt)
		hook.Add("PlayerSetModel", "PIGEON.PlayerSetModel", PIGEON.Hooks.SetModel)
		hook.Add("SetPlayerAnimation", "PIGEON.SetPlayerAnimation", PIGEON.Hooks.SetAnimation)
		hook.Add("UpdateAnimation", "PIGEON.UpdateAnimation", PIGEON.Hooks.UpdateAnimation)
	end
end

function PIGEON.HooksDisable()
	if CLIENT then
		hook.Remove("CalcView", "PIGEON.CalcView")
	else
		hook.Remove("KeyPress","PIGEON.KeyPress")
		hook.Remove("PlayerHurt", "PIGEON.PlayerHurt")
		hook.Remove("PlayerSetModel", "PIGEON.PlayerSetModel")
		hook.Remove("SetPlayerAnimation", "PIGEON.SetPlayerAnimation")
		hook.Remove("UpdateAnimation", "PIGEON.UpdateAnimation")
	end
end

// CLIENT HOOKS

function PIGEON.Hooks.CalcView(player, pos, ang, fov)
	if not player.pigeon then
		return
	end
	ang = player:GetAimVector():Angle()
	local ghost = player:GetNetworkedEntity("pigeon.ghost")
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

function PIGEON.Hooks.Hurt(player, attacker)
	if player.PIGEON then
		player:EmitSound(PIGEON.sounds.pain)
	end
end

function PIGEON.Hooks.KeyPress(player, key)
	local health = player:Health()
	if not player.pigeon then return end

	if player.pigeon.burrowed then
		player:SetMoveType(0)
		return
		
	end
	
	if health < 30 then
		--player:PrintMessage(HUD_PRINTTALK, "You are starting to limp!\nRegain some health by eating.\n")
		GAMEMODE:SetPlayerSpeed(player, 50, 100)
	end
	if health >= 60 then
		if (key == IN_JUMP and player:IsOnGround()) then
			player:SetMoveType(4)
			player:SetVelocity(player:GetForward() * 300 + Vector(0,0,100))
			
		elseif (key == IN_JUMP and player:IsOnGround()) then
			player:SetMoveType(2)
			
		elseif (key == IN_JUMP and !player:IsOnGround()) then
			player:SetVelocity(player:GetForward() * 300 + player:GetAimVector())
			
		elseif player:IsOnGround() then
			player:SetMoveType(2)
			
		elseif (!player:IsOnGround() and key == IN_WALK) then
			player:SetMaxSpeed(250)
			
		else
			player:SetMoveType(0)
		end
	else
		player:SetMoveType(0)
	end
	if health < 60 then
		--player:PrintMessage(HUD_PRINTTALK, "You are too hurt to fly!\nRegain some health by eating.\n")
	end
	if health < 50 then
		--player:PrintMessage(HUD_PRINTTALK, "You are too hurt to hop!\nRegain some health by eating.\n")
		return
	end
	if player:OnGround() and key == IN_SPEED then
		player:SetVelocity(player:GetForward() * 1500 + Vector(0,0,100))
		player:SetMoveType(2)
	end
	
end

function PIGEON.Hooks.SetAnimation(player, animation)
	if player.pigeon then
		return false
	end
end

function PIGEON.Hooks.SetModel(player)
	if player.pigeon then
		return false
	end
end

function PIGEON.Hooks.UpdateAnimation(player)
	if not player.pigeon then
		return
	end
	local rate = 2
	local sequence = "idle01"
	local speed = player:GetVelocity():Length()
	if not player.pigeon.burrowed then
		if player:IsOnGround() then
			player:SetMoveType(2)
			if speed > 0 then
				sequence = "Walk"
				player:SetMaxSpeed( 200 )
				if speed > 200 then
					sequence = "Run"
					rate = 1
				end
			end
		elseif !player:IsOnGround() and player:Health() < 60 then
			player:SetMoveType(2)
			rate = 1
			player:SetMaxSpeed( 100 )
			sequence = "Ragdoll"
		elseif !player:IsOnGround() then
			player:SetMoveType(4)
			rate = 1
			player:SetMaxSpeed( 100 )
			if speed > 0 then
				sequence = "Soar"
				if speed > 400 then
					sequence = "Fly01"
				end
			end
		elseif !player:IsOnGround() and health <= 30 then
			sequence = "Run"
			rate = 0.5
		else
			if player:WaterLevel() > 1 then
				sequence = "Soar"
			else
				sequence = "Idle01"
			end
		end
	elseif player.pigeon.burrowed == PIGEON.BURROWED then
		sequence = "Eat_a"
	end
	local sequenceIndex = player:LookupSequence(sequence)
	if player:GetSequence() != sequenceIndex then
		player:ResetSequence(sequenceIndex)
	end
	sequenceIndex = player.pigeon.ghost:LookupSequence(sequence)
	if player.pigeon.ghost:GetSequence() != sequenceIndex then
		player.pigeon.ghost:Fire("setanimation", sequence, 0)
	end
	player:SetPlaybackRate(rate)
	player.pigeon.ghost:SetPlaybackRate(rate)
end
