INFO_PLAYER_SPAWN = {Vector(-43, 12173, 5349), 0}

NEXT_MAP = "ep1_citadel_04"

SUPER_GRAVITY_GUN = true

TRIGGER_DELAYMAPLOAD = {Vector(2001, 13362, 5325), Vector(1940, 13270, 5431)}

TRIGGER_CHECKPOINT = {
	{Vector(1316, 11889, 5321), Vector(1073, 11734, 5431)},
	{Vector(1430, 11826, 5317), Vector(1572, 11617, 5434)},
	{Vector(1629, 11661, 4233), Vector(1735, 11831, 4403)}
}

BRUSH_PLAYERCLIP = {
	{Vector(3085, 12465, 4729), Vector(2940, 12635, 4734)}
}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	aft = ents.Create("ai_goal_follow")
	aft:SetPos(Vector(1065, 353, -631))
	aft:SetKeyValue("targetname", "hl2c_alyx_temp_follow")
	aft:SetKeyValue("actor", "alyx")
	aft:SetKeyValue("goal", "!player")
	aft:SetKeyValue("Formation", "6")
	aft:Spawn()
	
	local timer = ents.Create( "logic_timer" )
	timer:SetPos(Vector(1066, 353, -631))
	timer:SetKeyValue( "RefireTime", "5" )
	timer:SetKeyValue( "targetname", "hl2c_timer_follow" )
	timer:SetKeyValue( "StartDisabled", "0" )
	timer:Fire("addoutput", "OnTimer hl2c_alyx_temp_follow,Deactivate,,0.0,-1", "1")
	timer:Fire("addoutput", "OnTimer hl2c_alyx_temp_follow,Activate,,0.10,-1", "1")
	timer:Spawn()
	
	local stalker = ents.FindByName("core_stalker")
	stalker[1]:Remove()
	stalker[2]:Remove()
	
	local clip = ents.FindByName("Core_lift_doors")
	clip[1]:Remove()
	clip[2]:Remove()
	
	local doors = ents.FindByName("trigger_closedoors")
	doors[1]:Fire("addoutput", "OnTrigger pclip_core_elevator_1,Enable,,0.0,-1", "0.0")
	
	local closed = ents.FindByName("core_airlock_close")
	closed[1]:Remove()
	
	local door = ents.FindByName("door_comb_2_1")
	door[1]:Fire("addoutput", "OnFullyOpen pclip_core_elevator_1,Enable,,0.0,-1", "0.0")
	door[1]:Fire("addoutput", "OnFullyOpen counter_balltrap_bridge_1,Add,2,0.0,-1", "0.0")
	door[1]:Fire("addoutput", "OnFullyOpen counter_balltrap_bridge_2,Add,2,0.0,-1", "0.0")
	door[1]:Fire("addoutput", "OnFullyOpen counter_balltrap_bridge_3,Add,2,0.0,-1", "0.0")
	
	local scene = ents.FindByName("lcs_core_control_scene")
	scene[1]:Fire("addoutput", "OnTrigger7 pclip_core_elevator_1,Disable,,0.0,-1", "0.0")
end)