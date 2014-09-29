// Send the required resources to the client
resource.AddFile("materials/hl2c_nav_marker.vmt")
resource.AddFile("materials/hl2c_nav_marker.vtf")
resource.AddFile("materials/hl2c_nav_pointer.vmt")
resource.AddFile("materials/hl2c_nav_pointer.vtf")


// Send the required lua files to the client
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("cl_scoreboard_playerlist.lua")
AddCSLuaFile("cl_scoreboard_playerrow.lua")
AddCSLuaFile("sh_config.lua")
AddCSLuaFile("sh_init.lua")
AddCSLuaFile("sh_player.lua")
AddCSLuaFile("player_class/player_coop.lua")


// Include the required lua files
include("sh_init.lua")

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

if !ConVarExists("hl2c_0102_shine") then
	CreateConVar("hl2c_0102_shine", "0", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Make 0102 a cubemap material. 0 by default.")
end

if !ConVarExists("hl2c_bot_spectate") then
	CreateConVar("hl2c_bot_spectate", "1", { FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE }, "Bots are useless, lets get rid of them.")
end

// Precache all the player models ahead of time
for _, playerModel in pairs(PLAYER_MODELS) do
	util.PrecacheModel(playerModel)
end


// Called when the player attempts to suicide
function GM:CanPlayerSuicide(pl)
	if pl:Team() == TEAM_COMPLETED_MAP then
		pl:ChatPrint("You cannot suicide once you've completed the map.")
		return false
	elseif pl:Team() == TEAM_DEAD then
		pl:ChatPrint("This may come as a suprise, but you are already dead.")
		return false
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

// Called when the player dies
function GM:DoPlayerDeath(pl, attacker, dmgInfo)
	pl.deathPos = pl:EyePos()
	
	if RESPAWN_ALLOWED != true then
		// Add to deadPlayers table to prevent respawning on re-connect
		if !table.HasValue(deadPlayers, pl:UniqueID()) then
			table.insert(deadPlayers, pl:UniqueID())
		end
	end
	
	pl:RemoveVehicle()
	pl:Flashlight(false)
	pl:CreateRagdoll()
	if RESPAWN_ALLOWED != true then
		pl:SetTeam(TEAM_DEAD)
	end
	pl:AddDeaths(1)
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

// Added these here because they were undefined!
deadPlayers = {}
difficulty = 1
changingLevel = false
checkpointPositions = {}
nextAreaOpenTime = 0
startingWeapons = {}
isRestartingMap = false

// Called immediately after starting the gamemode  
function GM:Initialize()
	deadPlayers = {}
	difficulty = 1
	changingLevel = false
	checkpointPositions = {}
	nextAreaOpenTime = 0
	startingWeapons = {}
	isRestartingMap = false
	
	// We want regular fall damage and the ai to attack players and stuff
	game.ConsoleCommand("ai_disabled 0\n")
	game.ConsoleCommand("ai_ignoreplayers 0\n")
	game.ConsoleCommand("hl2_episodic 0\n")
	game.ConsoleCommand("mp_falldamage 1\n")
	game.ConsoleCommand("physgun_limited 1\n")
	game.ConsoleCommand("ai_serverragdolls 0\n")
	if string.find(game.GetMap(), "ep1_") || string.find(game.GetMap(), "ep2_") then
		game.ConsoleCommand("hl2_episodic 1\n")
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
	
	umsg.Start("SetCheckpointPosition", RecipientFilter():AddAllPlayers())
	umsg.Vector(checkpointPositions[#checkpointPositions])
	umsg.End()
	
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
	
	// Fix the env_global entities
	if !string.find(game.GetMap(), "d1_trainstation_") && !game.SinglePlayer() then
		local envG1 = ents.Create("env_global")
		envG1:SetPos(Vector(150, -100, 150))
		envG1:SetKeyValue("targetname", "hl2c_gordon_criminal_global")
		envG1:SetKeyValue("globalstate", "gordon_precriminal")
		envG1:SetKeyValue("spawnflags", "1")
		envG1:SetKeyValue("initialstate", "0")
		envG1:Spawn()
		envG1:Activate()
		envG1:Fire("turnoff", "", "1.0")
		
		local envG2 = ents.Create("env_global")
		envG2:SetPos(Vector(-150, 100, -150))
		envG2:SetKeyValue("targetname", "hl2c_gordon_invulnerable_global")
		envG2:SetKeyValue("globalstate", "gordon_invulnerable")
		envG2:SetKeyValue("spawnflags", "1")
		envG2:SetKeyValue("initialstate", "0")
		envG2:Spawn()
		envG2:Activate()
		envG2:Fire("turnoff", "", "1.0")
	end
	
	// NEW! Custom Weapon spawning.
	// It gets boring having to re-do all the map.lua files so people spawn with custom weapons, lets do something to fix that..
	if !string.find(game.GetMap(), "d1_trainstation_") then
		if file.Exists("hl2c_custom/hl2c_custom_weapons.lua", "LUA") then
			include("hl2c_custom/hl2c_custom_weapons.lua")
		end
	end
	
	if !game.SinglePlayer() then
		// Remove fall_trigger triggers which cause the game to "end"
		local triggerMultiples = ents.FindByName("fall_trigger")
		for _, falltrigger in pairs(triggerMultiples) do
			falltrigger:Remove()
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
	
	timer.Simple(NEXT_MAP_TIME, GAMEMODE.GrabAndSwitch)
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
			game.ConsoleCommand("kickid "..killer:UserID().." \"Killed an important NPC actor!\"\n")
			GAMEMODE:RestartMapDueToNPCDeath()
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
	
	// Send a message
 	if killer && killer != NULL && killer:IsPlayer() then 
 		umsg.Start("PlayerKilledNPC") 
 		umsg.String(npc:GetClass()) 
 		umsg.String(weaponClass) 
 		umsg.Entity(killer) 
 		umsg.End() 
 	end
end


// Called when a player tries to pickup a weapon
function GM:PlayerCanPickupWeapon(pl, weapon) 
	if pl:Team() != TEAM_ALIVE || weapon:GetClass() == "weapon_stunstick" || (weapon:GetClass() == "weapon_physgun" && !pl:IsAdmin()) then
		weapon:Remove()
		return false
	end
	
	if game.SinglePlayer() && weapon:GetClass() == "weapon_medkit" then -- Medkits are stupid in Singleplayer.
		weapon:Remove()
		return false
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
	
	// If a player joined, print a message.
	PrintMessage(HUD_PRINTTALK, pl:Nick() .." has joined the game.")
	
	// If respawn is allowed, print a message.
	if RESPAWN_ALLOWED then
		pl:ChatPrint("You're allowed to respawn in this map.")
	end
	
	// If vehicles are allowed, print a message.
	if ALLOWED_VEHICLE then
		pl:ChatPrint("Press F3 to spawn a vehicle.")
	end
	
	// CUSTOM COLLISION CHECK FOR PLAYERS SO YOU CANNOT COLLIDE WITH EACH OTHER OR FRIENDLY NPCS
	pl:SetCustomCollisionCheck(true)
	
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
	
	if GetConVarNumber("hl2c_0102_shine") == 1 || GetConVarNumber("hl2c_0102_shine") >= 1 then
		if pl:SteamID() == "STEAM_0:0:49332102" then
			pl:SetMaterial("debug/env_cubemap_model") -- This makes 0102 a cubemap tester
		end
	end
	
	// Set current checkpoint
	umsg.Start("PlayerInitialSpawn", pl)
	umsg.Vector(checkpointPositions[1])
	umsg.End()
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
	
	// Lastly give physgun to admins
	if GetConVarNumber("hl2c_admin_physgun") == 1 && pl:IsAdmin() then
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
	local spawnPoints = ents.FindByClass("info_player_start")
	return spawnPoints[#spawnPoints]
end 


// Set the player model
function GM:PlayerSetModel(pl)
	if pl.info && pl.info.model then
		pl.modelName = pl.info.model
	else
		local modelName = player_manager.TranslatePlayerModel(pl:GetInfo("cl_playermodel"))
		
		if GetConVarNumber("hl2c_playermodel_restrictions") == 1 then
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
	pl.vulnerable = true
	timer.Simple(VULNERABLE_TIME, function(pl) if pl && pl:IsValid() then pl.vulnerable = true end end, pl)
	
	// Speed, loadout, and model
	GAMEMODE:SetPlayerSpeed(pl, 190, 320)
	GAMEMODE:PlayerSetModel(pl)
	GAMEMODE:PlayerLoadout(pl)
	
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
		pl:PrintMessage(HUD_PRINTTALK, "You may not respawn until the next map. Nice try though.")
		
		pl.deathPos = pl:EyePos()
		
		pl:RemoveVehicle()
		pl:Flashlight(false)
		pl:SetTeam(TEAM_DEAD)
		pl:AddDeaths(1)
		
		pl:KillSilent()
	end

	if GetConVarNumber("hl2c_hev_hands") == 1 then
		pl:SetupHands()
	elseif GetConVarNumber("hl2c_hev_hands") != 1 then
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
	
end

// Called when a player uses their flashlight
function GM:PlayerSwitchFlashlight(pl, on)
	if pl:Team() != TEAM_ALIVE then
		return false
	end
	
	return true
end


// Called when a player uses something
function GM:PlayerUse(pl, ent)
	if (ent:GetName() == "telescope_button" && !game.SinglePlayer()) || pl:Team() != TEAM_ALIVE then
		return false
	end
	
	if !game.SinglePlayer() then
		if GetConVarNumber("hl2c_passenger_seats") == 1 || GetConVarNumber("hl2c_passenger_seats") >= 1 then
			if ent:GetName() == "hl2c_passenger_seat" then
				if GetConVarNumber("hl2c_passenger_seats_weapons") == 1 || GetConVarNumber("hl2c_passenger_seats_weapons") >= 1 then
					pl:SetAllowWeaponsInVehicle(true)
				elseif GetConVarNumber("hl2c_passenger_seats_weapons") == 0 then
					pl:SetAllowWeaponsInVehicle(false)
				end
			elseif ent:GetName() != "hl2c_passenger_seat" then
				pl:SetAllowWeaponsInVehicle(false)
			end
		end
	end
	
	return true
end


// Called automatically and by the console command
function GM:RestartMap()
	isRestartingMap = true
	
	if changingLevel then
		return
	end
	
	changingLevel = true
	
	umsg.Start("RestartMap", RecipientFilter():AddAllPlayers())
	umsg.Long(CurTime())
	umsg.End()
	
	for _, pl in pairs(player.GetAll()) do
		pl:SendLua("GAMEMODE.ShowScoreboard = true")
	end
	
	timer.Simple(RESTART_MAP_TIME, function() game.ConsoleCommand( "changelevel "..game.GetMap().."\n") end)
end
concommand.Add("hl2c_restart_map", function(pl, command, arguments) if pl:IsAdmin() then GAMEMODE:RestartMap() end end)


function GM:ExecuteRespawn()
	table.Empty(deadPlayers)

	for _, pl in pairs(player.GetAll()) do
		if pl:Team() == TEAM_DEAD then
			pl:SetTeam(TEAM_ALIVE)
			pl:UnSpectate()
			pl:KillSilent()
			pl:AddDeaths(-1)
			pl:Spawn()
			pl:SetNoTarget(false)
		end
	end
	
	isRestartingMap = false
end


// Called automatically
function GM:RestartMapDueToNPCDeath()
	isRestartingMap = true
	
	if changingLevel then
		return
	end
	
	changingLevel = true
	
	umsg.Start("RestartMap", RecipientFilter():AddAllPlayers())
	umsg.Long(CurTime())
	umsg.End()
	
	for _, pl in pairs(player.GetAll()) do
		pl:SendLua("GAMEMODE.ShowScoreboard = true")
		pl:ChatPrint("An important NPC actor died!")
	end
	
	timer.Simple(RESTART_MAP_TIME, function() game.ConsoleCommand( "changelevel "..game.GetMap().."\n") end)
end


// 0102 is a good chap sometimes
function GM:HL2CForceRespawn()
	table.Empty(deadPlayers)

	for _, pl in pairs(player.GetAll()) do
		if pl:Team() == TEAM_DEAD then
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
	umsg.Start("ShowHelp", pl)
	umsg.End()
end


// Called when a player presses their show team key
function GM:ShowTeam(pl)
	umsg.Start("ShowTeam", pl)
	umsg.End()
end


// Called when player wants a vehicle
function GM:ShowSpare1(pl, pos, range)
	if pl:Team() != TEAM_ALIVE || pl:InVehicle() then
		return
	end
	
	pl:RemoveVehicle()
	
	// Spawn the vehicle
	if ALLOWED_VEHICLE then
		local vehicleList = list.Get("Vehicles")
		local vehicle = vehicleList[ALLOWED_VEHICLE]
		
		if !vehicle then
			return
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
			if GetConVarNumber("hl2c_passenger_seats") == 1 || GetConVarNumber("hl2c_passenger_seats") >= 1 then
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
			if GetConVarNumber("hl2c_passenger_seats") == 1 || GetConVarNumber("hl2c_passenger_seats") >= 1 then
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
	pl:ExitVehicle()
	pl:RemoveVehicle()
end


// Called every frame 
function GM:Think()
	if isRestartingMap == false then
		if #player.GetAll() > 0 && #team.GetPlayers(TEAM_ALIVE) + #team.GetPlayers(TEAM_COMPLETED_MAP) <= 0 then
			GAMEMODE:RestartMap()
		end
	end
	
	// Is player a citizen?
	for _, pl in pairs(player.GetAll()) do
		if pl:Team() == TEAM_ALIVE && !PLAYER_IS_CITIZEN || pl:Team() == TEAM_ALIVE && PLAYER_IS_CITIZEN != true then	
			pl:SetPlayerColor( Vector( 1,0.5,0 ) )
			pl:EquipSuit()
		elseif pl:Team() == TEAM_ALIVE && PLAYER_IS_CITIZEN || pl:Team() == TEAM_ALIVE && PLAYER_IS_CITIZEN != false then
			pl:SetPlayerColor( Vector( 0,0.5,1 ) )
			pl:RemoveSuit()
		end
	end
	
	// For each player
	for _, pl in pairs(player.GetAll()) do
		if !pl:Alive() || pl:Team() != TEAM_ALIVE then
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
		if pl.nextEnergyCycle < CurTime() then
			if !pl:InVehicle() && ((pl:GetVelocity():Length() > 315 && pl:KeyDown(IN_SPEED))) then
				pl.energy = pl.energy - 1
			elseif pl:WaterLevel() == 3 && pl.energy > 0 then
				pl.energy = pl.energy - .5
			elseif pl:FlashlightIsOn() && pl.energy > 0 then
				pl.energy = pl.energy - .2
			elseif pl.energy < 100 then
				pl.energy = pl.energy + .5
			end
			
			umsg.Start("UpdateEnergy", pl)
			umsg.Short(pl.energy)
			umsg.End()
			
			pl.nextEnergyCycle = CurTime() + 0.1
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
				
				umsg.Start("DrowningEffect", pl)
				umsg.End()
				
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
		
		// Flashlight should run out eventually
		if pl.energy < 2 && pl:FlashlightIsOn() && !pl.flashlightDisabled then
			pl.flashlightDisabled = true
		elseif pl.energy >= 30 && pl.flashlightDisabled then
			pl.flashlightDisabled = false
		end
		
		// If the player is a citizen, that means the HEV suit isn't on, so we should turn the flashlight off
		if pl:FlashlightIsOn() && PLAYER_IS_CITIZEN == true then
			pl:Flashlight(false)
		end
		
		// Turn the flashlight off
		if pl.flashlightDisabled && pl:FlashlightIsOn() then
			pl:Flashlight(false)
		end
		
		// Give back health if we can
		if pl:WaterLevel() <= 2 && pl.nextSetHealth < CurTime() && pl.healthRemoved > 0 then
			pl.nextSetHealth = CurTime() + 1
			pl:SetHealth(pl:Health() + 10)
			pl.healthRemoved = pl.healthRemoved - 10
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
	if !game.SinglePlayer() then
		local portalArea = ents.FindByClass("func_areaportal")
		for _, fap in pairs(portalArea) do
			fap:Fire("Open")
		end
	end
end


// Player just picked up or was given a weapon
function GM:WeaponEquip(weapon)
	if weapon && weapon:IsValid() && weapon:GetClass() && !table.HasValue(startingWeapons, weapon:GetClass()) then
		table.insert(startingWeapons, weapon:GetClass())
	end
end