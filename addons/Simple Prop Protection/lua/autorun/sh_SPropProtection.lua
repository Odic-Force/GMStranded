------------------------------------
--	Simple Prop Protection
--	By Spacetech
------------------------------------

AddCSLuaFile("autorun/sh_SPropProtection.lua")
AddCSLuaFile("SPropProtection/cl_Init.lua")
AddCSLuaFile("SPropProtection/sh_CPPI.lua")

SPropProtection = {}
SPropProtection.Version = 1.5

CPPI = {}
CPPI_NOTIMPLEMENTED = 26
CPPI_DEFER = 16

include("SPropProtection/sh_CPPI.lua")

if(SERVER) then
	include("SPropProtection/sv_Init.lua")
else
	include("SPropProtection/cl_Init.lua")
end

Msg("==========================================================\n")
Msg("Simple Prop Protection Version "..SPropProtection.Version.." by Spacetech has loaded\n")
Msg("==========================================================\n")
