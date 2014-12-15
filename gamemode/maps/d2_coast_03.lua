ALLOWED_VEHICLE = "Jeep"

NEXT_MAP = "d2_coast_04"
EXTRA_MAP = "c1a1"

NEW_VEHICLE_SPAWN = true

TRIGGER_VEHICLESPAWN = {
	{Vector(-6681, -16101, 1033), Vector(-7159, -12726, 1044)}
}

TRIGGER_CHECKPOINT = {
	{Vector(8724, 3990, 265), Vector(8855, 4132, 365)}
}

hook.Add("EntityRemoved", "hl2cEntityRemoved", function(ent)
	if ent:GetName() == "hl2c_easteregg" then
		for _, pl in pairs(player.GetAll()) do
			pl:EmitSound("music/radio1.mp3", 75, 100, 1, CHAN_STATIC)
		end
	end
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local wep = ents.Create("weapon_rpg")
	wep:SetPos(Vector(8513, 4299, 270))
	wep:Spawn()
	wep:Activate()
	
	local zoom = ents.FindByName("telescope_zoom")
	zoom[1]:Remove()

	local filter = ents.FindByName("jeep_filter")
	filter[1]:Remove()
	
	-- Here is something that is called in Multiplayer. It fixes things that Multiplayer bugs with.
	if !game.SinglePlayer() then
		local aisc_gtr = ents.FindByName("aisc_gordontakesrpg")
		aisc_gtr[1]:Remove()
		
		local rs0 = ents.FindByName("rocketman_scene_0")
		rs0[1]:Fire("addoutput", "OnTrigger1 aisc_gordontakesrpg_relay,Trigger,,5.0,-1", "5")
		
		local ssp3 = ents.FindByName("ss_post3")
		ssp3[1]:Fire("addoutput", "OnBeginSequence aisc_odessaportgunship_relay,Trigger,,5.0,-1", "5")
		
		local aisc_gtr_r = ents.Create("logic_relay")
		aisc_gtr_r:SetPos(Vector(8556, 4242, 302))
		aisc_gtr_r:SetKeyValue("targetname", "aisc_gordontakesrpg_relay")
		aisc_gtr_r:Fire("addoutput", "OnTrigger !self,Disable,,0.0,-1", "5")
		aisc_gtr_r:Fire("addoutput", "OnTrigger aisc_odessaportgunship,Kill,,0.0,-1", "5")
		aisc_gtr_r:Fire("addoutput", "OnTrigger citizen_a_precmbt_*,Kill,,0.0,-1", "5")
		aisc_gtr_r:Fire("addoutput", "OnTrigger player_leaves_house,Enable,,0.0,-1", "5")
		aisc_gtr_r:Fire("addoutput", "OnTrigger rocketman_scene_0,Resume,,0.0,-1", "5")
		aisc_gtr_r:Fire("addoutput", "OnTrigger spawner_rpg,ForceSpawn,,0.0,-1", "5")
		aisc_gtr_r:Fire("addoutput", "OnTrigger pd_rpg,Kill,,0.0,-1", "5")
		aisc_gtr_r:Spawn()
		aisc_gtr_r:Activate()
		
		local aisc_opg_r = ents.Create("logic_relay")
		aisc_opg_r:SetPos(Vector(8437, 4462, 275))
		aisc_opg_r:SetKeyValue("targetname", "aisc_odessaportgunship_relay")
		aisc_opg_r:Fire("addoutput", "OnTrigger !self,Disable,,0.0,-1", "5")
		aisc_opg_r:Fire("addoutput", "OnTrigger aisc_odessaportgunshipignored,Kill,,0.0,-1", "5")
		aisc_opg_r:Fire("addoutput", "OnTrigger aisc_odessaportgunshipignored_relay,Trigger,,20.0,-1", "5")
		aisc_opg_r:Fire("addoutput", "OnTrigger tm_gatekeeper,ForceSpawn,,0.0,-1", "5")
		aisc_opg_r:Fire("addoutput", "OnTrigger aisc_odessaportgunship_relay,Kill,,0.0,-1", "5")
		aisc_opg_r:Fire("addoutput", "OnTrigger rocketman_gunship1,Resume,,0.0,-1", "5")
		aisc_opg_r:Fire("addoutput", "OnTrigger ss_odessa_radio,CancelSequence,,0.0,-1", "5")
		aisc_opg_r:Fire("addoutput", "OnTrigger post_gunship_jeep_relay,Kill,,0.0,-1", "5")
		aisc_opg_r:Spawn()
		aisc_opg_r:Activate()
		
		local aisc_opgi_r = ents.Create("logic_relay")
		aisc_opgi_r:SetPos(Vector(8437, 4462, 275))
		aisc_opgi_r:SetKeyValue("targetname", "aisc_odessaportgunshipignored_relay")
		aisc_opgi_r:Fire("addoutput", "OnTrigger !self,Disable,,0.0,-1", "5")
		aisc_opgi_r:Fire("addoutput", "OnTrigger odessa_goodbye,Cancel,,0.0,-1", "5")
		aisc_opgi_r:Fire("addoutput", "OnTrigger odessa_getyourcar,Cancel,,0.0,-1", "5")
		aisc_opgi_r:Fire("addoutput", "OnTrigger vort_goodbye,Cancel,,0.0,-1", "5")
		aisc_opgi_r:Fire("addoutput", "OnTrigger lr_odessa_getyourcar,Trigger,,0.5,-1", "5")
		aisc_opgi_r:Fire("addoutput", "OnTrigger lr_odessa_goodbye,Trigger,,1.0,-1", "5")
		aisc_opgi_r:Fire("addoutput", "OnTrigger lr_vort_goodbye,Trigger,,1.5,-1", "5")
		aisc_opgi_r:Spawn()
		aisc_opgi_r:Activate()
		
		if (IsMounted("hl1") && !game.IsDedicated(true)) then
			if GetConVarNumber("hl2c_additions") >= 1 then
				local change2 = ents.Create("point_changelevel_extra")
				change2:SetPos(Vector(-183, 855, -2446))
				change2:SetKeyValue("targetname", "hl2c_changelevel_extra")
				change2:Spawn()
				change2:Activate()
				
				local photo = ents.Create("prop_physics_override")
				photo:SetPos(Vector(8641, 4587, 301))
				photo:SetKeyValue("targetname", "hl2c_easteregg")
				photo:SetKeyValue("angles", "0 180 0")
				photo:SetKeyValue("spawnflags", "8448")
				photo:SetKeyValue("health", "1")
				photo:SetKeyValue("model", "models/props_lab/frame002a.mdl")
				photo:Spawn()
				photo:Activate()
				photo:Fire("addoutput", "OnPlayerPickup hl2c_changelevel_extra,Changelevel,,6.0,-1", "1.0")
				photo:Fire("addoutput", "OnPlayerPickup hl2c_shake,StartShake,,0.0,-1", "1.0")
				photo:Fire("addoutput", "OnPlayerPickup hl2c_fade,Fade,,0.0,-1", "1.0")
				photo:Fire("addoutput", "OnPlayerPickup hl2c_easteregg,Kill,,0.5,-1", "1.0")
				
				local sound = ents.Create("env_shake")
				sound:SetPos(Vector(-189, 736, -2487))
				sound:SetKeyValue("targetname", "hl2c_shake")
				sound:SetKeyValue("amplitude", "16")
				sound:SetKeyValue("duration", "40")
				sound:SetKeyValue("frequency", "255.0")
				sound:SetKeyValue("spawnflags", "29")
				sound:Spawn()
				sound:Activate()
				
				local fade1 = ents.Create("env_fade")
				fade1:SetPos(Vector(-184, 855, -2446))
				fade1:SetKeyValue("targetname", "hl2c_fade")
				fade1:SetKeyValue("duration", "4")
				fade1:SetKeyValue("spawnflags", "8")
				fade1:SetKeyValue("rendercolor", "255 255 255")
				fade1:Spawn()
				fade1:Activate()
			end
		end
	end
end)

hook.Add("EntityRemoved", "hl2cEntityRemoved", function(ent)
	if ent:GetName() == "aisc_odessaportgunship_relay" then
		NEW_VEHICLE_SPAWN = false
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
	pl:Give("weapon_shotgun")
	pl:Give("weapon_ar2")
end)