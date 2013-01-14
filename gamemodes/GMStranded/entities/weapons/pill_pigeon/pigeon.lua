
CROW = {}

CROW.BURROWIN = 1
CROW.BURROWOUT = 2
CROW.BURROWED = 3

CROW.damage = 25
CROW.model = Model("models/crow.mdl")
CROW.sounds = {}
CROW.sounds.attack = Sound("Weapon_Bugbait.Splat")
CROW.sounds.attackHit = Sound("Weapon_Crowbar.Melee_Hit")
CROW.sounds.banghowdy = Sound("Weapon_Bugbait.Splat")
CROW.sounds.burrowIn = Sound("NPC_CROW.BurrowIn")
CROW.sounds.burrowOut = Sound("NPC_CROW.BurrowOut")

CROW.Hooks = {}

function CROW.Enable(player)
	if player.CROW then return end
	if CLIENT then
		player.CROW = true
		return
	end
	GAMEMODE:SetPlayerSpeed(player, 250, 500)
	player:ConCommand("-duck\n")
	CROW.BangHowdy(player)
	player.CROW = {}
	player.CROW.attacking = false
	player.CROW.attackingTimer = 0
	player.CROW.burrowed = nil
	player.CROW.burrowedTimer = 0
	player.CROW.idleTimer = 0
	player.CROW.model = player:GetModel()
	player:SetModel(CROW.model)
	player.CROW.ghost = CROW.Ghost(player)
	player:SetNetworkedEntity("CROW.ghost", player.CROW.ghost)
	if not player.CROWHasPrinted then
		player:PrintMessage(HUD_PRINTTALK, "You're a Crow! AWESOME!\nJump to start flying and then jump again to speed up.\nSprint to hop forward.\nReload to make a cute noise.\n")
		player.CROWHasPrinted = true
	end
	player.CROW.LastEatenTimer = CurTime() + 15
end

function CROW.Disable(player)
	player:ConCommand("-duck\n")
	if CLIENT then
		player.CROW = false
		return
	end
	if not player.CROW then return end
	CROW.BangHowdy(player)
	player.CROW.ghost:Remove()
	player:SetNetworkedEntity("CROW.ghost", nil)
	player:SetModel(player.CROW.model)
	player:SetMoveType(MOVETYPE_WALK)
	player.CROW = nil
end

if CLIENT then
	function CROW.EnableMessage(um)
		local weapon = LocalPlayer():GetActiveWeapon()
		if not weapon or not weapon:IsValid() or not weapon:IsWeapon() or weapon:GetClass() != "pill_pigeon" then
			return
		end
		CROW.Enable(LocalPlayer())
	end
	usermessage.Hook("CROW.enable", CROW.EnableMessage)

	function CROW.DisableMessage(um)
		local weapon = LocalPlayer():GetActiveWeapon()
		if weapon and weapon:IsValid() and weapon:IsWeapon() and weapon:GetClass() == "pill_pigeon" then
			return
		end
		CROW.Disable(LocalPlayer())
	end
	usermessage.Hook("CROW.disable", CROW.DisableMessage)
end

function CROW.AttackDamage(player, tr)
	if tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
		player:EmitSound(CROW.sounds.attackHit)
	end
end

function CROW.AttackThink(player)
	if not player.CROW.attacking then return end
	if not player:OnGround() then
		local t = {}
		t.start = player:GetPos()
		t.endpos = t.start + player:GetForward() * 10
		t.filter = player
		local tr = util.TraceEntity(t, player.CROW.ghost)
		if tr.Hit and tr.HitNonWorld and tr.Entity and tr.Entity:IsValid() then
			player.CROW.attacking = false
			CROW.AttackDamage(player, tr)
		else
			t.endpos = t.start + Vector(0, 0, -20)
			tr = util.TraceEntity(t, player.CROW.ghost)
			if tr.Hit and tr.HitNonWorld and tr.Entity and tr.Entity:IsValid() then
				player.CROW.attacking = false
				CROW.AttackDamage(player, tr)
			end
		end
	else
		player.CROW.attacking = false
	end
	if player.CROW.LastEatenTimer >= CurTime() then
		player.CROW.attackingTimer = CurTime() + 2
	else
		player.CROW.attackingTimer = CurTime() + 8
	end
end

function CROW.BangHowdy(player)
	local ed = EffectData()
	ed:SetOrigin(player:GetPos())
	ed:SetStart(player:GetPos())
	ed:SetScale(1000)
	util.Effect("cball_explode", ed)
	player:EmitSound(CROW.sounds.banghowdy)
end

function CROW.Burrow(player)
	if player.CROW.burrowed != CROW.BURROWED and CurTime() < player.CROW.burrowedTimer then return end
	if not player.CROW.burrowed then
		if player.CROW.attacking or not player:OnGround() then
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
		player:EmitSound(CROW.sounds.burrowIn)
		player:SetMoveType(MOVETYPE_WALK)
		player.CROW.burrowed = CROW.BURROWIN
		player.CROW.burrowedTimer = CurTime() + 0.5
	else
		player:EmitSound(CROW.sounds.burrowOut)
		player:DrawShadow(true)
		player.CROW.ghost:DrawShadow(true)
		player.CROW.burrowed = CROW.BURROWOUT
		player.CROW.burrowedTimer = CurTime() + 0.5
	end
	player.CROW.LastEatenTimer = CurTime() + 15
