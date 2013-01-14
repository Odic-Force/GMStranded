
TOOL.Category		= "Construction"
TOOL.Name			= "#Ignite"
TOOL.Command		= nil
TOOL.ConfigName		= nil


TOOL.ClientConVar["length"] = 15
/*
function TOOL:LeftClick( trace )

	if (!trace.Entity) then return false end
	if (!trace.Entity:IsValid() ) then return false end
	if (trace.Entity:IsPlayer()) then return false end
	if (trace.Entity:IsWorld()) then return false end
	
	if ( CLIENT ) then return true end
	
	local _length	= math.Max( self:GetClientNumber( "length" ), 2 )
	
	trace.Entity:Extinguish()
	if GetConVarNumber("gms_SpreadFire") == 1 then
		trace.Entity:Ignite( _length, (trace.Entity:OBBMins()-trace.Entity:OBBMaxs()):Length()*0.50+10 )
	else
		trace.Entity:Ignite( _length, 0 )
	end

	return true
	
end
*/
function TOOL:RightClick( trace )

	if (!trace.Entity) then return false end
	if (!trace.Entity:IsValid() ) then return false end
	if (trace.Entity:IsPlayer()) then return false end
	if (trace.Entity:IsWorld()) then return false end
	
	// Client can bail out now
	if ( CLIENT ) then return true end

	trace.Entity:Extinguish()
	
	return true
	
end
