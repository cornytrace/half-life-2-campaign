// Include the required lua files
include("sh_config.lua")
include("sh_player.lua")
include("player_class/player_coop.lua")

// General gamemode information
GM.Name = "Half-Life 2 Campaign"
GM.Author = "AMT"
GM.Email = "theis.andrew@gmail.com"
GM.Website = "http://www.andrewtheis.net/"

DeriveGamemode("sandbox")

if !ConVarExists("hl2c_passenger_seats") then
	CreateConVar("hl2c_passenger_seats", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Make HL2C spawn in unstable passenger seats in Vehicles.")
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


// Players shouldn't be mute when being hurt.
function GM:PlayerHurt(pl, attacker, healthRemaining, damageTaken)
	-- If the HL2C Additions is set to 0 OR the game is in singleplayer, just forgot about this function.
	if GetConVarNumber("hl2c_additions") == 0 || game.SinglePlayer() then return end
	-- Make sure the player is valid and alive.
	if (pl:Team() != TEAM_ALIVE) then return end
	if (!pl:Alive()) then return end
	
	local modelNameShared = player_manager.TranslatePlayerModel(pl:GetInfo("cl_playermodel"))
	
	-- MALE --
	-- math.random it so players don't emit the pain sound all the time.
	if ( math.random( 1, 6 ) <= 3 ) then
		if modelNameShared && table.HasValue(PLAYER_MODELS_MALE, string.lower(modelNameShared)) then
			pl:EmitSound(MALE_HURT_SOUNDS[math.random(1, #MALE_HURT_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
		end
	end
	-- MALE --
	
	-- FEMALE --
	-- math.random it so players don't emit the pain sound all the time.
	if ( math.random( 1, 6 ) <= 3 ) then
		if modelNameShared && table.HasValue(PLAYER_MODELS_FEMALE, string.lower(modelNameShared)) then
			pl:EmitSound(FEMALE_HURT_SOUNDS[math.random(1, #FEMALE_HURT_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
		end
	end
	-- FEMALE --
	
	// Do we really want these custom voice lines playing when playermodel restrictions are on? We're gonna have combine rebels if I don't do this.
	if GetConVarNumber("hl2c_playermodel_restrictions") == 0 then
	
		-- COMBINE --
		-- math.random it so players don't emit the pain sound all the time.
		if ( math.random( 1, 6 ) <= 3 ) then
			if modelNameShared && table.HasValue(PLAYER_MODELS_COMBINE, string.lower(modelNameShared)) then
				pl:EmitSound(COMBINE_HURT_SOUNDS[math.random(1, #COMBINE_HURT_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
			end
		end
		-- COMBINE --
		
		-- ALYX --
		-- Even though she isn't on the player_models list, she doesn't need to be mute.
		-- math.random it so players don't emit the pain sound all the time.
		if ( math.random( 1, 6 ) <= 3 ) then
			if modelNameShared == "models/player/alyx.mdl" then
				pl:EmitSound(ALYX_HURT_SOUNDS[math.random(1, #ALYX_HURT_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
			end
		end
		-- ALYX --
		
		-- BARNEY --
		-- Even though barney is a custom playermodel from the list, he shouldn't be mute.
		-- math.random it so players don't emit the pain sound all the time.
		if ( math.random( 1, 6 ) <= 3 ) then
			if modelNameShared == "models/player/barney.mdl" then
				pl:EmitSound(BARNEY_HURT_SOUNDS[math.random(1, #BARNEY_HURT_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
			end
		end
		-- BARNEY --
	end
	
	if GetConVarNumber("hl2c_playermodel_restrictions") == 0 then
		if ( math.random( 1, 6 ) <= 3 ) then
			if modelNameShared != "models/player/alyx.mdl" && modelNameShared != "models/player/barney.mdl" && (modelNameShared && !table.HasValue(PLAYER_MODELS_COMBINE, string.lower(modelNameShared))) && (modelNameShared && !table.HasValue(PLAYER_MODELS_FEMALE, string.lower(modelNameShared))) && (modelNameShared && !table.HasValue(PLAYER_MODELS_MALE, string.lower(modelNameShared))) then
				pl:EmitSound(PLAYER_HURT_SOUNDS[math.random(1, #PLAYER_HURT_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
			end
		end
	else
		if ( math.random( 1, 6 ) <= 3 ) then
			if (modelNameShared && !table.HasValue(PLAYER_MODELS_FEMALE, string.lower(modelNameShared))) && (modelNameShared && !table.HasValue(PLAYER_MODELS_MALE, string.lower(modelNameShared))) then
				pl:EmitSound(PLAYER_HURT_SOUNDS[math.random(1, #PLAYER_HURT_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
			end
		end
	end
end