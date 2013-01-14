AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
local GM = GAMEMODE

--Called when an entity is no longer touching this SENT.
--Return: Nothing
function ENT:EndTouch(entEntity)
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	self.Entity:SetModel("models/weapons/w_bugbait.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_VPHYSICS )

 	self.Entity:SetColor(Color(0,255,0,255))
end

function ENT:Setup(strType,time,ply)
	self.Entity.ResType = strType
	self.Entity.Player = ply
	if strType != "tree" then
		ply:SetNWInt("plants", ply:GetNWInt("plants")+1)
	end
	self.Entity:SetOwner( ply )
	timer.Create("GMS_SeedTimers_"..self.Entity:EntIndex(),time,1,self.Grow,self)
end

function ENT:Grow()
	local strType = self.Entity.ResType
	local ply = self.Entity.Player
	local pos = self.Entity:GetPos()
	self.Entity.Fade = true
	self.Entity:Fadeout()

	if strType == "tree" then
		GM.MakeTree(pos)

	elseif strType == "melon" then
		local num = 1

		if ply:HasUnlock("Adept_Farmer") then
			num = num + math.random(0,1)
		end

		if ply:HasUnlock("Expert_Farmer") then
			num = num + math.random(0,2)
		end

		GM.MakeMelon(pos,num,ply)

	elseif strType == "banana" then
		local num = 1

		if ply:HasUnlock("Adept_Farmer") then
			num = num + math.random(0,1)
		end

		if ply:HasUnlock("Expert_Farmer") then
			num = num + math.random(0,2)
		end

		GM.MakeBanana(pos,num,ply)

	elseif strType == "orange" then
		local num = 1

		if ply:HasUnlock("Adept_Farmer") then
			num = num + math.random(0,1)
		end

		if ply:HasUnlock("Expert_Farmer") then
			num = num + math.random(0,2)
		end

		GM.MakeOrange(pos,num,ply)


	elseif strType == "grain" then
		GM.MakeGrain(pos,ply)
	elseif strType == "berry" then
		GM.MakeBush(pos,ply)
	end
end

function GM.MakeTree(pos)
	local ent = ents.Create("prop_physics")
	ent:SetAngles(Angle(0,math.random(1,360),0))
	ent:SetModel(GMS.TreeModels[math.random(1,#GMS.TreeModels)])
	ent:SetPos(pos)
	ent:Spawn()
	ent:SetNetworkedString("Owner", "World")
	ent:Fadein()
	ent:GetPhysicsObject():EnableMotion(false)
	ent.StrandedProtected = true
end

function GM.MakeMelon(pos,num,owner)
	local plant = ents.Create("prop_physics")
	plant:SetAngles(Angle(0,math.random(1,360),0))
	plant:SetModel("models/props/CS_militia/fern01.mdl")
	plant:SetPos(pos + Vector(0, 0, 13))
	plant:SetNWEntity('plantowner', owner)
	plant:Spawn()
	plant:Fadein()
	plant:RiseFromGround(1,50)
	plant.Children = 0
	plant.StrandedProtected = true
	SPropProtection.PlayerMakePropOwner(owner, plant)

	for i = 1,num do
		local ent = ents.Create("prop_physics")
		ent:SetAngles(Angle(0,math.random(1,360),0))
		ent:SetModel("models/props_junk/watermelon01.mdl")
		ent:SetPos(pos + Vector(math.random(-25,25),math.random(-25,25),math.random(5,7)))
		ent:Spawn()

		local phys = ent:GetPhysicsObject()
		if phys then 
			phys:EnableMotion(false) 
		end
		ent.StrandedProtected = true
		ent:Fadein()
		ent.PlantParent = plant
		plant.Children = plant.Children + 1
		
		ent:SetHealth(99999)
		SPropProtection.PlayerMakePropOwner(owner, ent)
	end
end

function GM.MakeBanana(pos,num,owner)
	local plant = ents.Create("prop_physics")
	plant:SetAngles(Angle(0,math.random(1,360),0))
	plant:SetModel("models/props/de_dust/du_palm_tree01_skybx.mdl")
	plant:SetPos(pos + Vector(0, 0, -3))
	plant:SetNWEntity('plantowner', owner)
	plant:Spawn()
	plant:Fadein()
	plant:RiseFromGround(1,50)
	plant.Children = 0
	plant.StrandedProtected = true
	SPropProtection.PlayerMakePropOwner(owner, plant)

	for i = 1,num do
		local ent = ents.Create("prop_physics")
		ent:SetAngles(Angle(0,math.random(1,360),0))
		ent:SetModel("models/props/cs_italy/bananna_bunch.mdl")
		ent:SetPos(pos + Vector(math.random(-7,7),math.random(-7,7),math.random(48,55)))
		ent:Spawn()

		local phys = ent:GetPhysicsObject()
		if phys then 
			phys:EnableMotion(false) 
		end
		ent.StrandedProtected = true
		ent:Fadein()
		ent.PlantParent = plant
		plant.Children = plant.Children + 1

		ent:SetHealth(99999)
		SPropProtection.PlayerMakePropOwner(owner, ent)
	end
end

function GM.MakeOrange(pos,num,owner)
	local plant = ents.Create("prop_physics")
	plant:SetAngles(Angle(0,math.random(1,360),0))
	plant:SetModel("models/props/cs_office/plant01_p1.mdl")
	plant:SetPos(pos + Vector(0, 0, -12))
	plant:SetNWEntity('plantowner', owner)
	plant:Spawn()
	plant:SetCollisionGroup(0)
	plant:SetSolid( SOLID_NONE )
	plant:GetPhysicsObject():Sleep()
	plant:Fadein()
	plant:RiseFromGround(1,50)
	plant.Children = 0
	plant.StrandedProtected = true
	SPropProtection.PlayerMakePropOwner(owner, plant)

	for i = 1,num do
		local ent = ents.Create("prop_physics")
		ent:SetAngles(Angle(0,math.random(1,360),0))
		ent:SetModel("models/props/cs_italy/orange.mdl")
		ent:SetPos(pos + Vector(math.random(-5,5),math.random(-5,5),math.random(13,30)))
		ent:Spawn()

		local phys = ent:GetPhysicsObject()
		if phys then 
			phys:EnableMotion(false) 
		end
		ent.StrandedProtected = true
		ent:Fadein()
		ent.PlantParent = plant
		plant.Children = plant.Children + 1

		ent:SetHealth(99999)
		SPropProtection.PlayerMakePropOwner(owner, ent)
	end
end

function GM.MakeGrain(pos,owner)
		local plant = ents.Create("prop_physics")
		plant:SetAngles(Angle(0,math.random(1,360),0))
		plant:SetModel("models/props_foliage/cattails.mdl")
		plant:SetPos(pos + Vector(math.random(-10,10),math.random(-10,10),0))
		plant:SetNWEntity('plantowner', owner)
		plant:Spawn()
		plant.StrandedProtected = true
		plant:Fadein()
		plant:RiseFromGround(1,50)		
		SPropProtection.PlayerMakePropOwner(owner, plant)
end

function GM.MakeBush(pos,owner)
		local plant = ents.Create("prop_physics")
		plant:SetPos(pos + Vector(math.random(-10,10),math.random(-10,10),20))
		plant:SetAngles(Angle(0,math.random(1,360),0))
		plant:SetModel("models/props/pi_shrub.mdl")
		plant:SetNWEntity('plantowner', owner)
		plant:Spawn()
		plant.StrandedProtected = true
		plant:Fadein()
		plant:RiseFromGround(1,50)
		SPropProtection.PlayerMakePropOwner(owner, plant)
end


function ENT:AcceptInput(input, ply)
end

--Called when the entity key values are setup (either through calls to ent:SetKeyValue, or when the map is loaded).
--Return: Nothing
function ENT:KeyValue(k,v)
end

--Called when a save-game is loaded.
--Return: Nothing
function ENT:OnRestore()
end

--Called when something hurts the entity.
--Return: Nothing
function ENT:OnTakeDamage(dmiDamage)
end

--Controls/simulates the physics on the entity.
--Return: (SimulateConst) sim, (Vector) linear_force and (Vector) angular_force
function ENT:PhysicsSimulate(pobPhysics,numDeltaTime)
end

--Called when an entity starts touching this SENT.
--Return: Nothing
function ENT:StartTouch(entEntity)
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end

--Called when the SENT is removed
function ENT:OnRemove( )
	if self.Entity.Fade != true then
		if strType != "tree" then
			self.Entity:GetOwner():SetNWInt("plants", self.Entity:GetOwner():GetNWInt("plants")-1)
		end	
		timer.Destroy("GMS_SeedTimers_"..self.Entity:EntIndex())
	end
end

