/*---------------------------------------------------------
   --Initializes the effect. The data is a table of data 
   --which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )
	local pos = data:GetOrigin()
	local NumParticles = 10
	local emitter = ParticleEmitter( pos, true )
	local Col = Color(255,255,100,255)
	for i = 0, NumParticles do
	local offset = Vector(math.random(-20,20),math.random(-20,20),math.random(3,10))
	local particle = emitter:Add( "particle/fire", pos + offset)
		if (particle) then
			particle:SetVelocity( Vector(0,0,25) )
			particle:SetLifeTime( 0 )
			particle:SetDieTime( 3 )
			particle:SetStartAlpha( 230 )
			particle:SetEndAlpha( 0 )
		local Size = math.Rand( 2, 4 )
			particle:SetStartSize( Size )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( math.Rand(-2, 2) )
		local RandDarkness = math.Rand( 0.8, 1.0 )
			particle:SetColor( Col.r*RandDarkness, Col.g*RandDarkness, Col.b*RandDarkness )
			particle:SetAngleVelocity( Angle( math.Rand( -160, 160 ), math.Rand( -160, 160 ), math.Rand( -160, 160 ) ) ) 
			particle:SetLighting( true )
		end
	end	
	emitter:Finish()
end
/*---------------------------------------------------------
   --THINK
---------------------------------------------------------*/
function EFFECT:Think( )
	return false
end
/*---------------------------------------------------------
  -- Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()
end
