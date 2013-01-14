
TOOL.Category		= "Constraints"
TOOL.Name			= "#Rope"
TOOL.Command		= nil
TOOL.ConfigName		= nil


TOOL.ClientConVar[ "forcelimit" ] = "0"
TOOL.ClientConVar[ "addlength" ] = "0"
TOOL.ClientConVar[ "material" ] = "cable/rope"
TOOL.ClientConVar[ "width" ] = "2"
TOOL.ClientConVar[ "rigid" ] = "0"

function TOOL:LeftClick( trace )

	if ( trace.Entity:IsValid() && trace.Entity:IsPlayer() ) then return end
	
	// If there's no physics object then we can't constraint it!
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

	local iNum = self:NumObjects()

	local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if ( iNum > 0 ) then
	
		if ( CLIENT ) then
		
			self:ClearObjects()
			return true
			
		end
		
		// Get client's CVars
		local forcelimit = self:GetClientNumber( "forcelimit" )
		local addlength	 = self:GetClientNumber( "addlength" )
		local material 	 = self:GetClientInfo( "material" )
		local width 	 = self:GetClientNumber( "width" ) 
		local rigid	 	= self:GetClientNumber( "rigid" ) == 1
		
		// Get information we're about to use
		local Ent1,  Ent2  = self:GetEnt(1),	 self:GetEnt(2)
		local Bone1, Bone2 = self:GetBone(1),	 self:GetBone(2)
		local WPos1, WPos2 = self:GetPos(1),	 self:GetPos(2)
		local LPos1, LPos2 = self:GetLocalPos(1),self:GetLocalPos(2)
		local length = ( WPos1 - WPos2):Length()

		local constraint, rope = constraint.Rope( Ent1, Ent2, Bone1, Bone2, LPos1, LPos2, length, addlength, forcelimit, width, material, rigid )

		// Clear the objects so we're ready to go again
		self:ClearObjects()

		// Add The constraint to the players undo table

		undo.Create("Rope")
		undo.AddEntity( constraint )
		undo.AddEntity( rope )
		undo.SetPlayer( self:GetOwner() )
		undo.Finish()

		self:GetOwner():AddCleanup( "ropeconstraints", constraint )		
		self:GetOwner():AddCleanup( "ropeconstraints", rope )
		self:GetOwner():DecResource("Rope",1)

	else
	
		self:SetStage( iNum+1 )
		
	end

	return true
	
end

/* function TOOL:RightClick( trace )

	if ( trace.Entity:IsValid() && trace.Entity:IsPlayer() ) then return end

	local iNum = self:NumObjects()

	local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if ( iNum > 0 ) then
	
		if ( CLIENT ) then
		
			self:ClearObjects()
			return true
			
		end
	
		// Get client's CVars
		local forcelimit = self:GetClientNumber( "forcelimit" )
		local addlength	 = self:GetClientNumber( "addlength" )
		local material 	 = self:GetClientInfo( "material" )
		local width 	 = self:GetClientNumber( "width" )
		local rigid	 = self:GetClientNumber( "rigid" ) == 1
		
		// Get information we're about to use
		local Ent1,  Ent2  = self:GetEnt(1),	 self:GetEnt(2)
		local Bone1, Bone2 = self:GetBone(1),	 self:GetBone(2)
		local WPos1, WPos2 = self:GetPos(1),self:GetPos(2)
		local LPos1, LPos2 = self:GetLocalPos(1),self:GetLocalPos(2)
		local length = ( WPos1 - WPos2 ):Length()

		local constraint, rope = constraint.Rope( Ent1, Ent2, Bone1, Bone2, LPos1, LPos2, length, addlength, forcelimit, width, material, rigid )

		// Clear the objects and set the last object as object 1
		self:ClearObjects()
		iNum = self:NumObjects()
		self:SetObject( iNum + 1, Ent2, trace.HitPos, Phys, Bone2, trace.HitNormal )
		self:SetStage( iNum+1 )

		// Add The constraint to the players undo table

		undo.Create("Rope")
		undo.AddEntity( constraint )
		if rope then undo.AddEntity( rope ) end
		undo.SetPlayer( self:GetOwner() )
		undo.Finish()
		
		self:GetOwner():AddCleanup( "ropeconstraints", constraint )		
		self:GetOwner():AddCleanup( "ropeconstraints", rope )
		
	else
	
		self:SetStage( iNum+1 )
		
	end

	return true
	
end */

function TOOL:Reload( trace )

	if (!trace.Entity:IsValid() || trace.Entity:IsPlayer() ) then return false end
	if ( CLIENT ) then return true end

	local  bool = constraint.RemoveConstraints( trace.Entity, "Rope" )
	return bool

	
end
