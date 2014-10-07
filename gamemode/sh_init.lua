// Include the required lua files
include("sh_config.lua")
include("sh_player.lua")
include("player_class/player_coop.lua")

// General gamemode information
GM.Name = "Half-Life 2 Campaign"
GM.Author = "AMT"
GM.Email = "theis.andrew@gmail.com"
GM.Website = "http://www.andrewtheis.net/"

if !ConVarExists("hl2c_passenger_seats") then
	CreateConVar("hl2c_passenger_seats", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Make HL2C spawn in unstable passenger seats in Vehicles.")
end

if !ConVarExists("hl2c_passenger_seats_weapons") then
	CreateConVar("hl2c_passenger_seats_weapons", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Allow passengers to use weapons in the passenger seat?")
end

concommand.Add("hl2c_respawn_dead_players", function(pl) if pl:IsAdmin() && !game.SinglePlayer() then GAMEMODE:HL2CForceRespawn() elseif !pl:IsAdmin() then pl:PrintMessage(HUD_PRINTTALK, "Only admins can use this, sorry.") elseif game.SinglePlayer() then pl:PrintMessage(HUD_PRINTTALK, "You cannot use this command in Singleplayer.") end end)

// Constants
FRIENDLY_NPCS = {
	"npc_citizen"
}
GODLIKE_NPCS = {
	"npc_alyx",
	"npc_barney",
	"npc_breen",
	"npc_dog",
	"npc_eli",
	"npc_fisherman",
	"npc_gman",
	"npc_kleiner",
	"npc_magnusson",
	"npc_monk",
	"npc_mossman",
	"npc_vortigaunt"
}


// Create the teams that we are going to use throughout the game
function GM:CreateTeams()
	TEAM_ALIVE = 1
	team.SetUp(TEAM_ALIVE, "Alive", Color(81, 124, 199, 255))
	
	TEAM_COMPLETED_MAP = 2
	team.SetUp(TEAM_COMPLETED_MAP, "Completed Map", Color(81, 124, 199, 255))
	
	TEAM_DEAD = 3
	team.SetUp(TEAM_DEAD, "Dead", Color(81, 124, 199, 255))
	
	TEAM_BOT_SPECTATOR = 4
	team.SetUp(TEAM_BOT_SPECTATOR, "BOT", Color(81, 124, 199, 255))
end

// Called immediately after starting the gamemode  
function GM:Initialize()
	if string.find(game.GetMap(), "ep1_") then
		game.AddParticles("particles/ep1_fx.pcf")
	end
	
	if string.find(game.GetMap(), "ep2_") then
		game.AddParticles( "particles/antlion_gib_01.pcf" )
		game.AddParticles( "particles/antlion_gib_02.pcf" )
		game.AddParticles( "particles/advisor.pcf" )
		game.AddParticles( "particles/Advisor_FX.pcf" )
		game.AddParticles( "particles/aurora.pcf" )
		game.AddParticles( "particles/aurora_sphere2.pcf" )
		game.AddParticles( "particles/antlion_worker.pcf" )
		game.AddParticles( "particles/buildingdamage.pcf" )
		game.AddParticles( "particles/blob.pcf" )
		game.AddParticles( "particles/bonfire.pcf" )
		game.AddParticles( "particles/building_explosion.pcf" )
		game.AddParticles( "particles/default.pcf" )
		game.AddParticles( "particles/demo_paticle_light.pcf" )
		game.AddParticles( "particles/devtest.pcf" )
		game.AddParticles( "particles/door_explosion.pcf" )
		game.AddParticles( "particles/dust_bombdrop.pcf" )
		game.AddParticles( "particles/dust_rumble.pcf" )
		game.AddParticles( "particles/explosion.pcf" )
		game.AddParticles( "particles/electrical_fx.pcf" )
		game.AddParticles( "particles/fire_ring.pcf" )
		game.AddParticles( "particles/fireflow.pcf" )
		game.AddParticles( "particles/flamethrowertest.pcf" )
		game.AddParticles( "particles/grenade_fx.pcf" )
		game.AddParticles( "particles/grub_blood.pcf" )
		game.AddParticles( "particles/hunter_intro.pcf" )
		game.AddParticles( "particles/hunter_projectile.pcf" )
		game.AddParticles( "particles/hunter_shield_impact.pcf" )
		game.AddParticles( "particles/hunter_flechette.pcf" )
		game.AddParticles( "particles/choreo_dog_v_strider.pcf" )
		game.AddParticles( "particles/choreo_launch.pcf" )
		game.AddParticles( "particles/choreo_gman.pcf" )
		game.AddParticles( "particles/choreo_extract.pcf" )
		game.AddParticles( "particles/largefire.pcf" )
		game.AddParticles( "particles/light_rays.pcf" )
		game.AddParticles( "particles/magnusson_burner.pcf" )
		game.AddParticles( "particles/rain.pcf" )
		game.AddParticles( "particles/sand.pcf" )
		game.AddParticles( "particles/skybox_smoke.pcf" )
		game.AddParticles( "particles/stalactite.pcf" )
		game.AddParticles( "particles/striderbuster.pcf" )
		game.AddParticles( "particles/steampuff.pcf" )
		game.AddParticles( "particles/test_grnalpha.pcf" )
		game.AddParticles( "particles/test_noise.pcf" )
		game.AddParticles( "particles/vehicle.pcf" )
		game.AddParticles( "particles/vistasmokev1.pcf" )
		game.AddParticles( "particles/Vortigaunt_FX.pcf" )
		game.AddParticles( "particles/warpshield.pcf" )
		game.AddParticles( "particles/water_leaks.pcf" )
		game.AddParticles( "particles/waterfall.pcf" )
		game.AddParticles( "particles/waterdrips.pcf" )
		game.AddParticles( "particles/weapon_fx.pcf" )
	end
end

// Called when map entities spawn
function GM:EntityKeyValue(ent, key, value)
	if ent:GetClass() == "trigger_changelevel" && key == "map" && SERVER then
		ent.map = key
	end
end

// Called when a gravity gun is attempting to punt something
function GM:GravGunPunt(pl, ent) 
 	if ent && ent:IsVehicle() && ent != pl.vehicle && ent.creator then
		return false
	end
	
	return true
end 


// Called when a physgun tries to pick something up
function GM:PhysgunPickup(pl, ent)
	if string.find(ent:GetClass(), "trigger_") || ent:GetClass() == "player" || ent:GetClass() == "prop_vehicle_prisoner_pod" then
		return false
	end
	
	return true
end


// Called when a player entered a vehicle
function GM:PlayerEnteredVehicle(pl, vehicle, role)
	if pl.vehicle != vehicle then
		pl.vehicle = vehicle
		
		if vehicle.creator then
			vehicle.creator.vehicle = nil
		end
		
		vehicle.creator = pl
	end
end


// Players should never collide with each other or NPC's
function GM:ShouldCollide(entA, entB)
	if entA && entB && ((entA:IsPlayer() && (entB:IsPlayer() || table.HasValue(GODLIKE_NPCS, entB:GetClass()) || table.HasValue(FRIENDLY_NPCS, entB:GetClass()))) || (entB:IsPlayer() && (entA:IsPlayer() || table.HasValue(GODLIKE_NPCS, entA:GetClass()) || table.HasValue(FRIENDLY_NPCS, entA:GetClass())))) then
		return false
	else
		return true
	end
end


// Called when a player is being attacked
function GM:PlayerShouldTakeDamage(pl, attacker)
	if pl:Team() != TEAM_ALIVE || !pl.vulnerable || (attacker:IsPlayer() && attacker != pl) || (attacker:IsVehicle() && attacker:GetDriver():IsPlayer()) || table.HasValue(GODLIKE_NPCS, attacker:GetClass()) || table.HasValue(FRIENDLY_NPCS, attacker:GetClass()) then
		return false
	else
		return true
	end
end