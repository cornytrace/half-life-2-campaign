INFO_PLAYER_SPAWN = {Vector(3460, 14056, 3642), 270}

NEXT_MAP = "ep1_c17_00"

TRIGGER_CHECKPOINT = {
	{Vector(3288, 13434, 3609), Vector(3599, 13300, 3746)},
	{Vector(3320, 11840, 3609), Vector(3444, 11673, 3725)},
	{Vector(3807, 10756, 3513), Vector(3833, 10788, 5577)},
	{Vector(3801, 8003, 3585), Vector(3853, 7978, 3685)}
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
end)