if file.Exists("hl2c_data/hl2c_hl1_c1a0c.txt", "DATA") then
	INFO_PLAYER_SPAWN = {Vector(-975, 1414, -2699), 180}
	
	if !file.Exists("hl2c_data/hl2c_hl1_easteregg2.txt", "DATA") then
		file.Write("hl2c_data/hl2c_hl1_easteregg2.txt", "We've seen the Easter Egg 2.")
	end
	
	BRUSH_PLAYERCLIP = {
	{Vector(-1145, 976, -2732), Vector(-1319, 895, -2612)}
	}
	
	NEXT_MAP = "c1a2"
	EXTRA_MAP = "d2_coast_04"
	LAST_MAP = "c1a1d"
else
	INFO_PLAYER_SPAWN = {Vector(-88, -3331, -219), 270}
	
	TRIGGER_CHECKPOINT = {
	{Vector(-136, -1319, -2727), Vector(-216, -1145, -2615)}
	}
	
	NEXT_MAP = "c1a1d"
	LAST_MAP = "c1a1b"
end

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()	
	for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
		if tcl.map == LAST_MAP then			
			local tclMin, tclMax = tcl:WorldSpaceAABB()
			GAMEMODE:CreatePC(tclMin, tclMax)
		end
		tcl:Remove()
	end
	
	for _, mbrn in pairs(ents.FindByClass("monster_barnacle")) do			
		mbrn:Remove()
	end
	
	local tele = ents.Create("point_hl2cteleport")
	tele:SetPos(Vector(544, -3208, -192))
	tele:SetKeyValue("targetname", "hl2c_teleport")
	tele:Spawn()
	tele:Activate()
	
	local lever = ents.FindByName("lift_lever")
	lever[1]:Fire("addoutput", "OnPressed hl2c_teleport,Teleport,,0.0,-1", "0.0")
	
	if file.Exists("hl2c_data/hl2c_hl1_c1a0c.txt", "DATA") then
		local change = ents.Create("point_changelevel_extra")
		change:SetPos(Vector(1211, -7, -135))
		change:SetKeyValue("targetname", "hl2c_changelevel_extra")
		change:Spawn()
		change:Activate()
		
		local text1 = ents.Create("game_text")
		text1:SetPos(Vector(1163, -32, -135))
		text1:SetKeyValue("spawnflags", "1")
		text1:SetKeyValue("targetname", "hl2c_text_end")
		text1:SetKeyValue("color", "255 255 255")
		text1:SetKeyValue("color2", "255 255 255")
		text1:SetKeyValue("fadein", "2.5")
		text1:SetKeyValue("holdtime", "6.2")
		text1:SetKeyValue("message", "Rise and shine...")
		text1:SetKeyValue("y", "0.2")
		text1:SetKeyValue("x", "-1")
		text1:Spawn()
		text1:Activate()
		
		local fade1 = ents.Create("env_fade")
		fade1:SetPos(Vector(-184, 855, -2446))
		fade1:SetKeyValue("targetname", "hl2c_fade")
		fade1:SetKeyValue("duration", "4")
		fade1:SetKeyValue("spawnflags", "8")
		fade1:SetKeyValue("rendercolor", "0 0 0")
		fade1:Spawn()
		fade1:Activate()
		
		local button = ents.FindByName("elebutton1")
		button[1]:Fire("addoutput", "OnPressed hl2c_changelevel_extra,Changelevel,,10.0,-1", "0.0")
		button[1]:Fire("addoutput", "OnPressed hl2c_fade,Fade,,0.0,-1", "0.0")
		button[1]:Fire("addoutput", "OnPressed hl2c_text_end,Display,,2.0,-1", "0.0")
		
		file.Delete("hl2c_data/hl2c_hl1_c1a0c.txt")
	end
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_pistol")
	pl:Give("weapon_crowbar")
end)