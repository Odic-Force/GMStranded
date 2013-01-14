AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when an entity is no longer touching this SENT.
--Return: Nothing
function ENT:EndTouch(entEntity)
end

--Called when the SENT is spawned
--Return: Nothing

function ENT:Initialize()
	self.Entity:SetModel("models/props_wasteland/antlionhill.mdl")

 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
    self.Entity:SetSolid( SOLID_VPHYSICS )

 	self.Entity:SetColor( Color( 255, 255, 255, 255 ) )
	self.Entity:SetNetworkedString( "Owner", "World" )
 	self.MaxAntlions = 5
 	self.Antlions = {}
 	self.Spawning = false

    local phys = self.Entity:GetPhysicsObject()
	
		if phys and phys != NULL then 
			phys:EnableMotion( false )			
		end
    self.Entity.StrandedProtected = true

    timer.Create( "SpawnAntlions", 1, 1, self.SpawnAntlions, self )
 	timer.Create( "CheckSurroundings", 1.1, 1, self.CheckSurroundings, self )
end

function ENT:SpawnAntlions()
    for i = 1, self.MaxAntlions do
        self:SpawnAntlion()
    end
end

function ENT:SpawnAntlion()
    local offset = Vector( math.random( - 500, 500 ), math.random( - 500, 500 ), 100 )
    local retries = 50

    while (!util.IsInWorld(offset) and retries > 0) or offset:Distance(self.Entity:GetPos()) < 200 do
        offset = Vector(math.random(-300,300),math.random(-300,300),100)
        retries = retries - 1
    end

    local trace = {}
    trace.start = self.Entity:GetPos() + offset
    trace.endpos = trace.start + Vector(0,0,-10000)
	trace.mask = MASK_SOLID
    trace.filter = self.Entity 
    local tr = util.TraceLine(trace)
	local ant = ents.Create("npc_antlion")
		ant:SetPos(tr.HitPos + Vector(0,0,5))
		ant:SetNWString("Owner", "World")
        ant:Spawn()
        ant:Fadein(2)
        constraint.NoCollide( self.Entity, ant, 0, 0 );
        table.insert(self.Antlions,ant)
end

function ENT:CheckSurroundings()
    local tbl = {}

    for k,v in pairs(self.Antlions) do
        if !v or v == NULL or !v:IsValid() then
            table.remove(self.Antlions,k)
        else
			local enemy = v:GetEnemy()
			if (enemy and enemy:GetPos():Distance(self.Entity:GetPos()) > 1500) or v:GetPos():Distance(self.Entity:GetPos()) > 1500 then
                v:SetEnemy(nil)
                local pos = self.Entity:GetPos() + Vector(math.random(-500,500),math.random(-500,500),0)
                while pos:Distance(self.Entity:GetPos()) < 200 do
                    pos = self.Entity:GetPos() + Vector(math.random(-500,500),math.random(-500,500),0)
                end
				v:SetLastPosition(pos)
				v:SetSchedule(71)
            end
        end
    end
	if #self.Antlions < self.MaxAntlions and !self.Spawning then
        timer.Create("gms_antlionspawntimers_"..self.Entity:EntIndex(),math.random(20,60),1,self.AddAntlion,self)
        self.Spawning = true
    end
	timer.Create("CheckSurroundings",1.1,1,self.CheckSurroundings,self)
end

function ENT:AddAntlion()
    self:SpawnAntlion()
    self.Spawning = false
end

function ENT:AcceptInput(input, ply)
end

--Called when the entity key values are setup (either through calls to ent:SetKeyValue, or when the map is loaded).
--Return: Nothing
function ENT:KeyValue(k,v)
    Msg("Got keyvalue\n")
    if k == "MaxAntlions" then
        Msg("Recieving keyvalue: "..v.."\n")
        self[k] = tonumber(v)
	end
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
	for k,ant in pairs(self.Antlions) do
		if !(!ant or ant == NULL or !ant:IsValid()) then
		ant:Remove()
		end
	end
	timer.Destroy("CheckSurroundings")
	timer.Destroy("SpawnAntlions")
end
