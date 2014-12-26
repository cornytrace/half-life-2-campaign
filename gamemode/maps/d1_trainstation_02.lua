INFO_PLAYER_SPAWN = {Vector(-4257, -179, -61), -95}

NEXT_MAP = "d1_trainstation_03"

PLAYER_IS_CITIZEN = true

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	if (GetConVarNumber("hl2c_additions") >= 1) && (math.random(1, 10) == 1) && (!game.SinglePlayer()) then

		-- Easter Egg!
		local breen_lcs = ents.FindByName("lcs_tv_breencast")
		breen_lcs[1]:Remove()
		
		local breen_ss = ents.FindByName("ss_breencast")
		breen_ss[1]:Remove()
		
		local breen_npc = ents.FindByName("Breen")
		breen_npc[1]:Remove()
		
		local logic_breen = ents.FindByName("logic_breen_*")
		for _, logic in pairs(logic_breen) do
			logic:Remove()
		end
		
		local logic_tv_turnon = ents.FindByName("logic_tv_turnonallscreens")
		for _, logic in pairs(logic_tv_turnon) do
			logic:Fire("Trigger")
		end
		
		local combineslate = ents.FindByName("brush_breen_combineslate")
		combineslate[1]:Fire("Disable")
		
		-- GMan time!
		local spark01 = ents.Create("env_spark")
		spark01:SetPos(Vector(-3765, -2615, 427))
		spark01:SetKeyValue("targetname", "hl2c_sparks")
		spark01:SetKeyValue("Magnitude", "8")
		spark01:SetKeyValue("MaxDelay", "3")
		spark01:SetKeyValue("TrailLength", "3")
		spark01:Spawn()
		spark01:Activate()
		
		local food_trigger = ents.FindByName("trigger_start_food_queue")
		food_trigger[1]:Fire("addoutput", "OnStartTouch ss_gmanmystery,BeginSequence,,2,-1")
		
		local gman_ss = ents.Create("scripted_sequence")
		gman_ss:SetPos(Vector(888, 7560, -233))
		gman_ss:SetKeyValue("m_fMoveTo", "0")
		gman_ss:SetKeyValue("m_iszEntity", "GMan")
		gman_ss:SetKeyValue("m_iszPostIdle", "idle")
		gman_ss:SetKeyValue("m_iszPlay", "tiefidget")
		gman_ss:SetKeyValue("spawnflags", "480")
		gman_ss:SetKeyValue("targetname", "ss_gmanmystery")
		gman_ss:Spawn()
		gman_ss:Activate()
		gman_ss:Fire("addoutput", "OnEndSequence logic_tv_turnoffallscreens,Trigger,,0.5,-1", "1.0")
		gman_ss:Fire("addoutput", "OnEndSequence hl2c_sparks,sparkonce,,0.5,-1", "1.0")
		gman_ss:Fire("addoutput", "OnEndSequence GMan,Kill,,0.6,-1", "1.0")
		gman_ss:Fire("addoutput", "OnEndSequence brush_breen_combineslate,Enable,,0.6,-1", "1.0")
		
		local gman_npc = ents.Create("npc_gman")
		gman_npc:SetPos(Vector(912, 7698, -283))
		gman_npc:SetKeyValue("angles", "0 270 0")
		gman_npc:SetKeyValue("disableshadows", "1")
		gman_npc:SetKeyValue("targetname", "GMan")
		gman_npc:SetKeyValue("spawnflags", "0")
		gman_npc:Spawn()
		gman_npc:Activate()
	
	end
	
	-- Festive!
	if (os.date("%m", os.time()) == "12" && os.date("%d", os.time()) >= "20") then
	
		if GetConVarNumber("hl2c_additions") >= 1 then
	
		local text1 = ents.Create("game_text")
		text1:SetPos(Vector(1163, -32, -135))
		text1:SetKeyValue("spawnflags", "1")
		text1:SetKeyValue("targetname", "hl2c_christmas_text")
		text1:SetKeyValue("color", "0 255 0")
		text1:SetKeyValue("color2", "0 255 0")
		text1:SetKeyValue("fadein", "0.5")
		text1:SetKeyValue("holdtime", "6.2")
		text1:SetKeyValue("message", "Merry Christmas!")
		text1:SetKeyValue("y", "0.2")
		text1:SetKeyValue("x", "-1")
		text1:Spawn()
		text1:Activate()
	
		local christmas_ss = ents.Create("scripted_sequence")
		christmas_ss:SetPos(Vector(-1944, -1670, 69))
		christmas_ss:SetKeyValue("m_fMoveTo", "0")
		christmas_ss:SetKeyValue("m_iszEntity", "hl2c_christmas_citizen1")
		christmas_ss:SetKeyValue("m_iszPostIdle", "Wave_SMG1")
		christmas_ss:SetKeyValue("m_iszPlay", "Wave_SMG1")
		christmas_ss:SetKeyValue("spawnflags", "480")
		christmas_ss:SetKeyValue("targetname", "hl2c_christmas_sequence1")
		christmas_ss:Spawn()
		christmas_ss:Activate()
		christmas_ss:Fire("BeginSequence", "", "15.0")
		
		local christmas_ss = ents.Create("scripted_sequence")
		christmas_ss:SetPos(Vector(-1943, -1670, 69))
		christmas_ss:SetKeyValue("m_fMoveTo", "0")
		christmas_ss:SetKeyValue("m_iszEntity", "hl2c_christmas_citizen2")
		christmas_ss:SetKeyValue("m_iszPostIdle", "Wave_SMG1")
		christmas_ss:SetKeyValue("m_iszPlay", "Wave_SMG1")
		christmas_ss:SetKeyValue("spawnflags", "480")
		christmas_ss:SetKeyValue("targetname", "hl2c_christmas_sequence2")
		christmas_ss:Spawn()
		christmas_ss:Activate()
		christmas_ss:Fire("BeginSequence", "", "15.0")
	
		local christmas_citizen1 = ents.Create("npc_citizen")
		christmas_citizen1:SetPos(Vector(-2008, -1707, 69))
		christmas_citizen1:SetKeyValue("targetname", "hl2c_christmas_citizen1")
		christmas_citizen1:SetKeyValue("angles", "0 230 0")
		christmas_citizen1:SetKeyValue("model", "models/humans/group01/male_06.mdl")
		christmas_citizen1:SetKeyValue("spawnflags", "1073804")
		christmas_citizen1:Spawn()
		christmas_citizen1:Activate()
		christmas_citizen1:Fire("addoutput", "OnHearPlayer hl2c_christmas_text,Display,,0.0,-1")
		
		local christmas_citizen2 = ents.Create("npc_citizen")
		christmas_citizen2:SetPos(Vector(-2000, -1888, 69))
		christmas_citizen2:SetKeyValue("targetname", "hl2c_christmas_citizen2")
		christmas_citizen2:SetKeyValue("angles", "0 140 0")
		christmas_citizen2:SetKeyValue("model", "models/humans/group01/female_04.mdl")
		christmas_citizen2:SetKeyValue("spawnflags", "1073804")
		christmas_citizen2:Spawn()
		christmas_citizen2:Activate()
		christmas_citizen2:Fire("addoutput", "OnHearPlayer hl2c_christmas_text,Display,,0.0,-1")
		
		end
		
	end
	
end)