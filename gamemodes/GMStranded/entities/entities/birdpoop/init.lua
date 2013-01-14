
 AddCSLuaFile( "cl_init.lua" )
 AddCSLuaFile( "shared.lua" )
 include( 'shared.lua' ) 

//This is the Spawn function that creates the SENT when you select it from the spawn menu.

function ENT:SpawnFunction( ply, tr )
   
 	if ( !tr.Hit ) then return end 
 	 
 	local SpawnPos = tr.HitPos + tr.HitNormal * 1 
 	 
 	local ent = ents.Create( "birdpoop" )
		ent:SetPos( SpawnPos )
 	ent:Spawn()
 	ent:Activate() 
 	 
	return ent 
 	 
end
   

//Here is Initialize. This is, you guessed it, what initializes the SENT!

 /*--------------------------------------------------------- 
    Name: Initialize 
 ---------------------------------------------------------*/ 
function ENT:Initialize()

//This sets the SENT's model. It is important to put this BEFORE the physics movetype stuff which is done next!
	
 	self.Entity:SetModel( "models/spitball_small.mdl" ) 

//These next three lines set up the collision data which is VPhysics.

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
	self.Entity:SetHealth(1)

	self.Entity:SetColor(Color(255,255,255,255))
	self.Entity:SetMaterial("models/shiny")
	
	//This next part tells the SENT's physics to wake.

 	local phys = self.Entity:GetPhysicsObject()
 	if (phys:IsValid()) then 
		phys:Wake() 
 	end
	
	self.ShouldRemove = 0

end 
 
function ENT:Remove()
	self:SetNoDraw(true); -- Stop drawing us!
	timer.Simple(0.1,function() self:SetCollisionGroup(self,COLLISION_GROUP_NONE) end); -- "nocollide" so it wont result into strange behaviours. Must be in a timer or that messages comes too
	timer.Simple(2, function() self.Remove(self) end);
	self.Entity:Remove()
end

function ENT:PhysicsCollide( data, phys )
	if ( !data.HitEntity:IsWorld() ) then return end
	if ( data.HitEntity:IsWorld() && self.Entity:IsValid() ) then
		util.Decal("BirdPoop", data.HitPos + data.HitNormal , data.HitPos - data.HitNormal)
		self.ShouldRemove = 1
	end
end
   
 /*--------------------------------------------------------- 
    Name: OnTakeDamage 
	Desc: Called when the entity takes damage
 ---------------------------------------------------------*/ 
function ENT:OnTakeDamage( dmginfo )

 	// Make the SENT react physically when shot/getting blown 
 	self.Entity:TakePhysicsDamage( dmginfo )

 end
 
/*--------------------------------------------------------- 
    Name: Touch 
	Desc: Called when the entity is touched
 ---------------------------------------------------------*/ 

function ENT:Touch( hitEnt ) 
	if (!hitEnt:IsWorld()) then
		if (hitEntity == self:GetOwner()) then return end
		hitEnt:SetHealth(hitEnt:Health() - 1)
	end
end

/*--------------------------------------------------------- 
    Name: Think
	Desc: Called every frame
 ---------------------------------------------------------*/ 
function ENT:Think()
	if self.ShouldRemove == 1 then
		self.Entity:Remove()
	end
end
