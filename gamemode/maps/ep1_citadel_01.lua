NEXT_MAP = "ep1_citadel_02"

TRIGGER_CHECKPOINT = {
	{Vector(-4924, 3137, 2592), Vector(-4803, 3177, 2713)}
}

TRIGGER_DELAYMAPLOAD = {Vector(-2973, 1382, 2473), Vector(-3036, 1285, 2612)}

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
	
	local clip_roller = ents.FindByName("clip_rollerdoor")
	clip_roller[1]:Remove()
	
	local rollerdoor = ents.FindByName("door_rollertraining")
	rollerdoor[1]:Remove()
	
	local math_roller = ents.FindByName("math_bringroller")
	math_roller[1]:Fire("addoutput", "OnHitMax clip_combineshieldwall6,Kill,,0.0,1", "1")
	
	local droprollers = ents.FindByName("trigger_droprollers")
	droprollers[1]:Fire("addoutput", "OnPressed trigger_player_holdmine,Enable,,0.0,-1", "1")
	droprollers[1]:Fire("addoutput", "OnPressed trigger_roller_holdmine,Enable,,0.0,-1", "1")
	droprollers[1]:Fire("addoutput", "OnPressed clip_combineshieldwall4,Kill,,0.0,-1", "1")
	droprollers[1]:Fire("addoutput", "OnPressed brush_combineshieldwall4,Kill,,0.0,-1", "1")
	droprollers[1]:Fire("addoutput", "OnPressed math_bringroller,Enable,,0.0,-1", "1")
	
	local c_v = ents.FindByName("trigger_cancel_vista_1")
	c_v[1]:Fire("addoutput", "OnTrigger trigger_player_holdmine,Disable,,1.0,-1", "1")
	c_v[1]:Fire("addoutput", "OnTrigger trigger_roller_holdmine,Disable,,1.0,-1", "1")
	c_v[1]:Fire("addoutput", "OnTrigger math_bringroller,Disable,,1.0,-1", "1")
	
	local script = ents.FindByName("asc_looklightbridge")
	script[1]:Remove()
	
	local ss = ents.FindByName("ss_stalker_railing_jump")
	ss[1]:Fire("addoutput", "OnEndSequence soldier_assault1_relay,Trigger,,5.0,-1", "1")
end)