NEXT_MAP = "d2_prison_07"

TRIGGER_CHECKPOINT = {
	{Vector(1415, 595, -192), Vector(1456, 757, -31)}
	-- {Vector(413, 76, 0), Vector(453, 157, 121)},
	-- {Vector(271, -211, 0), Vector(352, -171, 121)},
	-- {Vector(476, -996, 0), Vector(516, -875, 121)}
}

-- TRIGGER_DELAYMAPLOAD = {Vector(399, 412, 19), Vector(225, 274, 139)}

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
	aft:SetKeyValue("targetname", "hl2c_alyx_temp_follow")
	aft:SetKeyValue("actor", "alyx")
	aft:SetKeyValue("goal", "!player")
	aft:Spawn()
	
	local timer = ents.Create( "logic_timer" )
	timer:SetPos(Vector(1066, 353, -631))
	timer:SetKeyValue( "RefireTime", "5" )
	timer:SetKeyValue( "targetname", "hl2c_timer_follow" )
	timer:SetKeyValue( "StartDisabled", "1" )
	timer:Fire("addoutput", "OnTimer hl2c_alyx_temp_follow,Deactivate,,0.0,-1", "1")
	timer:Fire("addoutput", "OnTimer hl2c_alyx_temp_follow,Activate,,0.10,-1", "1")
	timer:Spawn()

	local meetup = ents.FindByName("lcs_np_meetup02")
	meetup[1]:Fire("addoutput", "OnCompletion hl2c_timer_follow,Enable,,0,1", "3.0")
	meetup[1]:Fire("addoutput", "OnCompletion alyx,StopScripting,,5.0,1", "15.0")
	
	local ele_drs = ents.FindByName("introom_elevator_doors_1")
	for _, dr in pairs(ele_drs) do
		dr:Fire("addoutput", "OnClose hl2c_timer_follow,Disable,,0,-1")
		dr:Fire("addoutput", "OnClose hl2c_alyx_temp_follow,Disable,,0.5,-1")
	end
	
	local emp = ents.FindByName("logic_alyx_EMP_1")
	emp[1]:Fire("addoutput", "OnTrigger hl2c_timer_follow,Enable,,3,-1")
	
	local trig = ents.FindByName("Trigger_start_eli_scene_1")
	trig[1]:Fire("addoutput", "OnTrigger hl2c_timer_follow,Disable,,0,-1")
	trig[1]:Fire("addoutput", "OnTrigger hl2c_alyx_temp_follow,Disable,,0.5,-1")
	
	local reunion = ents.FindByName("logic_start_reunion")
	reunion[1]:Fire("addoutput", "OnTrigger hl2c_changelevel,Changelevel,,1,-1")
	
	local change = ents.Create("point_changelevel")
	change:SetPos(Vector(-183, 855, -2446))
	change:SetKeyValue("targetname", "hl2c_changelevel")
	change:Spawn()
	change:Activate()
end)