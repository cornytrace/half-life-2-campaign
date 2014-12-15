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
	local barney_npc = ents.Create("npc_barney")
	barney_npc:SetPos(Vector(2696, -1944, 293))
	barney_npc:SetKeyValue("additionalequipment", "weapon_ar2")
	barney_npc:SetKeyValue("targetname", "barney")
	barney_npc:SetKeyValue("spawnflags", "0")
	barney_npc:SetKeyValue("angles", "0 90 0")
	barney_npc:Spawn()
	barney_npc:Activate()
	
	if !game.SinglePlayer() then
	
	local timer = ents.Create("logic_timer")
	timer:SetPos(Vector(1066, 353, -631))
	timer:SetKeyValue("RefireTime", "5")
	timer:SetKeyValue("targetname", "hl2c_timer_follow")
	timer:SetKeyValue("StartDisabled", "0")
	timer:Fire("addoutput", "OnTimer barney_follow,Deactivate,,0,-1", "1")
	timer:Fire("addoutput", "OnTimer barney_follow,Activate,,0.1,-1", "1")
	timer:Spawn()
	
	local aisc_pod = ents.FindByName("citizen_pod_conditions")
	aisc_pod[1]:Remove()
	
	local detected = ents.FindByName("s_room_detected_relay")
	detected[1]:Fire("addoutput", "OnTrigger s_room_turret_*,Disable,,7,1")
	detected[1]:Fire("addoutput", "OnTrigger s_room_doors,Open,,7,1")
	
	local lcs_lead_exit = ents.FindByName("barney_lead_exit_lcs2")
	lcs_lead_exit[1]:Fire("addoutput", "OnCompletion hl2c_timer_follow,Disable,,0,-1")
	lcs_lead_exit[1]:Fire("addoutput", "OnCompletion barney_follow,Deactivate,,0.1,-1")
	
	local lcs_h4x = ents.FindByName("lcs_barney_h4x")
	lcs_h4x[1]:Fire("addoutput", "OnCompletion hl2c_timer_follow,Enable,,0.5,-1")
	
	local lcs_h4x_pows = ents.FindByName("lcs_barney_h4x_pows")
	lcs_h4x_pows[1]:Fire("addoutput", "OnCompletion hl2c_timer_follow,Enable,,0.2,-1")
	
	end
end)