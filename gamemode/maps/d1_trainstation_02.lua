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
end)