end


function CROW.BurrowThink(player)
	local health = player:Health()
	if health >= player:GetMaxHealth() then
		player.CROW.burrowed = false
	end
	if not player.CROW.burrowed then return end
	if CurTime() >= player.CROW.burrowedTimer then
		if player.CROW.burrowed == CROW.BURROWIN then
			player:DrawShadow(false)
			player.CROW.ghost:DrawShadow(false)
			player.CROW.burrowed = CROW.BURROWED
		elseif player.CROW.burrowed == CROW.BURROWOUT then
			player:SetMoveType(MOVETYPE_WALK)
			player.CROW.burrowed = false
		elseif player.CROW.burrowed == CROW.BURROWED then
			if health < player:GetMaxHealth() then player:SetHealth(health + 2) end
			player.CROW.burrowedTimer = CurTime() + 1
		end
	end
end

function CROW.Ghost(player)
	local e = ents.Create("prop_dynamic")
	e:SetAngles(player:GetAngles())
	e:SetCollisionGroup(COLLISION_GROUP_NONE)
	e:SetColor(Color(255, 255, 255, 0))
	e:SetMoveType(MOVETYPE_NONE)
	e:SetModel(CROW.model)
	e:SetParent(player)
	e:SetPos(player:GetPos())
	e:SetRenderMode(RENDERMODE_TRANSALPHA)
	e:SetSolid(SOLID_NONE)
	e:Spawn()
	return e
end

function CROW.Idle(player)
	if CurTime() >= player.CROW.idleTimer then
		player.CROW.idleTimer = CurTime() + 2
		player:EmitSound(Sound("npc/crow/idle"..math.random(1,4)..".wav", 100, 100))
	end
end

function CROW.HooksEnable()
	if CLIENT then
		hook.Add("CalcView", "CROW.CalcView", CROW.Hooks.CalcView)
	else
		hook.Add("KeyPress", "CROW.KeyPress", CROW.Hooks.KeyPress)
		hook.Add("PlayerHurt", "CROW.PlayerHurt", CROW.Hooks.Hurt)
		hook.Add("PlayerSetModel", "CROW.PlayerSetModel", CROW.Hooks.SetModel)
		hook.Add("SetPlayerAnimation", "CROW.SetPlayerAnimation", CROW.Hooks.SetAnimation)
		hook.Add("UpdateAnimation", "CROW.UpdateAnimation", CROW.Hooks.UpdateAnimation)
	end
end

function CROW.HooksDisable()
	if CLIENT then
		hook.Remove("CalcView", "CROW.CalcView")
	else
		hook.Remove("KeyPress","CROW.KeyPress")
		hook.Remove("PlayerHurt", "CROW.PlayerHurt")
		hook.Remove("PlayerSetModel", "CROW.PlayerSetModel")
		hook.Remove("SetPlayerAnimation", "CROW.SetPlayerAnimation")
		hook.Remove("UpdateAnimation", "CROW.UpdateAnimation")
	end
end

function CROW.Hooks.CalcView(player, pos, ang, fov)
	if not player.CROW then
		return
	end
	ang = player:GetAimVector():Angle()
	local ghost = player:GetNetworkedEntity("CROW.ghost")
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

function CROW.Hooks.Hurt(player, attacker)
	if player.CROW then
		player:EmitSound(Sound("npc/crow/pain"..math.random(1,2)..".wav", 100, 100))
	end
end

function CROW.Hooks.KeyPress(player, key)
	local health = player:Health()
	if not player.CROW then return end

	if player.CROW.burrowed then
		player:SetMoveType(0)
		return
		
	end
	
	if health < 30 then
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
	end
	if health < 50 then
		return
	end
	if player:OnGround() and key == IN_SPEED then
		player:SetVelocity(player:GetForward() * 1500 + Vector(0,0,100))
		player:SetMoveType(2)
	end
	
end

function CROW.Hooks.SetAnimation(player, animation)
	if player.CROW then
		return false
	end
end

function CROW.Hooks.SetModel(player)
	if player.CROW then
		return false
	end
end

function CROW.Hooks.UpdateAnimation(player)
	if not player.CROW then
		return
	end
	local rate = 2
	local sequence = "idle01"
	local speed = player:GetVelocity():Length()
	if not player.CROW.burrowed then
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
	elseif player.CROW.burrowed == CROW.BURROWED then
		sequence = "Eat_a"
	end
	local sequenceIndex = player:LookupSequence(sequence)
	if player:GetSequence() != sequenceIndex then
		player:ResetSequence(sequenceIndex)
	end
	sequenceIndex = player.CROW.ghost:LookupSequence(sequence)
	if player.CROW.ghost:GetSequence() != sequenceIndex then
		player.CROW.ghost:Fire("setanimation", sequence, 0)
	end
	player:SetPlaybackRate(rate)
	player.CROW.ghost:SetPlaybackRate(rate)
end
