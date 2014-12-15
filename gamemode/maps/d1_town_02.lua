if file.Exists("hl2c_data/hl2c_d1_town_03.txt", "DATA") then
	INFO_PLAYER_SPAWN = {Vector(-3755, -28, -3366), 0}
	NEXT_MAP = "d1_town_02a"
	TRIGGER_CHECKPOINT = {
		{Vector(-5544, 1512, -3254), Vector(-5138, 1723, -2980)}
	}
else
	NEXT_MAP = "d1_town_03"
	TRIGGER_CHECKPOINT = {
		{Vector(-3494, -216, -3584), Vector(-3457, -64, -3477)}
	}
end

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()	
	if !game.SinglePlayer() then

	local aisc1 = ents.FindByName("church_monk_conditions")
	aisc1[1]:Remove()
	
	local aisc_r1 = ents.Create("logic_relay")
	aisc_r1:SetPos(Vector(-4604, 1248, -3016))
	aisc_r1:SetKeyValue("targetname", "relay_church_monk_conditions")
	aisc_r1:Fire("addoutput", "OnTrigger !self,Disable,,0.0,-1")
	aisc_r1:Fire("addoutput", "OnTrigger monk_rock_scene_b1,Start,,0.0,-1")
	aisc_r1:Fire("addoutput", "OnTrigger bldg4_climbnode_link_east,TurnOn,,5.0,-1")
	aisc_r1:Fire("addoutput", "OnTrigger bldg4_climbnode_link_west,TurnOn,,5.0,-1")
	aisc_r1:Spawn()
	aisc_r1:Activate()
	
	local door = ents.FindByName("buildingD_roofhatch")
	door[1]:Fire("addoutput", "OnOpen relay_church_monk_conditions,Trigger,,3.0,-1")
	
	end
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit_hl2c")
	pl:Give("weapon_frag")
	pl:Give("weapon_357")
	pl:Give("weapon_physcannon")
	if file.Exists("hl2c_data/hl2c_d1_town_03.txt", "DATA") then
		pl:Give("weapon_shotgun")
	end
end)