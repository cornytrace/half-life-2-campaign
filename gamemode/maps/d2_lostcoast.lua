INFO_PLAYER_SPAWN = {Vector(1436, 2288, -4), 130}

TRIGGER_DELAYMAPLOAD = {Vector(1096, 3033, 2680), Vector(1096, 3033, 2680)}

TRIGGER_CHECKPOINT = {
	{Vector(1528, 4086, 2697), Vector(1429, 4016, 2807)}
}

RESET_PL_INFO = true

NEXT_MAP = "d2_coast_05"

if !file.Exists("hl2c_data/hl2c_hl2lc.txt", "DATA") then
	file.Write("hl2c_data/hl2c_hl2lc.txt", "We've seen the Easter Egg LC.")
end

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	-- Remove start equipment
	local stufft = ents.FindByName("template_spawnequipment")
	stufft[1]:Remove()
	
	local stuff = ents.FindByName("start_equipment")
	for _, stf in pairs(stuff) do
		stf:Remove()
	end

	-- Garry's Mod has problems loading scenes, fix it.
	local ss1 = ents.FindByName("ss_Fisherman_OpenGate")
	ss1[1]:Fire("addoutput", "OnBeginSequence relay_DropHarpoon,Trigger,,0.5,-1")
	ss1[1]:Fire("addoutput", "OnEndSequence ss_Fisherman_SitDown,BeginSequence,,0.0,-1")
	ss1[1]:Fire("BeginSequence", "", "20.0")
	
	-- Old one has the disconnect function, remove it.
	local lsc_old = ents.FindByName("lsc_fisherman_outro1")
	for _, lscold in pairs(lsc_old) do
		lscold:Remove()
	end
	
	-- Remove the command entities.
	local cmdent1 = ents.FindByName("command")
	cmdent1[1]:Remove()
	
	local cmdent2 = ents.FindByName("clientcommand")
	cmdent2[1]:Remove()
	
	-- Replace the command entity with a point_changelevel
	local change = ents.Create("point_changelevel")
	change:SetPos(Vector(-1995, -1909, -34))
	change:SetKeyValue("targetname", "hl2c_changelevel")
	change:Spawn()
	change:Activate()

	-- New one removes the disconnect call.
	local lsc = ents.Create("logic_choreographed_scene")
	lsc:SetPos(Vector(-1936, -1888, -11))
	lsc:SetKeyValue("ResumeSceneFile", "TLK_RESUME")
	lsc:SetKeyValue("onplayerdeath", "0")
	lsc:SetKeyValue("busyactor", "1")
	lsc:SetKeyValue("SceneFile", "scenes/lostcoast/fisherman_outro1.vcd")
	lsc:SetKeyValue("target1", "fisherman")
	lsc:SetKeyValue("targetname", "lsc_fisherman_outro1")
	lsc:Fire("addoutput", "OnCompletion fade_outro,Fade,,0.0,-1")
	lsc:Fire("addoutput", "OnCompletion lsc_fisherman_outro2,Start,,0.0,-1")
	lsc:Fire("addoutput", "OnCompletion hl2c_changelevel,Changelevel,,10.0,-1")
	lsc:Spawn()
	lsc:Activate()
	
	-- Remove fall triggers
	local fall1 = ents.FindByName("trigger_clifffall")
	local fall2 = ents.FindByName("trigger_clifffall_detector")
	
	for _, fall in pairs(fall1) do
		fall:Remove()
	end
	for _, fall in pairs(fall2) do
		fall:Remove()
	end
	
	-- Courtyard door is just annoying, close it when players enter the monastery.
	local timer1 = ents.Create("logic_timer")
	timer1:SetPos(Vector(1827, 4759, 2593))
	timer1:SetKeyValue("RefireTime", "1")
	timer1:SetKeyValue("targetname", "hl2c_timer")
	timer1:Fire("addoutput", "OnTimer door_courtyard,Unlock,,0.0,-1")
	timer1:Fire("addoutput", "OnTimer door_courtyard,Open,,0.1,-1")
	timer1:Spawn()
	timer1:Activate()
	
	local mdr = ents.FindByName("doors_monastery")
	mdr[1]:Fire("addoutput", "OnFullyClosed hl2c_timer,Kill,,0.0,-1")
	mdr[1]:Fire("addoutput", "OnFullyClosed door_courtyard,Close,,0.1,-1")
	mdr[1]:Fire("addoutput", "OnFullyClosed door_courtyard,Lock,,0.2,-1")
	
	-- Remove/Fix useless entities
	local tele1 = ents.FindByName("trigger_knockout_teleport")
	tele1[1]:Remove()
	
	local pvc = ents.FindByName("blackout_viewcontroller")
	pvc[1]:Remove()
	
	local dest1 = ents.FindByName("destination_knockout_1")
	dest1[1]:Remove()
	
	local blkout = ents.FindByName("blackout")
	blkout[1]:Remove()
	
	local brush = ents.FindByName("brush_rearwall_playerclip")
	brush[1]:Remove()
	
	local platform = ents.FindByName("platform_X_axis")
	for _, plat in pairs(platform) do
		plat:Fire("DisableMotion")
	end
	
	local trg1 = ents.FindByName("relay_begin_door_ambush")
	trg1[1]:Fire("addoutput", "OnTrigger relay_bustfrontdoor,Trigger,,15.0,-1")
	trg1[1]:Fire("addoutput", "OnTrigger relay_bustbackdoor,Trigger,,18.0,-1")
	
	-- Teleport players to here when the platform starts moving
	local telepl = ents.Create("point_hl2cteleport")
	telepl:SetPos(Vector(1106, 2949, 2550))
	telepl:SetKeyValue("targetname", "hl2c_teleport")
	telepl:Spawn()
	telepl:Activate()
	
	local outro = ents.FindByName("trigger_scafoldingsave")
	outro[1]:Fire("addoutput", "OnTrigger hl2c_teleport,Teleport,,0.0,-1")
	outro[1]:Fire("addoutput", "OnTrigger fade_outro,Fade,,0.0,-1")
	outro[1]:Fire("addoutput", "OnTrigger hl2c_changelevel,Changelevel,,10.0,-1")
	outro[1]:Fire("addoutput", "OnTrigger player,SetParent,platform_X_axis,1.0,-1")
	outro[1]:Fire("addoutput", "OnTrigger platform_X_axis,EnableMotion,,1.0,-1")
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_physcannon")
	pl:Give("weapon_pistol")
	pl:Give("weapon_357")
	pl:Give("weapon_shotgun")
	pl:Give("weapon_crossbow")
	pl:Give("weapon_rpg")
end)