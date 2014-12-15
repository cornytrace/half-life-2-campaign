NEXT_MAP = "d1_town_01"
EXTRA_MAP = "t0a0"

TRIGGER_CHECKPOINT = {
	{Vector(-684, 845, -2688), Vector(-501, 886, -2567)},
	{Vector(-706, 1212, -2688), Vector(-524, 1253, -2567)},
	{Vector(-1939, 1833, -2736), Vector(-1897, 2001, -2629)}
}

hook.Add("EntityRemoved", "hl2cEntityRemoved", function(ent)
	if ent:GetName() == "hl2c_easteregg" then
		for _, pl in pairs(player.GetAll()) do
			pl:EmitSound("music/radio1.mp3", 75, 100, 1, CHAN_STATIC)
		end
	end
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local wep = ents.Create("weapon_physcannon")
	wep:SetPos(Vector(-473, 814, -2590))
	wep:Spawn()
	wep:Activate()
	
	if (IsMounted("hl1") && !game.IsDedicated(true)) then
		if GetConVarNumber("hl2c_additions") >= 1 then
			local change2 = ents.Create("point_changelevel_extra")
			change2:SetPos(Vector(-183, 855, -2446))
			change2:SetKeyValue("targetname", "hl2c_changelevel_extra")
			change2:Spawn()
			change2:Activate()
			
			local photo = ents.Create("prop_physics_override")
			photo:SetPos(Vector(-2381, -421, -2679))
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
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit_hl2c")
	pl:Give("weapon_frag")
	pl:Give("weapon_357")
end)