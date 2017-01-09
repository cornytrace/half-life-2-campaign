// Send the required resources to the client
resource.AddFile("materials/hl2c/hl2c_nav_marker.vmt")
resource.AddFile("materials/hl2c/hl2c_nav_marker.vtf")
resource.AddFile("materials/hl2c/hl2c_nav_pointer.vmt")
resource.AddFile("materials/hl2c/hl2c_nav_pointer.vtf")


// Send the required lua files to the client
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("cl_scoreboard_playerlist.lua")
AddCSLuaFile("cl_scoreboard_playerrow.lua")
AddCSLuaFile( "cl_spawnmenu.lua" )
AddCSLuaFile("cl_targetid.lua")
AddCSLuaFile("sh_config.lua")
AddCSLuaFile("sh_init.lua")
AddCSLuaFile("sh_player.lua")
AddCSLuaFile("player_class/player_coop.lua")


// Include the required lua files
include("sh_init.lua")
include("spawnmenu/init.lua")

// Include the configuration for this map
if file.Exists("hl2c_custom/maps/"..game.GetMap()..".lua", "LUA") then
	include("hl2c_custom/maps/"..game.GetMap()..".lua")
else
	include("maps/"..game.GetMap()..".lua")
end

// Create console variables to make these config vars easier to access
if !ConVarExists("hl2c_admin_physgun") then
	CreateConVar("hl2c_admin_physgun", ADMIN_NOCLIP, FCVAR_NOTIFY)
	CreateConVar("hl2c_admin_noclip", ADMIN_PHYSGUN, FCVAR_NOTIFY)
end

