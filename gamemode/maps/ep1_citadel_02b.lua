INFO_PLAYER_SPAWN = {Vector(1896, 4320, 2533), 351}

NEXT_MAP = "ep1_citadel_03"

SUPER_GRAVITY_GUN = true

TRIGGER_DELAYMAPLOAD = {Vector(3970, 4541, -6711), Vector(3997, 4767, -6565)}

TRIGGER_CHECKPOINT = {
	{Vector(3131, 4695, 2517), Vector(3387, 4592, 2644)}
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
	
	local timer2 = ents.Create( "logic_timer" )
	timer2:SetPos(Vector(1067, 354, -630))
	timer2:SetKeyValue( "RefireTime", "0.1" )
	timer2:SetKeyValue( "targetname", "hl2c_timer_enable" )
	timer2:SetKeyValue( "StartDisabled", "0" )
	timer2:Fire("addoutput", "OnTimer enable_impact_trigger,Enable,,0.0,-1", "1")
	timer2:Fire("addoutput", "OnTimer enable_impact_trigger,ClearParent,,0.0,-1", "1")
	timer2:Spawn()
	
	local impact = ents.FindByName("enable_impact_trigger")
	impact[1]:Fire("addoutput", "OnTrigger !activator,Kill,,0.0,-1", "1")
	
	local console = ents.FindByName("ballconsole6_monitor")
	console[1]:Remove()
	
	local console2 = ents.FindByName("ballconsole8_console")
	console2[1]:Remove()
	
	local lift_path = ents.FindByName("citadel_path_lift01_13")
	lift_path[1]:Fire("addoutput", "OnPass citadel_train_lift01_1,SetSpeed,50,5.0,-1", "1")
	lift_path[1]:Fire("addoutput", "OnPass citadel_train_lift01_1,SetSpeed,50,7.0,-1", "1")
end)