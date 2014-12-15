INFO_PLAYER_SPAWN = {Vector(1668, 352, -324), 44}

TRIGGER_DELAYMAPLOAD = {Vector(969, 718, -75), Vector(969, 718, -75)}

NEXT_MAP = "d1_town_01"

if !file.Exists("hl2c_data/hl2c_hl1_easteregg1.txt", "DATA") then
	file.Write("hl2c_data/hl2c_hl1_easteregg1.txt", "We've seen the Easter Egg 1.")
end

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()	
	local change = ents.Create("point_changelevel")
	change:SetPos(Vector(1211, -7, -135))
	change:SetKeyValue("targetname", "hl2c_changelevel")
	change:Spawn()
	change:Activate()
	
	local text1 = ents.Create("game_text")
	text1:SetPos(Vector(1163, -32, -135))
	text1:SetKeyValue("spawnflags", "1")
	text1:SetKeyValue("targetname", "hl2c_text_end")
	text1:SetKeyValue("color", "255 255 255")
	text1:SetKeyValue("color2", "255 255 255")
	text1:SetKeyValue("holdtime", "6.2")
	text1:SetKeyValue("message", "Half-Life: Source")
	text1:SetKeyValue("y", "0.2")
	text1:SetKeyValue("x", "-1")
	text1:Spawn()
	text1:Activate()
	
	local text2 = ents.Create("game_text")
	text2:SetPos(Vector(1152, -64, -135))
	text2:SetKeyValue("spawnflags", "1")
	text2:SetKeyValue("targetname", "hl2c_text_end")
	text2:SetKeyValue("channel", "2")
	text2:SetKeyValue("color", "0 255 0")
	text2:SetKeyValue("color2", "0 255 0")
	text2:SetKeyValue("fadein", "2.5")
	text2:SetKeyValue("holdtime", "6.2")
	text2:SetKeyValue("message", "IN TESTING!")
	text2:SetKeyValue("y", "0.3")
	text2:SetKeyValue("x", "-1")
	text2:Spawn()
	text2:Activate()
	
	local timer = ents.Create("logic_timer")
	timer:SetPos(Vector(-111, -742, 28))
	timer:SetKeyValue("RefireTime", "6")
	timer:Fire("addoutput", "OnTimer ele_2,Toggle,,0.0,-1", "0.0")
	timer:Spawn()
	timer:Activate()
	
	local but = ents.FindByName("elebutton1")
	for _, button in pairs(but) do
		button:Remove()
	end
	
	local fade1 = ents.Create("env_fade")
	fade1:SetPos(Vector(-184, 855, -2446))
	fade1:SetKeyValue("targetname", "hl2c_fade")
	fade1:SetKeyValue("duration", "4")
	fade1:SetKeyValue("spawnflags", "8")
	fade1:SetKeyValue("rendercolor", "255 255 255")
	fade1:Spawn()
	fade1:Activate()
	
	local trigger = ents.FindByName("trigger_for_retinal")
	trigger[1]:Fire("addoutput", "OnStartTouch hl2c_changelevel,Changelevel,,16.0,-1", "0.0")
	trigger[1]:Fire("addoutput", "OnStartTouch hl2c_fade,Fade,,10.0,-1", "0.0")
	trigger[1]:Fire("addoutput", "OnStartTouch hl2c_text_end,Display,,3.0,-1", "0.0")
end)