// Let's see if we can turn the playermodel restrictions off
if !ConVarExists("hl2c_playermodel_restrictions") then
	CreateConVar("hl2c_playermodel_restrictions", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Sets whether you want to use custom playermodels.")
end

// Do we want HEV hands?
if !ConVarExists("hl2c_hev_hands") then
	CreateConVar("hl2c_hev_hands", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Choose between HEV hands or normal hands.")
end

// Debug: Show who is an admin
if !ConVarExists("hl2c_betatester_trails") then
	CreateConVar("hl2c_betatester_trails", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Toggle whether beta testers have trails on their feet.")
end

// Toggle whether bots should go on their own team(Spectator)
if !ConVarExists("hl2c_bot_spectate") then
	CreateConVar("hl2c_bot_spectate", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Bots are useless, lets get rid of them.")
end

// ONLY WORKS IN MULTIPLAYER. Allow weapon_stunsticks?
if !ConVarExists("hl2c_allow_stunstick") then
	CreateConVar("hl2c_allow_stunstick", "0", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Only usable in Multiplayer. Toggle whether players can pick up Stunsticks.")
end

// ONLY WORKS IN MULTIPLAYER. Should players drop their current weapon on death?
if !ConVarExists("hl2c_drop_weapon_on_death") then
	CreateConVar("hl2c_drop_weapon_on_death", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Only usable in Multiplayer. Toggle whether players drop weapons on death.")
end

// ONLY WORKS IN MULTIPLAYER. Can players respawn?
if !ConVarExists("hl2c_allow_respawn") then
	CreateConVar("hl2c_allow_respawn", "0", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Only usable in Multiplayer. Do players get to respawn instead of being dead forever?")
end

// ONLY WORKS IN MULTIPLAYER. Make the gamemode add in additions to the gameplay?
if !ConVarExists("hl2c_additions") then
	CreateConVar("hl2c_additions", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Only usable in Multiplayer. Add in additions to the gameplay?")
end

// ONLY WORKS IN MULTIPLAYER. Should we use the old NextMap timer?
if !ConVarExists("hl2c_old_nextmap_timer") then
	CreateConVar("hl2c_old_nextmap_timer", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Only usable in Multiplayer. Use old NextMap timer?")
end

// Try bring back the classic HL2C 1.2.6 features.
if !ConVarExists("hl2c_classic") then
	CreateConVar("hl2c_classic", "0", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Override to make the gamemode act closely to HL2C 1.2.6.")
end

// Shop is optional
if !ConVarExists("hl2c_shop_allowed") then
	CreateConVar("hl2c_shop_allowed", "0", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Allow the Shop?")
end

// Spawnmenu
if !ConVarExists("hl2c_spawnmenu") then
	CreateConVar("hl2c_spawnmenu", "0", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "DOES NOTHING RIGHT NOW.")
end

// Used temporary until spawn menu becomes fully avaliable.
if !ConVarExists("hl2c_custom_weapon_1") then
	CreateConVar("hl2c_custom_weapon_1", "", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Temporary feature.")
	CreateConVar("hl2c_custom_weapon_2", "", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Temporary feature.")
	CreateConVar("hl2c_custom_weapon_3", "", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Temporary feature.")
	CreateConVar("hl2c_custom_weapon_4", "", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Temporary feature.")
	CreateConVar("hl2c_custom_weapon_5", "", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Temporary feature.")
end

// Ammo limiting.
if !ConVarExists("hl2c_ammo_limits") then
	CreateConVar("hl2c_ammo_limits", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Limit your ammo?")
end

// These never appeared when they were merged with hl2c_ammo_limits so just place them seperately.
if !ConVarExists("hl2c_ammo_pistol_max") then
	CreateConVar("hl2c_ammo_pistol_max", "150", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Max amount of ammo for pistol.")
	CreateConVar("hl2c_ammo_357_max", "12", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Max amount of ammo for 357.")
	CreateConVar("hl2c_ammo_smg1_max", "225", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Max amount of ammo for smg1.")
	CreateConVar("hl2c_ammo_smg1_grenade_max", "3", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Max amount of ammo for smg1 alt-fire.")
	CreateConVar("hl2c_ammo_ar2_max", "60", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Max amount of ammo for ar2.")
	CreateConVar("hl2c_ammo_ar2altfire_max", "3", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Max amount of ammo for ar2 alt-fire.")
	CreateConVar("hl2c_ammo_buckshot_max", "30", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Max amount of ammo for shotgun.")
	CreateConVar("hl2c_ammo_xbowbolt_max", "10", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Max amount of ammo for crossbow.")
	CreateConVar("hl2c_ammo_rpg_round_max", "3", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Max amount of ammo for rpg.")
	CreateConVar("hl2c_ammo_slam_max", "5", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Max amount of ammo for slam.")
end

// Usermessages vs. Net Library
if !ConVarExists("hl2c_use_old_umsg") then
	CreateConVar("hl2c_use_old_umsg", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Use UserMessages instead of NET LIBRARY.")
end

// Small useless cvar to show if it's a holiday
if !ConVarExists("hl2c_holiday") then
	CreateConVar("hl2c_holiday", "0", { FCVAR_GAMEDLL }, "Show if holiday features will be used.")
end

// Precache all the player models ahead of time
for _, playerModel in pairs(PLAYER_MODELS) do
	util.PrecacheModel(playerModel)
end


// NET LIBRARY - Add Network Strings
util.AddNetworkString("PlayerJoinMessage")
util.AddNetworkString("SetCheckpointPosition")
util.AddNetworkString("PlayerInitialSpawn")
util.AddNetworkString("ShowHelp")
util.AddNetworkString("ShowTeam")
util.AddNetworkString("UpdateEnergy")
util.AddNetworkString("DrowningEffect")
util.AddNetworkString("ClassicMode")
util.AddNetworkString("AbilityBought")
util.AddNetworkString("PlayerCalledVoiceLine")
util.AddNetworkString("SpawnMenuEnabled")
util.AddNetworkString("PlayerCalledWarning")
util.AddNetworkString("PlayerWarningPositions")
util.AddNetworkString("PlayerWarningPositionsDisable")


// Some hooks
gameevent.Listen("player_connect")
hook.Add("player_connect", "PlayerConnectedAnnouncement", function(data)
	for _, pl in pairs(player.GetAll()) do
		if GetConVarNumber("hl2c_use_old_umsg") >= 1 then
			umsg.Start("PlayerJoinMessage", pl)
			umsg.String(data.name)
			umsg.End()
		elseif GetConVarNumber("hl2c_use_old_umsg") == 0 then
			net.Start("PlayerJoinMessage")
				net.WriteString(data.name)
			net.Send(pl)
		end
	end
end)


// This is called when the player calls a question line
net.Receive("PlayerCalledVoiceLine", function(len, pl)
	PlayerVoiceLine(pl)
end)

// This is called when the player calls a warning
net.Receive("PlayerCalledWarning", function(len, pl)
	PlayerWarning(pl)
end)


// Called when the player attempts to suicide
function GM:CanPlayerSuicide(pl)
	if pl:Team() == TEAM_COMPLETED_MAP then
		pl:ChatPrint("You cannot suicide once you've completed the map.")
		return false
	elseif pl:Team() == TEAM_DEAD then
		pl:ChatPrint("This may come as a suprise, but you are already dead.")
		return false
	end
	
	if GetConVarNumber("hl2c_classic") == 0 then
		if PLAYER_IS_CITIZEN == true then
			pl:ChatPrint("You can only suicide when the HEV Suit is on.")
			return false
		end
	end
	
	return true
end 


// Creates a spawn point
function GM:CreateSpawnPoint(pos, yaw)
	local ips = ents.Create("info_player_start")
	ips:SetPos(pos)
	ips:SetAngles(Angle(0, yaw, 0))
	ips:Spawn()
end


// Creates a trigger delaymapload
function GM:CreateTDML(min, max)
	tdmlPos = max - ((max - min) / 2)
	
	local tdml = ents.Create("trigger_delaymapload")
	tdml:SetPos(tdmlPos)
	tdml.min = min
	tdml.max = max
	tdml:Spawn()
end


// Creates a brush playerfreeze
function GM:CreatePF(min, max)
	pfPos = max - ((max - min) / 2)
	
	local pf = ents.Create("brush_playerfreeze")
	pf:SetPos(pfPos)
	pf.min = min
	pf.max = max
	pf:Spawn()
end


// Creates a brush playerclip
// BROUGHT BACK FROM THE DEAD
function GM:CreatePC(min, max)
	pcPos = max - ((max - min) / 2)
	
	local pc = ents.Create("brush_playerclip")
	pc:SetPos(pcPos)
	pc.min = min
	pc.max = max
	pc:Spawn()
end


// Creates a trigger vehiclespawn
function GM:CreateTVS(min, max)
	tvsPos = max - ((max - min) / 2)
	
	local tvs = ents.Create("trigger_vehiclespawn")
	tvs:SetPos(tvsPos)
	tvs.min = min
	tvs.max = max
	tvs:Spawn()
end


// Called when the player dies
function GM:DoPlayerDeath(pl, attacker, dmgInfo)
	pl.deathPos = pl:EyePos()
	pl.deathPosBeta = pl:GetPos()
	
	-- Stop abilities
	if pl.abilityInvis then
		StopInvisibility(pl)
	end

	if pl.abilityInvinc then
		StopInvincibility(pl)
	end

	if pl.abilityScaler then
		StopScaler(pl)
	end
	
	if pl.abilitySuitCharge then
		StopSuitRecharge(pl)
	end
	
	-- A timer to when every player responds to someone dying.
	if GetConVarNumber("hl2c_additions") >= 1 && !game.SinglePlayer() then
		timer.Simple(math.random(1, 3), function() HeIsDead() end)
	end
	
	if HL1_CAMPAIGN == false then
		if GetConVarNumber("hl2c_allow_respawn") == 0 || game.SinglePlayer() then
			if !HL2MP_IS_COOP_MAP then
				// Add to deadPlayers table to prevent respawning on re-connect
				if !table.HasValue(deadPlayers, pl:UniqueID()) then
					table.insert(deadPlayers, pl:UniqueID())
				end
			end
		end
	end
	
	pl:RemoveVehicle()
	pl:Flashlight(false)
	pl:CreateRagdoll()
	if HL1_CAMPAIGN == false then
		if GetConVarNumber("hl2c_allow_respawn") == 0 || game.SinglePlayer() then
			if !HL2MP_IS_COOP_MAP then
				pl:SetTeam(TEAM_DEAD)
			end
		end
	end
	pl:AddDeaths(1)
end


// If HL2C Additions is enabled and the game is not in singleplayer, let every player alive & valid say something.
function HeIsDead()
	for _, pl in pairs(player.GetAll()) do
		if (game.SinglePlayer()) then return end
		if (pl:Team() != TEAM_ALIVE) then return end
		if (!pl:Alive()) then return end

		local modelNameGender = player_manager.TranslatePlayerModel(pl:GetInfo("cl_playermodel"))
		
		-- MALE --
		if modelNameGender && table.HasValue(PLAYER_MODELS_MALE, string.lower(modelNameGender)) then
			pl:EmitSound(MALE_HEISDEAD_SOUNDS[math.random(1, #MALE_HEISDEAD_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
		end
		-- MALE --
		
		-- FEMALE --
		if modelNameGender && table.HasValue(PLAYER_MODELS_FEMALE, string.lower(modelNameGender)) then
			pl:EmitSound(FEMALE_HEISDEAD_SOUNDS[math.random(1, #FEMALE_HEISDEAD_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
		end
		-- FEMALE --
		
		// Do we really want these custom voice lines playing when playermodel restrictions are on? We're gonna have combine rebels if I don't do this.
		if GetConVarNumber("hl2c_playermodel_restrictions") == 0 then
			
			-- ALYX --
			if modelNameGender == "models/player/alyx.mdl" then
				pl:EmitSound("vo/npc/alyx/ohgod01.wav", 75, pl.voicePitch, 1, CHAN_VOICE)
			end
			-- ALYX --
			
			-- BARNEY --
			if modelNameGender == "models/player/barney.mdl" then
				pl:EmitSound("vo/npc/barney/ba_ohshit03.wav", 75, pl.voicePitch, 1, CHAN_VOICE)
			end
			-- BARNEY --
		
		end
	end
end


// Heads up!
function PlayerWarning(pl)
	if (GetConVarNumber("hl2c_additions") == 0) then return end
	if (game.SinglePlayer()) then return end
	if (pl:Team() != TEAM_ALIVE) then return end
	if (!pl:Alive()) then return end
	if (warningPositions[1]) then return end

	local modelNameGender = player_manager.TranslatePlayerModel(pl:GetInfo("cl_playermodel"))
	
	-- MALE --
	if modelNameGender && table.HasValue(PLAYER_MODELS_MALE, string.lower(modelNameGender)) then
		pl:EmitSound("vo/npc/male01/headsup0"..math.random(1, 2)..".wav", 75, pl.voicePitch, 1, CHAN_VOICE)
	end
	-- MALE --
		
	-- FEMALE --
	if modelNameGender && table.HasValue(PLAYER_MODELS_FEMALE, string.lower(modelNameGender)) then
		pl:EmitSound("vo/npc/female01/headsup0"..math.random(1, 2)..".wav", 75, pl.voicePitch, 1, CHAN_VOICE)
	end
	-- FEMALE --
	
	table.insert(warningPositions, pl:EyePos())
	
	for _, pl in pairs(player.GetAll()) do
		net.Start("PlayerWarningPositions")
			net.WriteVector(warningPositions[1])
		net.Send(pl)
	end
	
	timer.Simple(12, function() PlayerWarningRemove() end)
end

// Connected with Player Warning, get rid of that one warning sign.
function PlayerWarningRemove()
	table.remove(warningPositions, 1)
	for _, pl in pairs(player.GetAll()) do
		if warningPositions[1] then
			net.Start("PlayerWarningPositions")
				net.WriteVector(warningPositions[1])
			net.Send(pl)
		else
			warningPositions = {}
			net.Start("PlayerWarningPositionsDisable")
			net.Send(pl)
		end
	end
end


// Some taunt sounds.
function PlayerTaunt(killer)
	if (game.SinglePlayer()) then return end
	if (killer:Team() != TEAM_ALIVE) then return end
	if (!killer:Alive()) then return end
	
	local modelNameGender = player_manager.TranslatePlayerModel(killer:GetInfo("cl_playermodel"))

	-- MALE --
	if modelNameGender && table.HasValue(PLAYER_MODELS_MALE, string.lower(modelNameGender)) then
		killer:EmitSound(MALE_TAUNT_SOUNDS[math.random(1, #MALE_TAUNT_SOUNDS)], 75, killer.voicePitch, 1, CHAN_VOICE)
	end
	-- MALE --

	-- FEMALE --
	if modelNameGender && table.HasValue(PLAYER_MODELS_FEMALE, string.lower(modelNameGender)) then
		killer:EmitSound(FEMALE_TAUNT_SOUNDS[math.random(1, #FEMALE_TAUNT_SOUNDS)], 75, killer.voicePitch, 1, CHAN_VOICE)
	end
	-- FEMALE --

	// Do we really want these custom voice lines playing when playermodel restrictions are on? We're gonna have combine rebels if I don't do this.
	if GetConVarNumber("hl2c_playermodel_restrictions") == 0 then
		
		-- ALYX --
		if modelNameGender == "models/player/alyx.mdl" then
			killer:EmitSound("vo/npc/alyx/brutal02.wav", 75, killer.voicePitch, 1, CHAN_VOICE)
		end
		-- ALYX --
		
		-- BARNEY --
		if modelNameGender == "models/player/barney.mdl" then
			killer:EmitSound("vo/npc/barney/ba_laugh0"..math.random(1, 4)..".wav", 75, killer.voicePitch, 1, CHAN_VOICE)
		end
		-- BARNEY --

	end
end


// Some random voice lines
function PlayerVoiceLine(pl)
	if (GetConVarNumber("hl2c_additions") == 0) then return end
	if (game.SinglePlayer()) then return end
	if (pl:Team() != TEAM_ALIVE) then pl:EmitSound("ambient/levels/citadel/strange_talk"..math.random(3, 11)..".wav", 75, 100, 1, CHAN_VOICE) return end
	if (!pl:Alive()) then return end
	
	local modelNameGender = player_manager.TranslatePlayerModel(pl:GetInfo("cl_playermodel"))

	-- MALE --
	if modelNameGender && table.HasValue(PLAYER_MODELS_MALE, string.lower(modelNameGender)) then
		pl:EmitSound(MALE_VOICELINE_SOUNDS[math.random(1, #MALE_VOICELINE_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
	end
	-- MALE --

	-- FEMALE --
	if modelNameGender && table.HasValue(PLAYER_MODELS_FEMALE, string.lower(modelNameGender)) then
		pl:EmitSound(FEMALE_VOICELINE_SOUNDS[math.random(1, #FEMALE_VOICELINE_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
	end
	-- FEMALE --
	
	// Do we really want these custom voice lines playing when playermodel restrictions are on? We're gonna have combine rebels if I don't do this.
	if GetConVarNumber("hl2c_playermodel_restrictions") == 0 then
	
		-- COMBINE --
		if modelNameGender && table.HasValue(PLAYER_MODELS_COMBINE, string.lower(modelNameGender)) then
			pl:EmitSound(COMBINE_VOICELINE_SOUNDS[math.random(1, #COMBINE_VOICELINE_SOUNDS)], 75, pl.voicePitch, 1, CHAN_VOICE)
		end
		-- COMBINE --
		
	end
end


// Called when map entities spawn
function GM:EntityKeyValue(ent, key, value)
	if ent:GetClass() == "trigger_changelevel" && key == "map" then
		ent.map = value
	end
end


// Called when an entity has received damage	  
function GM:EntityTakeDamage(ent, inflictor, attacker, amount, dmgInfo)
	if ent && ent:IsValid() && !ent:IsPlayer() && attacker && attacker:IsValid() && attacker:IsPlayer() && attacker:Alive() then
		if attacker:GetActiveWeapon() && attacker:GetActiveWeapon():IsValid() && attacker:GetActiveWeapon():GetClass() == "weapon_crowbar" then
			dmgInfo:ScaleDamage(0.4)
		elseif attacker:InVehicle() && attacker:GetVehicle() && attacker:GetVehicle():GetClass() == "prop_vehicle_airboat" then
			dmgInfo:SetDamage(1)
		end
	end
end


// Called by GoToNextLevel
function GM:GrabAndSwitch()
	for _, pl in pairs(player.GetAll()) do
		local plInfo = {}
		local plWeapons = pl:GetWeapons()
		
		plInfo.predicted_map = NEXT_MAP
		plInfo.health = pl:Health()
		plInfo.armor = pl:Armor()
		plInfo.score = pl:Frags()
		plInfo.deaths = pl:Deaths()
		plInfo.model = pl.modelName
		
		if plWeapons && #plWeapons > 0 then
			plInfo.loadout = {}
			
			for _, wep in pairs(plWeapons) do
				plInfo.loadout[wep:GetClass()] = {pl:GetAmmoCount(wep:GetPrimaryAmmoType()), pl:GetAmmoCount(wep:GetSecondaryAmmoType())}
			end
		end
		
		file.Write("hl2c_userid_info/hl2c_userid_info_"..pl:UniqueID()..".txt", util.TableToKeyValues(plInfo))
	end
	
	-- Crash Recovery --
	if game.IsDedicated(true) then
		local savedMap = {}
		
		savedMap.predicted_crash = NEXT_MAP
		
		file.Write("hl2c_data/hl2c_crash_recovery.txt", util.TableToKeyValues(savedMap))
	end
	-- End --
	
	// Switch maps
	game.ConsoleCommand("changelevel "..NEXT_MAP.."\n")
end


// Called by point_changelevel_extra
function GM:GrabAndSwitchExtra()
	for _, pl in pairs(player.GetAll()) do
		local plInfo = {}
		local plWeapons = pl:GetWeapons()
		
		plInfo.predicted_map = NEXT_MAP
		plInfo.health = pl:Health()
		plInfo.armor = pl:Armor()
		plInfo.score = pl:Frags()
		plInfo.deaths = pl:Deaths()
		plInfo.model = pl.modelName
		
		if plWeapons && #plWeapons > 0 then
			plInfo.loadout = {}
			
			for _, wep in pairs(plWeapons) do
				plInfo.loadout[wep:GetClass()] = {pl:GetAmmoCount(wep:GetPrimaryAmmoType()), pl:GetAmmoCount(wep:GetSecondaryAmmoType())}
			end
		end
		
		file.Write("hl2c_userid_info/hl2c_userid_info_"..pl:UniqueID()..".txt", util.TableToKeyValues(plInfo))
	end
	
	-- Crash Recovery --
	if game.IsDedicated(true) then
		local savedMap = {}
		
		savedMap.predicted_crash = EXTRA_MAP
		
		file.Write("hl2c_data/hl2c_crash_recovery.txt", util.TableToKeyValues(savedMap))
	end
	-- End --
	
	// Switch maps
	game.ConsoleCommand("changelevel "..EXTRA_MAP.."\n")
end


// Added these here because they were undefined!
deadPlayers = {}
difficulty = 1
changingLevel = false
checkpointPositions = {}
nextAreaOpenTime = 0
startingWeapons = {}
warningPositions = {}

// Called immediately after starting the gamemode  
function GM:Initialize()
	deadPlayers = {}
	difficulty = 1
	changingLevel = false
	checkpointPositions = {}
	nextAreaOpenTime = 0
	startingWeapons = {}
	warningPositions = {}
	
	// We want regular fall damage and the ai to attack players and stuff
	game.ConsoleCommand("ai_disabled 0\n")
	game.ConsoleCommand("ai_ignoreplayers 0\n")
	game.ConsoleCommand("hl2_episodic 0\n")
	game.ConsoleCommand("mp_falldamage 1\n")
	game.ConsoleCommand("physgun_limited 1\n")
	game.ConsoleCommand("ai_serverragdolls 0\n")
	if GetConVarNumber("hl2c_additions") >= 1 then
		game.ConsoleCommand("sv_rollangle 2\n")
	else
		game.ConsoleCommand("sv_rollangle 0\n")
	end
	if string.find(game.GetMap(), "ep1_") || string.find(game.GetMap(), "ep2_") then
		game.ConsoleCommand("hl2_episodic 1\n")
	end
	if string.find(game.GetMap(), "t0a") || string.find(game.GetMap(), "c0a") || string.find(game.GetMap(), "c1a") || string.find(game.GetMap(), "c2a") || string.find(game.GetMap(), "c3a") || string.find(game.GetMap(), "c4a") || string.find(game.GetMap(), "c5a") then
		HL1_CAMPAIGN = true
	else
		HL1_CAMPAIGN = false
	end
	
	// Super gravity gun test
	if SUPER_GRAVITY_GUN then
		RunConsoleCommand("physcannon_pullforce", "8000")
		RunConsoleCommand("physcannon_tracelength", "850")
	end
	
	// Kill the engine if *** is not mounted.
	if GetConVarNumber("hl2c_classic") == 0 then
		if !game.IsDedicated(true) then
			-- Half-Life 2
			if string.find(game.GetMap(), "d1_") || string.find(game.GetMap(), "d2_") || string.find(game.GetMap(), "d3_") then
				if !IsMounted("hl2") then
					// Just kill the whole engine with this.
					game.ConsoleCommand("killserver\n")
				end
			end
				
			-- Episode 1
			if string.find(game.GetMap(), "ep1_") then
				if !IsMounted("episodic") then
					// Just kill the whole engine with this.
					game.ConsoleCommand("killserver\n")
				end
			end
			
			-- Episode 2
			if string.find(game.GetMap(), "ep2_") then
				if !IsMounted("ep2") then
					// Just kill the whole engine with this.
					game.ConsoleCommand("killserver\n")
				end
			end
				
			-- Half-Life: Source
			if HL1_CAMPAIGN == true && !IsMounted("hl1") then
				// Just kill the whole engine with this.
				game.ConsoleCommand("killserver\n")
			end
		end
	end
	
	// Create directories for data
	file.CreateDir("hl2c_userid_info")
	file.CreateDir("hl2c_data")
	
	// Jeep
	local jeep = {
		Name = "Jeep",
		Class = "prop_vehicle_jeep_old",
		Model = "models/buggy.mdl",
		KeyValues = {	
			vehiclescript =	"scripts/vehicles/jeep_test.txt",
			EnableGun = 1
		}
	}
	list.Set("Vehicles", "Jeep", jeep)
	
	// Named Jeep
	local namedjeep = {
		Name = "Jeep",
		Class = "prop_vehicle_jeep_old",
		Model = "models/buggy.mdl",
		KeyValues = {	
			vehiclescript =	"scripts/vehicles/jeep_test.txt",
			targetname = "jeep",
			EnableGun = 1
		}
	}
	list.Set("Vehicles", "Named Jeep", namedjeep)
	
	// Airboat
	local airboat = {
		Name = "Airboat",
		Class = "prop_vehicle_airboat",
		Category = Category,
		Model = "models/airboat.mdl",
		KeyValues = {
			vehiclescript = "scripts/vehicles/airboat.txt",
			EnableGun = 0
		}
	}
	list.Set("Vehicles", "Airboat", airboat)
	
	// Named Airboat
	local namedAirboat = {
		Name = "Named Airboat",
		Class = "prop_vehicle_airboat",
		Category = Category,
		Model = "models/airboat.mdl",
		KeyValues = {
			vehiclescript = "scripts/vehicles/airboat.txt",
			EnableGun = 0
		}
	}
	list.Set("Vehicles", "Named Airboat", airboat)
	
	// Airboat w/gun
	local airboatGun = {
		Name = "Airboat Gun",
		Class = "prop_vehicle_airboat",
		Category = Category,
		Model = "models/airboat.mdl",
		KeyValues = {
			vehiclescript = "scripts/vehicles/airboat.txt",
			EnableGun = 1
		}
	}
	list.Set("Vehicles", "Airboat Gun", airboatGun)
	
	// Jalopy
	local jalopy = {
		Name = "Jalopy",
		Class = "prop_vehicle_jeep",
		Model = "models/vehicle.mdl",
		KeyValues = {	
			vehiclescript =	"scripts/vehicles/jalopy.txt",
		}
	}
	list.Set("Vehicles", "Jalopy", jalopy)
end


// Called as soon as all map entities have been spawned 
function GM:InitPostEntity()
	if !NEXT_MAP then
		MsgN('Next map unknown, going back to start of HL2!')
		NEXT_MAP = 'd1_trainstation_01'
		return
	end
	
	-- Half-Life 2: DM coop maps don't spawn on these.
	if !HL2MP_IS_COOP_MAP then
		// Remove old spawn points
		for _, ips in pairs(ents.FindByClass("info_player_start")) do
			if !ips:HasSpawnFlags(1) || INFO_PLAYER_SPAWN then
				ips:Remove()
			end
		end
	
		// Setup INFO_PLAYER_SPAWN
		if INFO_PLAYER_SPAWN then
			GAMEMODE:CreateSpawnPoint(INFO_PLAYER_SPAWN[1], INFO_PLAYER_SPAWN[2])
		end
	end
	
	// Setup TRIGGER_CHECKPOINT
	if !game.SinglePlayer() then
		if TRIGGER_CHECKPOINT then
			for _, tcpInfo in pairs(TRIGGER_CHECKPOINT) do
				local tcp = ents.Create("trigger_checkpoint")
				
				tcp.min = tcpInfo[1]
				tcp.max = tcpInfo[2]
				tcp.pos = tcp.max - ((tcp.max - tcp.min) / 2)
				tcp.skipSpawnpoint = tcpInfo[3]
				tcp.OnTouchRun = tcpInfo[4]
				
				tcp:SetPos(tcp.pos)
				tcp:Spawn()
				
				table.insert(checkpointPositions, tcp.pos)
			end
		end
	end
	
	// Setup BRUSH_PLAYERFREEZE
	if BRUSH_PLAYERFREEZE then
		for _, pfInfo in pairs(BRUSH_PLAYERFREEZE) do
			local pf = ents.Create("brush_playerfreeze")
			
			pf.min = pfInfo[1]
			pf.max = pfInfo[2]
			pf.pos = pf.max - ((pf.max - pf.min) / 2)
			
			pf:SetPos(pf.pos)
			pf:Spawn()
		end
	end
	
	// Setup BRUSH_PLAYERCLIP
	// RECREATED DUE TO BUGS WITH BRUSH_PLAYERFREEZE NOT WORKING AT TIMES
	if BRUSH_PLAYERCLIP then
		for _, pcInfo in pairs(BRUSH_PLAYERCLIP) do
			local pc = ents.Create("brush_playerclip")
			
			pc.min = pcInfo[1]
			pc.max = pcInfo[2]
			pc.pos = pc.max - ((pc.max - pc.min) / 2)
			
			pc:SetPos(pc.pos)
			pc:Spawn()
		end
	end
	
	// Setup TRIGGER_VEHICLESPAWN
	if TRIGGER_VEHICLESPAWN then
		for _, tvsInfo in pairs(TRIGGER_VEHICLESPAWN) do
			local tvs = ents.Create("trigger_vehiclespawn")
			
			tvs.min = tvsInfo[1]
			tvs.max = tvsInfo[2]
			tvs.pos = tvs.max - ((tvs.max - tvs.min) / 2)
			
			tvs:SetPos(tvs.pos)
			tvs:Spawn()
		end
	end
	
	// Setup TRIGGER_DELAYMAPLOAD
	if TRIGGER_DELAYMAPLOAD then
		GAMEMODE:CreateTDML(TRIGGER_DELAYMAPLOAD[1], TRIGGER_DELAYMAPLOAD[2])
	
		for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
			tcl:Remove()
		end
	else
		for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
			if tcl.map == NEXT_MAP then			
				local tclMin, tclMax = tcl:WorldSpaceAABB()
				GAMEMODE:CreateTDML(tclMin, tclMax)
			end
			tcl:Remove()
		end
	end
	table.insert(checkpointPositions, tdmlPos)
	
	-- Half-Life 2: DM coop maps don't need to show the checkpoint positions, we're keeping it clean.
	if !HL2MP_IS_COOP_MAP then
		// Old usermessages
		if GetConVarNumber("hl2c_use_old_umsg") >= 1 then
			umsg.Start("SetCheckpointPosition", RecipientFilter():AddAllPlayers())
			umsg.Vector(checkpointPositions[#checkpointPositions])
			umsg.End()
		elseif GetConVarNumber("hl2c_use_old_umsg") == 0 then
			// Use the new net library
			for _, pl in pairs(player.GetAll()) do
				net.Start("SetCheckpointPosition")
					net.WriteVector(checkpointPositions[#checkpointPositions])
				net.Send(pl)
			end
		end
	end
	
	-- Crash Recovery --
	// Let me execute this so we go back to the map that we crashed on.
		if game.IsDedicated(true) then
			if file.Exists("hl2c_data/hl2c_crash_recovery.txt", "DATA") then
			mapRecover = util.KeyValuesToTable(file.Read("hl2c_data/hl2c_crash_recovery.txt", "DATA"))
		
				if mapRecover.predicted_crash != game.GetMap() then
					game.ConsoleCommand("changelevel "..mapRecover.predicted_crash.."\n")
				end
			end
		end
	-- End --
	
	-- Is *** Mounted? --
	// Classic Mode way.
	if GetConVarNumber("hl2c_classic") >= 1 then // This was the original way I was going to do to the players.
		if !game.IsDedicated(true) then
			-- Half-Life 2
			if string.find(game.GetMap(), "d1_") || string.find(game.GetMap(), "d2_") || string.find(game.GetMap(), "d3_") then
				if !IsMounted("hl2") then
					// This shuts the listen server down. This won't give an Engine Error.
					game.ConsoleCommand("killserver\n")
				end
			end
			
			-- Episode 1
			if string.find(game.GetMap(), "ep1_") then
				if !IsMounted("episodic") then
					// This shuts the listen server down. This won't give an Engine Error.
					game.ConsoleCommand("killserver\n")
				end
			end
			
			-- Episode 2
			if string.find(game.GetMap(), "ep2_") then
				if !IsMounted("ep2") then
					// This shuts the listen server down. This won't give an Engine Error.
					game.ConsoleCommand("killserver\n")
				end
			end
			
			-- Half-Life: Source
			if HL1_CAMPAIGN == true && !IsMounted("hl1") then
				// This shuts the listen server down. This won't give an Engine Error.
				game.ConsoleCommand("killserver\n")
			end
		end
	end
	-- End --
	
	// Fix NPCs not killing or targeting you
	if (!string.find(game.GetMap(), "d1_trainstation_") || string.find(game.GetMap(), "d1_trainstation_04") || string.find(game.GetMap(), "d1_trainstation_06")) && !game.SinglePlayer() then
		local envG1 = ents.Create("env_global")
		envG1:SetPos(Vector(150, -100, 150))
		envG1:SetKeyValue("targetname", "hl2c_gordon_criminal_global")
		envG1:SetKeyValue("globalstate", "gordon_precriminal")
		envG1:SetKeyValue("spawnflags", "1")
		envG1:SetKeyValue("initialstate", "0")
		envG1:Spawn()
		envG1:Activate()
		envG1:Fire("turnoff", "", "1.0")
		envG1:Fire("kill", "", "5.0")
		
		local envG2 = ents.Create("env_global")
		envG2:SetPos(Vector(-150, 100, -150))
		envG2:SetKeyValue("targetname", "hl2c_gordon_invulnerable_global")
		envG2:SetKeyValue("globalstate", "gordon_invulnerable")
		envG2:SetKeyValue("spawnflags", "1")
		envG2:SetKeyValue("initialstate", "0")
		envG2:Spawn()
		envG2:Activate()
		envG2:Fire("turnoff", "", "1.0")
		envG2:Fire("kill", "", "5.0")
	end
	
	if !game.SinglePlayer() then
		// Remove fall_trigger triggers which cause the game to "end"
		local triggerMultiples = ents.FindByName("fall_trigger")
		for _, falltrigger in pairs(triggerMultiples) do
			falltrigger:Remove()
		end
	end
	
	if GetConVarNumber("hl2c_additions") >= 1 && !game.SinglePlayer() then
		local hl2_suitcharger = ents.FindByClass("item_suitcharger")
		for _, scharger in pairs(hl2_suitcharger) do
			scharger:Fire("addoutput", "OnEmpty !self,Recharge,,0.5,-1")
		end
	end
	
	if HL1_START_TRAM == true then
		local ips2 = ents.FindByClass("info_player_start")
		local tram = ents.FindByName("train")
		for _, parips in pairs(ips2) do
			parips:SetMoveType( MOVETYPE_NONE )
			parips:SetParent( tram[1], -1 )
		end
	end
		
	// Remove global_newgame entities since they are useless.
	local globalNewgame = ents.FindByName("global_newgame_template")
	for _, gng in pairs(globalNewgame) do
		gng:Remove()
	end
	
	// Remove global_newgame entities since they are useless.
	local globalNewgameLocalItems = ents.FindByName("global_newgame_template_local_items")
	for _, gngli in pairs(globalNewgameLocalItems) do
		gngli:Remove()
	end
	
	// Remove global_newgame entities since they are useless.
	local globalNewgameAmmo = ents.FindByName("global_newgame_template_ammo")
	for _, gnga in pairs(globalNewgameAmmo) do
		gnga:Remove()
	end
	
	// Remove global_newgame entities since they are useless.
	local globalNewgameBaseItems = ents.FindByName("global_newgame_template_base_items")
	for _, gngbi in pairs(globalNewgameBaseItems) do
		gngbi:Remove()
	end
	
	// Remove start_item entities since they are useless.
	local startItemsTemplate = ents.FindByName("start_item_template")
	for _, sIT in pairs(startItemsTemplate) do
		sIT:Remove()
	end
	
	// Remove player_spawn_item_template entities since they are useless.
	local playerSpawnItemsTemplate = ents.FindByName("player_spawn_items_template")
	for _, pSIT in pairs(playerSpawnItemsTemplate) do
		pSIT:Remove()
	end
	
	// Remove player_spawn_item_maker entities since they are useless.
	local playerSpawnItemsMaker = ents.FindByName("player_spawn_items_maker")
	for _, pSIM in pairs(playerSpawnItemsMaker) do
		pSIM:Remove()
	end
end 


// Called automatically or by the console command
function GM:NextMap()
	if changingLevel then
		return
	end
	
	changingLevel = true
	
	umsg.Start("NextMap", RecipientFilter():AddAllPlayers())
	umsg.Long(CurTime())
	umsg.End()
	
	if GetConVarNumber("hl2c_old_nextmap_timer") == 0 then
		if GetConVarNumber("hl2c_classic") >= 1 then
			timer.Simple(NEXT_MAP_TIME_CLASSIC, function() GAMEMODE:GrabAndSwitch() end) -- New code. After finding out this causes an error sometimes, I had to do this.
		elseif GetConVarNumber("hl2c_classic") == 0 then
			timer.Simple(NEXT_MAP_TIME, function() GAMEMODE:GrabAndSwitch() end) -- New code. After finding out this causes an error sometimes, I had to do this.
		end
	else
		if GetConVarNumber("hl2c_classic") >= 1 then
			timer.Simple(NEXT_MAP_TIME_CLASSIC, GAMEMODE.GrabAndSwitch) -- Old code. Seems to still work in current GMod. This way appears more stable for some reason.
		elseif GetConVarNumber("hl2c_classic") == 0 then
			timer.Simple(NEXT_MAP_TIME, GAMEMODE.GrabAndSwitch) -- Old code. Seems to still work in current GMod. This way appears more stable for some reason.
		end
	end
end
concommand.Add("hl2c_next_map", function(pl) if pl:IsAdmin() then GAMEMODE:NextMap() end end)


// Called when an NPC dies
function GM:OnNPCKilled(npc, killer, weapon)
	if killer && killer:IsValid() && killer:IsVehicle() && killer:GetDriver():IsPlayer() then
		killer = killer:GetDriver()
	end
	
	// If the killer is a player then decide what to do with their points
	if killer && killer:IsValid() && killer:IsPlayer() && npc && npc:IsValid() then
		if table.HasValue(GODLIKE_NPCS, npc:GetClass()) || npc:GetName() == "rocketman" then
			if !game.SinglePlayer() then -- This should only end up being used in multiplayer.
				game.ConsoleCommand("kickid "..killer:UserID().." \"Killed an important NPC actor!\"\n")
				GAMEMODE:RestartMap()
			end
		elseif NPC_POINT_VALUES[npc:GetClass()] then
			killer:AddFrags(NPC_POINT_VALUES[npc:GetClass()])
		else
			killer:AddFrags(1)
		end
	end
	
	// Convert the inflictor to the weapon that they're holding if we can. 
 	if weapon && weapon != NULL && killer == weapon && (weapon:IsPlayer() || weapon:IsNPC()) then 
 		weapon = weapon:GetActiveWeapon() 
 		if killer == NULL then weapon = killer end 
 	end 
 	
	// Defaults
 	local weaponClass = "World" 
 	local killerClass = "World" 
 	
	// Change to actual values if not default
 	if weapon && weapon != NULL then weaponClass = weapon:GetClass() end 
 	if killer && killer != NULL then killerClass = killer:GetClass() end 
	
	// Play a random taunt sound
	if GetConVarNumber("hl2c_additions") >= 1 then
		if killer && killer != NULL && killer:IsPlayer() then
			if (table.HasValue(FRIENDLY_NPCS, npc:GetClass()) || table.HasValue(GODLIKE_NPCS, npc:GetClass())) then
				return
			end
		
			if (math.random(1, 6) <= 3) then
				PlayerTaunt(killer)
			end
		end
	end
	
	// Send a message
 	if killer && killer != NULL && killer:IsPlayer() then 
		net.Start("PlayerKilledNPC")
			net.WriteString(npc:GetClass())
			net.WriteString(weaponClass)
			net.WriteEntity(killer)
		net.Broadcast()
 	end
end


// Called when a player tries to pickup a weapon
function GM:PlayerCanPickupWeapon(pl, weapon) 
	if pl:Team() != TEAM_ALIVE || (game.SinglePlayer() && weapon:GetClass() == "weapon_stunstick") || (weapon:GetClass() == "weapon_physgun" && !pl:IsAdmin()) then
		weapon:Remove()
		return false
	end
	
	if SUPER_GRAVITY_GUN && weapon:GetClass() != "weapon_physcannon" then
		return false
	end
	
	if weapon:GetClass() == "weapon_stunstick" && GetConVarNumber("hl2c_allow_stunstick") == 0 then
		weapon:Remove()
		return false
	end
	
	if game.SinglePlayer() && weapon:GetClass() == "weapon_medkit_hl2c" then -- Medkits are stupid in Singleplayer.
		weapon:Remove()
		return false
	end
	
	if GetConVarNumber("hl2c_classic") >= 1 && weapon:GetClass() == "weapon_medkit_hl2c" then -- Medkits weren't in HL2C 1.2.6.
		weapon:Remove()
		return false
	end
	
	
	if GetConVarNumber("hl2c_ammo_limits") >= 1 then
	
		if weapon:GetClass() == "weapon_slam" then
			if pl:GetAmmoCount("slam") >= GetConVarNumber("hl2c_ammo_slam_max") then
				return false
			end
		end
		
	end
	
	return true
end


// Called when a player tries to pickup a item
function GM:PlayerCanPickupItem(pl, item)
	if pl:Team() != TEAM_ALIVE then
		return false
	end
	
	if GetConVarNumber("hl2c_ammo_limits") >= 1 || HL2MP_IS_COOP_MAP then
	
		if item:GetClass() == "item_ammo_pistol" || item:GetClass() == "item_ammo_pistol_large" then
			if pl:GetAmmoCount("pistol") >= GetConVarNumber("hl2c_ammo_pistol_max") then
				return false
			end
		end
		
		if item:GetClass() == "item_ammo_357" || item:GetClass() == "item_ammo_357_large" then
			if pl:GetAmmoCount("357") >= GetConVarNumber("hl2c_ammo_357_max") then
				return false
			end
		end
		
		if item:GetClass() == "item_ammo_smg1" || item:GetClass() == "item_ammo_smg1_large" then
			if pl:GetAmmoCount("smg1") >= GetConVarNumber("hl2c_ammo_smg1_max") then
				return false
			end
		end
		
		if item:GetClass() == "item_ammo_smg1_grenade" then
			if pl:GetAmmoCount("smg1_grenade") >= GetConVarNumber("hl2c_ammo_smg1_grenade_max") then
				return false
			end
		end
		
		if item:GetClass() == "item_ammo_ar2" || item:GetClass() == "item_ammo_ar2_large" then
			if pl:GetAmmoCount("ar2") >= GetConVarNumber("hl2c_ammo_ar2_max") then
				return false
			end
		end
		
		if item:GetClass() == "item_ammo_ar2_altfire" then
			if pl:GetAmmoCount("ar2altfire") >= GetConVarNumber("hl2c_ammo_ar2altfire_max") then
				return false
			end
		end
		
		if item:GetClass() == "item_box_buckshot" then
			if pl:GetAmmoCount("buckshot") >= GetConVarNumber("hl2c_ammo_buckshot_max") then
				return false
			end
		end
		
		if item:GetClass() == "item_ammo_crossbow" then
			if pl:GetAmmoCount("xbowbolt") >= GetConVarNumber("hl2c_ammo_xbowbolt_max") then
				return false
			end
		end
		
		if item:GetClass() == "item_rpg_round" then
			if pl:GetAmmoCount("rpg_round") >= GetConVarNumber("hl2c_ammo_rpg_round_max") then
				return false
			end
		end
	
	end
	
	return true
end


// Called when a player disconnects
function GM:PlayerDisconnected(pl)
	if file.Exists("hl2c_userid_info/hl2c_userid_info_"..pl:UniqueID()..".txt", "DATA") then
		file.Delete("hl2c_userid_info/hl2c_userid_info_"..pl:UniqueID()..".txt")
	end
	
	pl:RemoveVehicle()
	
	if game.IsDedicated(true) && #player.GetAll() == 1 then
		game.ConsoleCommand("changelevel "..game.GetMap().."\n")
	end
end


// Called just before the player's first spawn 
function GM:PlayerInitialSpawn(pl)
	pl.startTime = CurTime()
	pl:SetTeam(TEAM_ALIVE)
	
	// Half-Life 2: DM mode is enabled
	if HL2MP_IS_COOP_MAP then
		pl:ChatPrint("You're playing Half-Life 2 Campaign in a Half-Life 2: Deathmatch map.")
	end
	
	// MaxPlayers is over 10, warn the player.
	if game.MaxPlayers() > 10 then
		pl:ChatPrint("This server allows more than 10 players! Be warned that the server may lag harshly under these conditions.")
	end
	
	// Send this to clients that Sandbox mode is on
	if GetConVarNumber("hl2c_spawnmenu") >= 1 then
		net.Start("SpawnMenuEnabled")
		net.Send(pl)
	end
	
	// In Singleplayer, don't let the players wait for the level to change or restart
	if game.SinglePlayer() then
		NEXT_MAP_TIME = 0
		NEXT_MAP_TIME_CLASSIC = 0
		RESTART_MAP_TIME = 4
	end
	
	// If vehicles are allowed, print a message.
	if ALLOWED_VEHICLE then
		pl:ChatPrint("Press ShowSpare1(F3) to spawn a vehicle.")
	end
	
	// CUSTOM COLLISION CHECK FOR PLAYERS SO YOU CANNOT COLLIDE WITH EACH OTHER OR FRIENDLY NPCS
	// Make sure this only applies in multiplayer!
	if !game.SinglePlayer() then
		pl:SetCustomCollisionCheck(true)
	end
	
	// Grab previous map info
	local plUniqueId = pl:UniqueID()
	if file.Exists("hl2c_userid_info/hl2c_userid_info_"..plUniqueId..".txt", "DATA") then
		pl.info = util.KeyValuesToTable(file.Read("hl2c_userid_info/hl2c_userid_info_"..plUniqueId..".txt", "DATA"))
		
		if pl.info.predicted_map != game.GetMap() || RESET_PL_INFO then
			file.Delete("hl2c_userid_info/hl2c_userid_info_"..plUniqueId..".txt")
			pl.info = nil
		elseif RESET_WEAPONS then
			pl.info.loadout = nil
		end
	end
	
	if GetConVarNumber("hl2c_betatester_trails") >= 1 then
		if !game.SinglePlayer() && table.HasValue(BETA_TESTERS, pl:SteamID()) then
			util.SpriteTrail(pl, 0, Color(255, 255, 255, 255), true, 10, 0, 1, 1 / (5 + 3) * 0.5, "trails/physbeam.vmt")
		end
	end
	
	if !HL2MP_IS_COOP_MAP then
		// Set current checkpoint
		if GetConVarNumber("hl2c_use_old_umsg") >= 1 then
			umsg.Start("PlayerInitialSpawn", pl)
			umsg.Vector(checkpointPositions[1])
			umsg.End()
		elseif GetConVarNumber("hl2c_use_old_umsg") == 0 then
			net.Start("PlayerInitialSpawn")
				net.WriteVector(checkpointPositions[1])
			net.Send(pl)
		end
	end
end 


// Called by GM:PlayerSpawn
function GM:PlayerLoadout(pl)
	if pl.info && pl.info.loadout then
		for wep, ammo in pairs(pl.info.loadout) do
			pl:Give(wep)
		end
		
		pl:RemoveAllAmmo()
		
		for _, wep in pairs(pl:GetWeapons()) do
			local wepClass = wep:GetClass()
			
			if pl.info.loadout[wepClass] then
				pl:GiveAmmo(tonumber(pl.info.loadout[wepClass][1]), wep:GetPrimaryAmmoType(), false)
				pl:GiveAmmo(tonumber(pl.info.loadout[wepClass][2]), wep:GetSecondaryAmmoType(), false)
			end
		end
	elseif startingWeapons && #startingWeapons > 0 then
		for _, wep in pairs(startingWeapons) do
			pl:Give(wep)
		end
	end
	
	// HL2MP Coop Map in use we should give the Rebel kit.
	if HL2MP_IS_COOP_MAP then
		pl:Give("weapon_crowbar")
		pl:Give("weapon_physcannon")
		pl:Give("weapon_pistol")
		pl:Give("weapon_smg1")
		pl:Give("weapon_frag")
		pl:Give("weapon_frag")
	end
	
	// Lastly give physgun to admins
	if GetConVarNumber("hl2c_admin_physgun") >= 1 && pl:IsAdmin() then
		pl:Give("weapon_physgun")
	end
end


// Called when the player attempts to noclip
function GM:PlayerNoClip(pl)
	if pl:IsAdmin() && GetConVarNumber("hl2c_admin_noclip") == 1 then
		return true
	end
	
	return false
end 


// Select the player spawn
function GM:PlayerSelectSpawn(pl)
	if !HL2MP_IS_COOP_MAP then
		local spawnPoints = ents.FindByClass("info_player_start")
		return spawnPoints[#spawnPoints]
	else
		local spawnPointsRebel = ents.FindByClass("info_player_rebel")
		local spawnPointsRebel_Random = math.random(#spawnPointsRebel)
		return spawnPointsRebel[spawnPointsRebel_Random]
	end
end 


// Set the player model
function GM:PlayerSetModel(pl)
	if pl.info && pl.info.model then
		pl.modelName = pl.info.model
	else
		local modelName = player_manager.TranslatePlayerModel(pl:GetInfo("cl_playermodel"))
		
		if GetConVarNumber("hl2c_playermodel_restrictions") >= 1 then
			if modelName && table.HasValue(PLAYER_MODELS, string.lower(modelName)) then
				pl.modelName = modelName
			else
				pl.modelName = PLAYER_MODELS[math.random(1, #PLAYER_MODELS)]
			end
		elseif GetConVarNumber("hl2c_playermodel_restrictions") != 1 then
			if modelName then
				pl.modelName = modelName
			end
		end
	end
	
	util.PrecacheModel(pl.modelName)
	pl:SetModel(pl.modelName)
end


// Called when a player spawns 
function GM:PlayerSpawn(pl)

	player_manager.SetPlayerClass( pl, "player_coop" )
	
	if GetConVarNumber("hl2c_drop_weapon_on_death") >= 1 && !game.SinglePlayer() then
		pl:ShouldDropWeapon(true)
	else
		pl:ShouldDropWeapon(false)
	end

	if pl:IsBot() && GetConVarNumber("hl2c_bot_spectate") != 0 then
		pl:SetTeam(TEAM_BOT_SPECTATOR)
	end
	
	if pl:Team() == TEAM_BOT_SPECTATOR then
		pl:Spectate(OBS_MODE_IN_EYE)
		pl:SetNoTarget(true)
		return
	end
	
	if pl:Team() == TEAM_DEAD then
		pl:Spectate(OBS_MODE_ROAMING)
		pl:SetPos(pl.deathPos)
		pl:SetNoTarget(true)
		return
	end
	
	// Player vars
	pl.energy = 100
	pl.givenWeapons = {}
	pl.healthRemoved = 0
	pl.nextEnergyCycle = 0
	pl.nextSetHealth = 0
	pl.sprintDisabled = false
	pl.flashlightDisabled = false
	pl.vehicleAllowed = false
	pl.vulnerable = true
	timer.Simple(VULNERABLE_TIME, function(pl) if pl && pl:IsValid() then pl.vulnerable = true end end, pl)
	
	// Player buyable abilities
	pl.abilityCycle = 0
	pl.abilityEnergy = 100
	pl.abilityInUse = false
	pl.abilityInvis = false
	pl.abilityInvinc = false
	pl.abilityScaler = false
	pl.voicePitch = 100
	pl.abilitySuitCharge = false
	
	// Speed, loadout, and model
	GAMEMODE:SetPlayerSpeed(pl, 190, 320)
	GAMEMODE:PlayerSetModel(pl)
	GAMEMODE:PlayerLoadout(pl)
	
	// Set more speed stuff.
	pl:SetCrouchedWalkSpeed(0.3)
	pl:SetDuckSpeed(0.3)
	pl:SetUnDuckSpeed(0.3)
	if HL1_CAMPAIGN == true then
		pl:SetJumpPower(200)
	end
	
	// Set stuff from last level
	if pl.info then
		if pl.info.health > 0 then
			pl:SetHealth(pl.info.health)
		end
		
		if pl.info.armor > 0 then
			pl:SetArmor(pl.info.armor)
		end
		
		pl:SetFrags(pl.info.score)
		pl:SetDeaths(pl.info.deaths)
	end
	
	// Players should avoid players
	pl:SetAvoidPlayers(true)
	pl:SetNoTarget(false)
	
	// If the player died before, kill them again
	if table.HasValue(deadPlayers, pl:UniqueID()) then
		if GetConVarNumber("hl2c_classic") >= 1 then
			pl:PrintMessage(HUD_PRINTTALK, "You may not respawn until the next map or when a checkpoint is reached. Nice try though.")
		elseif GetConVarNumber("hl2c_classic") == 0 then
			pl:PrintMessage(HUD_PRINTTALK, "You may not respawn until the next map. Nice try though.")
		end
		
		pl.deathPos = pl:EyePos()
		pl.deathPosBeta = pl:GetPos()
		
		pl:RemoveVehicle()
		pl:Flashlight(false)
		pl:SetTeam(TEAM_DEAD)
		pl:AddDeaths(1)
		
		pl:KillSilent()
	end

	if GetConVarNumber("hl2c_hev_hands") >= 1 then
		pl:SetupHands()
	elseif GetConVarNumber("hl2c_hev_hands") == 0 then
			local oldhands = pl:GetHands()
			if ( IsValid( oldhands ) ) then oldhands:Remove() end

			local hands = ents.Create( "gmod_hands" )
				if ( IsValid( hands ) ) then
					pl:SetHands( hands )
					hands:SetOwner( pl )

					-- Which hands should we use?
					local cl_playermodel = pl:GetInfo( "cl_playermodel" )
					local info = player_manager.TranslatePlayerHands( cl_playermodel )
					if ( info ) then
						hands:SetModel( info.model )
						hands:SetSkin( info.skin )
						hands:SetBodyGroups( info.body )
					end

					-- Attach them to the viewmodel
					local vm = pl:GetViewModel( 0 )
					hands:AttachToViewmodel( vm )

					vm:DeleteOnRemove( hands )
					pl:DeleteOnRemove( hands )

					hands:Spawn()
				end
	end
	
	// Temporary feature.
	if !PLAYER_IS_CITIZEN then
		if !string.find(game.GetMap(), "d1_trainstation_") then
			if GetConVarString("hl2c_custom_weapon_1") != "" then
				pl:Give(GetConVarString("hl2c_custom_weapon_1"))
			end
				
			if GetConVarString("hl2c_custom_weapon_2") != "" then
				pl:Give(GetConVarString("hl2c_custom_weapon_2"))
			end
				
			if GetConVarString("hl2c_custom_weapon_3") != "" then
				pl:Give(GetConVarString("hl2c_custom_weapon_3"))
			end
			
			if GetConVarString("hl2c_custom_weapon_4") != "" then
				pl:Give(GetConVarString("hl2c_custom_weapon_4"))
			end
			
			if GetConVarString("hl2c_custom_weapon_5") != "" then
				pl:Give(GetConVarString("hl2c_custom_weapon_5"))
			end
		end
	end
end

// Called when a player uses their flashlight
function GM:PlayerSwitchFlashlight(pl, on)
	if pl:Team() != TEAM_ALIVE then
		return false
	end
	
	// Replaced the old Think way of making the flashlight not work when HEV is off.
	if GetConVarNumber("hl2c_classic") >= 1 then
		return true
	elseif GetConVarNumber("hl2c_classic") == 0 then
		if pl:IsSuitEquipped() == false then
			return false
		end
	end
	
	return true
end


// Called when a player uses something
function GM:PlayerUse(pl, ent)
	if (ent:GetName() == "telescope_button" && !game.SinglePlayer()) || pl:Team() != TEAM_ALIVE then
		return false
	end
	
	if (ent:IsVehicle() && pl.abilityScaler) then
		return false
	end
	
	if !game.SinglePlayer() then
		if GetConVarNumber("hl2c_passenger_seats") >= 1 then
			if ent:GetName() == "hl2c_passenger_seat" then
				pl:SetAllowWeaponsInVehicle(true)
			elseif ent:GetName() != "hl2c_passenger_seat" then
				pl:SetAllowWeaponsInVehicle(false)
			end
		end
	end
	
	return true
end


// Called automatically and by the console command
function GM:RestartMap()
	
	if changingLevel then
		return
	end
	
	changingLevel = true
	
	umsg.Start("RestartMap", RecipientFilter():AddAllPlayers())
	umsg.Long(CurTime())
	umsg.End()
	
	for _, pl in pairs(player.GetAll()) do
		if !game.SinglePlayer() then
			pl:SendLua("GAMEMODE.ShowScoreboard = true")
		end
	end
	
	timer.Simple(RESTART_MAP_TIME, function() game.ConsoleCommand( "changelevel "..game.GetMap().."\n") end)
end
concommand.Add("hl2c_restart_map", function(pl, command, arguments) if pl:IsAdmin() then GAMEMODE:RestartMap() end end)


// Admins can respawn all the dead players.
function GM:HL2CForceRespawn()
	table.Empty(deadPlayers)

	for _, pl in pairs(player.GetAll()) do
		if pl:IsValid() && pl:Team() == TEAM_DEAD then
			pl:SetTeam(TEAM_ALIVE)
			pl:UnSpectate()
			pl:Spawn()
			pl:SetNoTarget(false)
		end
	end
end


// Called every time a player does damage to an npc
function GM:ScaleNPCDamage(npc, hitGroup, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	
	// If a friendly/godlike npc do no damage
	if table.HasValue(GODLIKE_NPCS, npc:GetClass()) || (attacker:IsPlayer() && table.HasValue(FRIENDLY_NPCS, npc:GetClass())) then
		dmgInfo:SetDamage(0)
		return
	end
	
	// Fix airboat doing no damage/gravity gun punt should kill NPC's
	if attacker && attacker:IsValid() && attacker:IsPlayer() then
		if attacker:InVehicle() && attacker:GetVehicle() && attacker:GetVehicle():GetClass() == "prop_vehicle_airboat" then
			dmgInfo:SetDamage(1)
		elseif SUPER_GRAVITY_GUN && attacker:GetActiveWeapon() && attacker:GetActiveWeapon():GetClass() == "weapon_physcannon" then
			dmgInfo:SetDamage(100)
		end
	end
	
	// Where are we hitting?
	if hitGroup == HITGROUP_HEAD then
		hitGroupScale = 2
	else
		hitGroupScale = 1
	end
	
	// Calculate the damage
	dmgInfo:ScaleDamage(hitGroupScale / difficulty)
end


// Scale the damage based on being shot in a hitbox 
function GM:ScalePlayerDamage(pl, hitGroup, dmgInfo)
	if hitGroup == HITGROUP_HEAD then
		hitGroupScale = 2
	else
		hitGroupScale = 1
	end
	
	// Calculate the damage
	dmgInfo:ScaleDamage(hitGroupScale * difficulty)
end 


// Called when player presses their help key
function GM:ShowHelp(pl)
	net.Start("ShowHelp")
	net.Send(pl)
end


// Called when a player presses their show team key
function GM:ShowTeam(pl)
	net.Start("ShowTeam")
	net.Send(pl)
end


// Called when player wants a vehicle
function GM:ShowSpare1(pl, pos, range)
	if pl:Team() != TEAM_ALIVE || pl:InVehicle() then
		return
	end
	
	if pl.vehicleAllowed == true && NEW_VEHICLE_SPAWN == true then
		pl:RemoveVehicle()
	elseif NEW_VEHICLE_SPAWN != true then
		pl:RemoveVehicle()
	end
	
	// Spawn the vehicle
	if ALLOWED_VEHICLE then
		local vehicleList = list.Get("Vehicles")
		local vehicle = vehicleList[ALLOWED_VEHICLE]
		
		if !vehicle then
			return
		end
		
		if NEW_VEHICLE_SPAWN == true then
			if pl.vehicleAllowed != true then
				pl:ChatPrint("You're not in a vehicle spawning area!")
				return
			end
		end
		
		// Create the new entity
		pl.vehicle = ents.Create(vehicle.Class)
		pl.vehicle:SetModel(vehicle.Model)
		
		// Set keyvalues
		for a, b in pairs(vehicle.KeyValues) do
			pl.vehicle:SetKeyValue(a, b)
		end
		
		// Enable name on Jeep
		if ALLOWED_VEHICLE == "Named Jeep" then
			pl.vehicle:Fire("addoutput", "targetname jeep")
		end
		
		// Enable name on Airboat
		if ALLOWED_VEHICLE == "Named Airboat" then
			pl.vehicle:Fire("addoutput", "targetname airboat")
		end
		
		// Set pos/angle and spawn
		local plAngle = pl:GetAngles()
		pl.vehicle:SetPos(pl:GetPos() + Vector(0, 0, 48) + plAngle:Forward() * 100)
		pl.vehicle:SetAngles(Angle(0, plAngle.y + 180, 0))
		pl.vehicle:Spawn()
		pl.vehicle:Activate()
		pl.vehicle.creator = pl
		
		// Passenger seats in Singleplayer are useless.
		if !game.SinglePlayer() then
			// Passenger Seats for Jeep
			if GetConVarNumber("hl2c_passenger_seats") >= 1 then
				if ALLOWED_VEHICLE == "Jeep" || ALLOWED_VEHICLE == "Named Jeep" then
					local spawnedvehicle = pl.vehicle
					local seat = ents.Create( "prop_vehicle_prisoner_pod" )
					seat:SetModel( "models/nova/jeep_seat.mdl" )
					seat:SetPos( pl.vehicle:LocalToWorld( Vector( 21,-32,18 ) ) )
					seat:SetAngles( pl.vehicle:LocalToWorldAngles( Angle( 0,-3.5,0 ) ) )
					seat:Spawn()
					seat:SetKeyValue( "limitview", "1" )
					seat:SetKeyValue( "targetname", "hl2c_passenger_seat" )
					seat:SetMoveType( MOVETYPE_NONE )
					seat:SetParent( spawnedvehicle, -1 )
				end
			end
			
			// Passenger Seats for Airboat
			if GetConVarNumber("hl2c_passenger_seats") >= 1 then
				if ALLOWED_VEHICLE == "Airboat" || ALLOWED_VEHICLE == "Named Airboat" || ALLOWED_VEHICLE == "Airboat Gun" then
					local spawnedvehicle2 = pl.vehicle
					local seat2 = ents.Create( "prop_vehicle_prisoner_pod" )
					seat2:SetModel( "models/nova/airboat_seat.mdl" )
					seat2:SetPos( pl.vehicle:LocalToWorld( Vector( 0,-48,68 ) ) )
					seat2:SetAngles( pl.vehicle:LocalToWorldAngles( Angle( 0,0,0 ) ) )
					seat2:Spawn()
					seat2:SetKeyValue( "limitview", "1" )
					seat2:SetKeyValue( "targetname", "hl2c_passenger_seat" )
					seat2:SetMoveType( MOVETYPE_NONE )
					seat2:SetParent( spawnedvehicle2, -1 )
				end
			end
		end
	else
		pl:PrintMessage(HUD_PRINTTALK, "You may not spawn a vehicle at this time.")
	end
end


// Called when player wants to remove their vehicle
function GM:ShowSpare2(pl)
	if pl.vehicleAllowed == true && NEW_VEHICLE_SPAWN == true then	
		pl:ExitVehicle()
		pl:RemoveVehicle()
	elseif NEW_VEHICLE_SPAWN != true then
		pl:ExitVehicle()
		pl:RemoveVehicle()
	end
end


// Called every frame 
function GM:Think()
	if #player.GetAll() > 0 && #team.GetPlayers(TEAM_ALIVE) + #team.GetPlayers(TEAM_COMPLETED_MAP) <= 0 then
		GAMEMODE:RestartMap()
	end
	
	// Holiday is Christmas!
	if (os.date("%m", os.time()) == "12" && os.date("%d", os.time()) >= "20") then
		if GetConVarNumber("hl2c_holiday") != "1" then
			game.ConsoleCommand("hl2c_holiday 1\n")
		end
	else
		if GetConVarNumber("hl2c_holiday") != "0" then
			game.ConsoleCommand("hl2c_holiday 0\n")
		end
	end
	
	// Classic mode never had these commands.
	if GetConVarNumber("hl2c_classic") >= 1 then
		game.ConsoleCommand("hl2c_additions 0\n")
		game.ConsoleCommand("hl2c_allow_respawn 0\n")
		game.ConsoleCommand("hl2c_allow_stunstick 0\n")
		game.ConsoleCommand("hl2c_drop_weapon_on_death 0\n")
		game.ConsoleCommand("hl2c_passenger_seats 0\n")
		game.ConsoleCommand("hl2c_hev_hands 0\n")
		game.ConsoleCommand("hl2c_playermodel_restrictions 1\n")
		game.ConsoleCommand("hl2c_old_nextmap_timer 1\n")
		game.ConsoleCommand("hl2c_use_old_umsg 1\n")
		game.ConsoleCommand("hl2c_ammo_limits 0\n")
		
		NEW_VEHICLE_SPAWN = false
		
		for _, pl in pairs(player.GetAll()) do
			if GetConVarNumber("hl2c_use_old_umsg") >= 1 then
				umsg.Start("ClassicMode", pl)
				umsg.End()
			elseif GetConVarNumber("hl2c_use_old_umsg") == 0 then
				net.Start("ClassicMode")
				net.Send(pl)
			end
		end
	end
	
	if GetConVarNumber("hl2c_classic") == 0 then
		// Is player a citizen?
		for _, pl in pairs(player.GetAll()) do
			if pl:Team() == TEAM_ALIVE && !PLAYER_IS_CITIZEN || pl:Team() == TEAM_ALIVE && PLAYER_IS_CITIZEN != true then
			
				if pl.abilityInvinc && !game.SinglePlayer() then
					pl:SetPlayerColor(Vector(0, 0, 0))
				elseif table.HasValue(BETA_TESTERS, pl:SteamID()) && !game.SinglePlayer() then
					pl:SetPlayerColor(Vector(0.3, 0, 1))
				elseif pl:IsAdmin() && !table.HasValue(BETA_TESTERS, pl:SteamID()) && !game.SinglePlayer() then
					pl:SetPlayerColor(Vector(0, 0.3, 0))
				else
					if (os.date("%m", os.time()) == "12" && os.date("%d", os.time()) >= "20") then
						pl:SetPlayerColor(Vector(1, 0, 0))
					else
						pl:SetPlayerColor(Vector(1, 0.5, 0))
					end
				end
				
				if !pl:IsSuitEquipped() then
					pl:EquipSuit()
				end
				
				if HL1_CAMPAIGN == true then
					GAMEMODE:SetPlayerSpeed(pl, 320, 320)
				end
				
			elseif pl:Team() == TEAM_ALIVE && PLAYER_IS_CITIZEN || pl:Team() == TEAM_ALIVE && PLAYER_IS_CITIZEN != false then
			
				pl:SetPlayerColor(Vector(0, 0.5, 1))
				
				if pl:IsSuitEquipped() then
					pl:RemoveSuit()
				end
				
				if GetConVarNumber("hl2c_classic") == 0 then
					if HL1_CAMPAIGN == false then
						GAMEMODE:SetPlayerSpeed(pl, 140, 140)
					elseif HL1_CAMPAIGN == true then
						GAMEMODE:SetPlayerSpeed(pl, 320, 320)
					end
				end
				
			end
		end
	elseif GetConVarNumber("hl2c_classic") >= 1 then
		// Is player a citizen?
		for _, pl in pairs(player.GetAll()) do
			pl:SetPlayerColor( Vector( 1,0.5,0 ) )
		end
	end
	
	// For each player
	for _, pl in pairs(player.GetAll()) do
		if !pl:Alive() || pl:Team() == TEAM_DEAD then
			return
		end
		
		// Give them weapons they don't have
		for _, pl2 in pairs(player.GetAll()) do
			if pl != pl2 && pl2:Alive() && !pl:InVehicle() && !pl2:InVehicle() && pl2:GetActiveWeapon():IsValid() && !pl:HasWeapon(pl2:GetActiveWeapon():GetClass()) && !table.HasValue(pl.givenWeapons, pl2:GetActiveWeapon():GetClass()) && pl2:GetActiveWeapon():GetClass() != "weapon_physgun" then
				pl:Give(pl2:GetActiveWeapon():GetClass())
				table.insert(pl.givenWeapons, pl2:GetActiveWeapon():GetClass())
			end
		end
		
		// Sprinting and water level
		if GetConVarNumber("hl2c_classic") >= 1 then
		
			if pl.nextEnergyCycle < CurTime() then
				if !pl:InVehicle() && ((pl:GetVelocity():Length() > 315 && pl:KeyDown(IN_SPEED))) then
					pl.energy = pl.energy - 1
				elseif pl:WaterLevel() == 3 && pl.energy > 0 then
					pl.energy = pl.energy - .5
				elseif pl.energy < 100 then
					pl.energy = pl.energy + .5
				end
				
				umsg.Start("UpdateEnergy", pl)
				umsg.Short(pl.energy)
				umsg.End()
				
				pl.nextEnergyCycle = CurTime() + 0.1
			end
		
		elseif GetConVarNumber("hl2c_classic") == 0 then
			
			if pl.nextEnergyCycle < CurTime() then
				if !pl:InVehicle() && ((pl:GetVelocity():Length() > 315 && pl:KeyDown(IN_SPEED))) then
					if PLAYER_IS_CITIZEN != true then
						if HL1_CAMPAIGN != true then
							pl.energy = pl.energy - 1
						end
					end
				elseif pl:WaterLevel() == 3 && pl.energy > 0 then
					pl.energy = pl.energy - .5
				elseif !HL2MP_IS_COOP_MAP && pl:FlashlightIsOn() && pl.energy > 0 then
					pl.energy = pl.energy - .2
				elseif pl.energy < 100 then
					pl.energy = pl.energy + .5
				end
				
				umsg.Start("UpdateEnergy", pl)
				umsg.Short(pl.energy)
				umsg.End()
				
				pl.nextEnergyCycle = CurTime() + 0.1
			end
			
			if pl.abilityCycle < CurTime() then
				if pl.abilityInvis && pl.abilityEnergy > 0 then
					pl.abilityEnergy = pl.abilityEnergy - .35
				elseif pl.abilityInvinc && pl.abilityEnergy > 0 then
					pl.abilityEnergy = pl.abilityEnergy - .65
				elseif pl.abilityScaler && pl.abilityEnergy > 0 then
					pl.abilityEnergy = pl.abilityEnergy - .25
				elseif pl.abilitySuitCharge && pl.abilityEnergy > 0 then
					pl.abilityEnergy = pl.abilityEnergy - .40
					if pl:Armor() < 50 then
						pl:SetArmor(pl:Armor() + 1)
					end
				elseif pl.abilityEnergy < 100 then
					pl.abilityEnergy = pl.abilityEnergy + .2
				end
				
				pl.abilityCycle = CurTime() + 0.1
			end
			
		end
		
		// Now check if they have enough energy 
		if pl.energy < 2 then
			if !pl.sprintDisabled then
				pl.sprintDisabled = true
				GAMEMODE:SetPlayerSpeed(pl, 190, 190)
			end
			
			// Now remove health if underwater
			if pl:WaterLevel() == 3 && pl.nextSetHealth < CurTime() then
				pl.nextSetHealth = CurTime() + 1
				pl:SetHealth(pl:Health() - 10)
				
				if GetConVarNumber("hl2c_use_old_umsg") >= 1 then
					umsg.Start("DrowningEffect", pl)
					umsg.End()
				elseif GetConVarNumber("hl2c_use_old_umsg") == 0 then
					net.Start("DrowningEffect")
					net.Send(pl)
				end
				
				if pl:Alive() && pl:Health() < 1 then
					pl:Kill()
				else
					pl.healthRemoved = pl.healthRemoved + 10
				end
			end				
		elseif pl.energy >= 15 && pl.sprintDisabled then
			pl.sprintDisabled = false
			GAMEMODE:SetPlayerSpeed(pl, 190, 320)
		end
		
		if GetConVarNumber("hl2c_classic") == 0 then
			if !HL2MP_IS_COOP_MAP then
				// Flashlight should run out eventually
				if pl.energy < 2 && !pl.flashlightDisabled then
					pl.flashlightDisabled = true
				elseif pl.energy >= 15 && pl.flashlightDisabled then
					pl.flashlightDisabled = false
				end
				
				// Turn the flashlight off
				if pl.flashlightDisabled && pl:FlashlightIsOn() then
					pl:Flashlight(false)
				end
			end
		end
		
		// Give back health if we can
		if pl:WaterLevel() <= 2 && pl.nextSetHealth < CurTime() && pl.healthRemoved > 0 then
			pl.nextSetHealth = CurTime() + 1
			pl:SetHealth(pl:Health() + 10)
			pl.healthRemoved = pl.healthRemoved - 10
		end
		
		// Check ability energy
		if pl.abilityEnergy < 2 then
			if pl.abilityInvis then
				StopInvisibility(pl)
			end
			
			if pl.abilityInvinc then
				StopInvincibility(pl)
			end
			
			if pl.abilityScaler then
				StopScaler(pl)
			end
			
			if pl.abilitySuitCharge then
				StopSuitRecharge(pl)
			end
		end
		
		// NEW! Ammo check. Players will have default amounts of ammo like in HL2.
		if GetConVarNumber("hl2c_ammo_limits") >= 1 then
			if pl:IsValid() && pl:Alive() && pl:Team() == TEAM_ALIVE then
				if !pl:GetActiveWeapon():IsValid() then return end
			
				if pl:GetActiveWeapon():GetClass() == "weapon_pistol" then
					if pl:GetAmmoCount("pistol") > GetConVarNumber("hl2c_ammo_pistol_max") then
						pl:SetAmmo(GetConVarNumber("hl2c_ammo_pistol_max"), "pistol")
					end
				end
				
				if pl:GetActiveWeapon():GetClass() == "weapon_357" then
					if pl:GetAmmoCount("357") > GetConVarNumber("hl2c_ammo_357_max") then
						pl:SetAmmo(GetConVarNumber("hl2c_ammo_357_max"), "357")
					end
				end
				
				if pl:GetActiveWeapon():GetClass() == "weapon_smg1" then
					if pl:GetAmmoCount("smg1") > GetConVarNumber("hl2c_ammo_smg1_max") then
						pl:SetAmmo(GetConVarNumber("hl2c_ammo_smg1_max"), "smg1")
					end
				end
				
				if pl:GetActiveWeapon():GetClass() == "weapon_smg1" then
					if pl:GetAmmoCount("smg1_grenade") > GetConVarNumber("hl2c_ammo_smg1_grenade_max") then
						pl:SetAmmo(GetConVarNumber("hl2c_ammo_smg1_grenade_max"), "smg1_grenade")
					end
				end
				
				if pl:GetActiveWeapon():GetClass() == "weapon_ar2" then
					if pl:GetAmmoCount("ar2") > GetConVarNumber("hl2c_ammo_ar2_max") then
						pl:SetAmmo(GetConVarNumber("hl2c_ammo_ar2_max"), "ar2")
					end
				end
				
				if pl:GetActiveWeapon():GetClass() == "weapon_ar2" then
					if pl:GetAmmoCount("ar2altfire") > GetConVarNumber("hl2c_ammo_ar2altfire_max") then
						pl:SetAmmo(GetConVarNumber("hl2c_ammo_ar2altfire_max"), "ar2altfire")
					end
				end
				
				if pl:GetActiveWeapon():GetClass() == "weapon_shotgun" then
					if pl:GetAmmoCount("buckshot") > GetConVarNumber("hl2c_ammo_buckshot_max") then
						pl:SetAmmo(GetConVarNumber("hl2c_ammo_buckshot_max"), "buckshot")
					end
				end
				
				if pl:GetActiveWeapon():GetClass() == "weapon_crossbow" then
					if pl:GetAmmoCount("xbowbolt") > GetConVarNumber("hl2c_ammo_xbowbolt_max") then
						pl:SetAmmo(GetConVarNumber("hl2c_ammo_xbowbolt_max"), "xbowbolt")
					end
				end
				
				if pl:GetActiveWeapon():GetClass() == "weapon_rpg" then
					if pl:GetAmmoCount("rpg_round") > GetConVarNumber("hl2c_ammo_rpg_round_max") then
						pl:SetAmmo(GetConVarNumber("hl2c_ammo_rpg_round_max"), "rpg_round")
					end
				end
				
				if pl:GetActiveWeapon():GetClass() == "weapon_slam" then
					if pl:GetAmmoCount("slam") > GetConVarNumber("hl2c_ammo_slam_max") then
						pl:SetAmmo(GetConVarNumber("hl2c_ammo_slam_max"), "slam")
					end
				end
			end
		end
end
	
	// Change the difficulty according to number of players
	difficulty = math.Clamp((#player.GetAll() + 1) / 3, DIFFICULTY_RANGE[1], DIFFICULTY_RANGE[2])
	
	-- // Open area portals -- THIS IS OLD CODE!
	-- if nextAreaOpenTime <= CurTime() then
		-- local portalArea = ents.FindByClass("func_areaportal")
		-- for _, fap in pairs(portalArea) do
			-- fap:Fire("Open")
		-- end
		
		-- nextAreaOpenTime = CurTime() + 3
	-- end
	// Open area portals without regrets and only on multiplayer
	local portalArea = ents.FindByClass("func_areaportal")
	for _, fap in pairs(portalArea) do
		fap:Fire("Open")
	end
end


// Down here is where you can use score points to get abilities
function BuyInvisibility(pl)
	if !pl.abilityInUse then
		if GetConVarNumber("hl2c_classic") >= 1 then
			pl:PrintMessage(HUD_PRINTTALK, "Abilities are disabled in Classic Mode.")
			return
		elseif GetConVarNumber("hl2c_shop_allowed") == 0 then
			pl:PrintMessage(HUD_PRINTTALK, "Shop is disabled.")
			return
		elseif game.SinglePlayer() then
			pl:PrintMessage(HUD_PRINTTALK, "Abilities are disabled in SinglePlayer")
			return
		elseif GetConVarNumber("hl2c_additions") == 0 then
			pl:PrintMessage(HUD_PRINTTALK, "Additions is disabled!")
			return
		elseif PLAYER_IS_CITIZEN == true then
			pl:PrintMessage(HUD_PRINTTALK, "Not allowed!")
			return
		elseif pl:Frags() < 15 then
			pl:PrintMessage(HUD_PRINTTALK, "Not enough Score Points!")
			return
		elseif pl.abilityEnergy < 100 then
			pl:PrintMessage(HUD_PRINTTALK, "Please wait until your Ability Energy is charged.")
			return
		end
		
		pl:SetFrags(pl:Frags() - 15)
		
		pl.abilityInUse = true
		pl.abilityInvis = true
		net.Start("AbilityBought")
			net.WriteString("Invisibility")
		net.Send(pl)
		pl:EmitSound("items/suitchargeok1.wav", 75, 100, 1, CHAN_STATIC)
		GAMEMODE:SetPlayerSpeed(pl, 140, 140)
		pl:SetMaterial("models/spawn_effect")
		pl:SetNoTarget(true)
	elseif pl.abilityInUse then
		pl:PrintMessage(HUD_PRINTTALK, "Ability still in use, please wait.")
	end
end

function StopInvisibility(pl)
	if pl.abilityInUse then
		pl.abilityInUse = false
		pl.abilityInvis = false
		pl:PrintMessage(HUD_PRINTTALK, "Ability wore off.")
		pl:EmitSound("items/suitchargeno1.wav", 75, 100, 1, CHAN_STATIC)
		GAMEMODE:SetPlayerSpeed(pl, 190, 320)
		pl:SetMaterial("")
		pl:SetNoTarget(false)
	end
end
concommand.Add("hl2c_buy_invisibility", function(pl) if (pl && pl:IsValid() && pl:Team() == TEAM_ALIVE) then BuyInvisibility(pl) end end)


function BuyInvincibility(pl)
	if !pl.abilityInUse then
		if GetConVarNumber("hl2c_classic") >= 1 then
			pl:PrintMessage(HUD_PRINTTALK, "Abilities are disabled in Classic Mode.")
			return
		elseif GetConVarNumber("hl2c_shop_allowed") == 0 then
			pl:PrintMessage(HUD_PRINTTALK, "Shop is disabled.")
			return
		elseif game.SinglePlayer() then
			pl:PrintMessage(HUD_PRINTTALK, "Abilities are disabled in SinglePlayer")
			return
		elseif GetConVarNumber("hl2c_additions") == 0 then
			pl:PrintMessage(HUD_PRINTTALK, "Additions is disabled!")
			return
		elseif PLAYER_IS_CITIZEN == true then
			pl:PrintMessage(HUD_PRINTTALK, "Not allowed!")
			return
		elseif pl:Frags() < 30 then
			pl:PrintMessage(HUD_PRINTTALK, "Not enough Score Points!")
			return
		elseif pl.abilityEnergy < 100 then
			pl:PrintMessage(HUD_PRINTTALK, "Please wait until your Ability Energy is charged.")
			return
		end
		
		pl:SetFrags(pl:Frags() - 30)
		
		pl.abilityInUse = true
		pl.abilityInvinc = true
		net.Start("AbilityBought")
			net.WriteString("Invincibility")
		net.Send(pl)
		pl:EmitSound("player/invuln_on_vaccinator.wav", 75, 100, 1, CHAN_STATIC)
		pl:GodEnable()
	elseif pl.abilityInUse then
		pl:PrintMessage(HUD_PRINTTALK, "Ability still in use, please wait.")
	end
end

function StopInvincibility(pl)
	if pl.abilityInUse then
		pl.abilityInUse = false
		pl.abilityInvinc = false
		pl:PrintMessage(HUD_PRINTTALK, "Ability wore off.")
		pl:EmitSound("player/invuln_off_vaccinator.wav", 75, 100, 1, CHAN_STATIC)
		pl:GodDisable()
	end
end
concommand.Add("hl2c_buy_invincibility", function(pl) if (pl && pl:IsValid() && pl:Team() == TEAM_ALIVE) then BuyInvincibility(pl) end end)


function BuyRespawn(pl)
	if GetConVarNumber("hl2c_classic") >= 1 then
		pl:PrintMessage(HUD_PRINTTALK, "Abilities are disabled in Classic Mode.")
		return
	elseif GetConVarNumber("hl2c_shop_allowed") == 0 then
			pl:PrintMessage(HUD_PRINTTALK, "Shop is disabled.")
			return
	elseif game.SinglePlayer() then
		pl:PrintMessage(HUD_PRINTTALK, "Abilities are disabled in SinglePlayer")
		return
	elseif GetConVarNumber("hl2c_additions") == 0 then
		pl:PrintMessage(HUD_PRINTTALK, "Additions is disabled!")
		return
	elseif PLAYER_IS_CITIZEN == true then
		pl:PrintMessage(HUD_PRINTTALK, "Not allowed!")
		return
	elseif pl:Frags() < 25 then
		pl:PrintMessage(HUD_PRINTTALK, "Not enough Score Points!")
		return
	end

	pl:SetFrags(pl:Frags() - 25)

	net.Start("AbilityBought")
		net.WriteString("Respawn")
	net.Send(pl)
	table.RemoveByValue(deadPlayers, pl:UniqueID())
	pl:EmitSound("garrysmod/save_load"..math.random(1, 4)..".wav", 75, 100, 1, CHAN_STATIC)
	
	pl:SetTeam(TEAM_ALIVE)
	pl:UnSpectate()
	pl:Spawn()
	pl:SetNoTarget(false)
	pl:SetPos(pl.deathPosBeta)
end
concommand.Add("hl2c_buy_respawn", function(pl) if (pl && pl:IsValid() && pl:Team() == TEAM_DEAD) then BuyRespawn(pl) end end)


function BuyScaler(pl)
	if !pl.abilityInUse then
		if GetConVarNumber("hl2c_classic") >= 1 then
			pl:PrintMessage(HUD_PRINTTALK, "Abilities are disabled in Classic Mode.")
			return
		elseif GetConVarNumber("hl2c_shop_allowed") == 0 then
			pl:PrintMessage(HUD_PRINTTALK, "Shop is disabled.")
			return
		elseif game.SinglePlayer() then
			pl:PrintMessage(HUD_PRINTTALK, "Abilities are disabled in SinglePlayer")
			return
		elseif GetConVarNumber("hl2c_additions") == 0 then
			pl:PrintMessage(HUD_PRINTTALK, "Additions is disabled!")
			return
		elseif PLAYER_IS_CITIZEN == true then
			pl:PrintMessage(HUD_PRINTTALK, "Not allowed!")
			return
		elseif pl:Frags() < 25 then
			pl:PrintMessage(HUD_PRINTTALK, "Not enough Score Points!")
			return
		elseif pl.abilityEnergy < 100 then
			pl:PrintMessage(HUD_PRINTTALK, "Please wait until your Ability Energy is charged.")
			return
		end
		
		pl:SetFrags(pl:Frags() - 25)
		
		pl.abilityInUse = true
		pl.abilityScaler = true
		if pl:InVehicle() then
			pl:ExitVehicle()
		end
		net.Start("AbilityBought")
			net.WriteString("Smaller Self")
		net.Send(pl)
		pl:EmitSound("vehicles/tank_readyfire1.wav", 75, 100, 1, CHAN_STATIC)
		if (math.random(1, 10) <= 5) then
			pl:SetModelScale(0.3, 1)
			pl.voicePitch = 150
		else
			pl:SetModelScale(1.6, 1)
			pl:PrintMessage(HUD_PRINTTALK, "Whoops, It malfunctioned!")
			pl.voicePitch = 75
		end
	elseif pl.abilityInUse then
		pl:PrintMessage(HUD_PRINTTALK, "Ability still in use, please wait.")
	end
end

function StopScaler(pl)
	if pl.abilityInUse then
		pl.abilityInUse = false
		pl.abilityScaler = false
		pl.voicePitch = 100
		pl:PrintMessage(HUD_PRINTTALK, "Ability wore off.")
		pl:EmitSound("vehicles/tank_turret_stop1.wav", 75, 100, 1, CHAN_STATIC)
		pl:SetModelScale(1, 1)
	end
end
concommand.Add("hl2c_buy_smallform", function(pl) if (pl && pl:IsValid() && pl:Team() == TEAM_ALIVE) then BuyScaler(pl) end end)


function BuySuitRecharge(pl)
	if !pl.abilityInUse then
		if GetConVarNumber("hl2c_classic") >= 1 then
			pl:PrintMessage(HUD_PRINTTALK, "Abilities are disabled in Classic Mode.")
			return
		elseif GetConVarNumber("hl2c_shop_allowed") == 0 then
			pl:PrintMessage(HUD_PRINTTALK, "Shop is disabled.")
			return
		elseif game.SinglePlayer() then
			pl:PrintMessage(HUD_PRINTTALK, "Abilities are disabled in SinglePlayer")
			return
		elseif GetConVarNumber("hl2c_additions") == 0 then
			pl:PrintMessage(HUD_PRINTTALK, "Additions is disabled!")
			return
		elseif PLAYER_IS_CITIZEN == true then
			pl:PrintMessage(HUD_PRINTTALK, "Not allowed!")
			return
		elseif pl:Frags() < 30 then
			pl:PrintMessage(HUD_PRINTTALK, "Not enough Score Points!")
			return
		elseif pl.abilityEnergy < 100 then
			pl:PrintMessage(HUD_PRINTTALK, "Please wait until your Ability Energy is charged.")
			return
		end
		
		pl:SetFrags(pl:Frags() - 30)
		
		pl.abilityInUse = true
		pl.abilitySuitCharge = true
		net.Start("AbilityBought")
			net.WriteString("Suit Recharger")
		net.Send(pl)
		pl:EmitSound("items/battery_pickup.wav", 75, 100, 1, CHAN_STATIC)
	elseif pl.abilityInUse then
		pl:PrintMessage(HUD_PRINTTALK, "Ability still in use, please wait.")
	end
end

function StopSuitRecharge(pl)
	if pl.abilityInUse then
		pl.abilityInUse = false
		pl.abilitySuitCharge = false
		pl:PrintMessage(HUD_PRINTTALK, "Ability wore off.")
	end
end
concommand.Add("hl2c_buy_suitrecharger", function(pl) if (pl && pl:IsValid() && pl:Team() == TEAM_ALIVE) then BuySuitRecharge(pl) end end)


// Player just picked up or was given a weapon
function GM:WeaponEquip(weapon)
	if weapon && weapon:IsValid() && weapon:GetClass() && !table.HasValue(startingWeapons, weapon:GetClass()) then
		table.insert(startingWeapons, weapon:GetClass())
	end
end