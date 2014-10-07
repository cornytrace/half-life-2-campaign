INFO_PLAYER_SPAWN = {Vector(2684, -1865, 260), 90}

NEXT_MAP = "d3_c17_11"

RESPAWN_ALLOWED = true

TRIGGER_CHECKPOINT = {
	{Vector(2562, -995, 257), Vector(2805, -954, 378)},
	{Vector(3529, 869, 512), Vector(3576, 1038, 619)},
	{Vector(2569, 1022, 256), Vector(2609, 1062, 377)}
}

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit_hl2c")
	pl:Give("weapon_frag")
	pl:Give("weapon_357")
	pl:Give("weapon_physcannon")
	pl:Give("weapon_shotgun")
	pl:Give("weapon_ar2")
	pl:Give("weapon_rpg")
	pl:Give("weapon_crossbow")
	pl:Give("weapon_bugbait")
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	aft = ents.Create("ai_goal_follow")
	aft:SetPos(Vector(1065, 353, -631))
	aft:SetKeyValue("targetname", "hl2c_barney_temp_follow")
	aft:SetKeyValue("actor", "barney")
	aft:SetKeyValue("goal", "!player")
	aft:Spawn()
	
	local timer = ents.Create( "logic_timer" )
	timer:SetPos(Vector(1066, 353, -631))
	timer:SetKeyValue( "RefireTime", "5" )
	timer:SetKeyValue( "targetname", "hl2c_timer_follow" )
	timer:SetKeyValue( "StartDisabled", "0" )
	timer:Fire("addoutput", "OnTimer hl2c_barney_temp_follow,Deactivate,,0.0,-1", "1")
	timer:Fire("addoutput", "OnTimer hl2c_barney_temp_follow,Activate,,0.10,-1", "1")
	timer:Spawn()
end)