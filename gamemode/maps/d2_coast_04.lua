ALLOWED_VEHICLE = "Named Jeep"

NEXT_MAP = "d2_coast_05"
EXTRA_MAP = "d2_lostcoast"

if file.Exists("hl2c_data/hl2c_hl1_easteregg2.txt", "DATA") then
	file.Delete("hl2c_data/hl2c_hl1_easteregg2.txt")
	RESET_PL_INFO = true
end

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
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local push = ents.FindByName("push_car_superjump_01")
	push[1]:Fire("addoutput", "StartDisabled 0", "0")

	local push_timer = ents.Create( "logic_timer" )
	push_timer:SetPos( Vector( -2033, 738, 909 ) )
	push_timer:SetKeyValue( "RefireTime", "3" )
	push_timer:SetKeyValue( "targetname", "hl2c_push_timer" )
	push_timer:Fire("addoutput", "OnTimer push_car_superjump_01,Enable,,0.00,-1", "0")
	push_timer:Spawn()
	
	if (IsMounted("lostcoast") && !game.IsDedicated(true)) then
		if GetConVarNumber("hl2c_additions") >= 1 then
			local change2 = ents.Create("point_changelevel_extra")
			change2:SetPos(Vector(-183, 855, -2446))
			change2:SetKeyValue("targetname", "hl2c_changelevel_extra")
			change2:Spawn()
			change2:Activate()
			
			local photo = ents.Create("prop_physics_override")
			photo:SetPos(Vector(-4242, -135, 9))
			photo:SetKeyValue("targetname", "hl2c_easteregg")
			photo:SetKeyValue("angles", "0 180 0")
			photo:SetKeyValue("spawnflags", "8448")
			photo:SetKeyValue("health", "1")
			photo:SetKeyValue("model", "models/props_canal/boat001a.mdl")
			photo:Spawn()
			photo:Activate()
			photo:Fire("addoutput", "OnBreak hl2c_changelevel_extra,Changelevel,,6.0,-1", "1.0")
			photo:Fire("addoutput", "OnBreak hl2c_shake,StartShake,,0.0,-1", "1.0")
			photo:Fire("addoutput", "OnBreak hl2c_fade,Fade,,0.0,-1", "1.0")
			photo:Fire("addoutput", "OnBreak hl2c_easteregg,Kill,,0.5,-1", "1.0")
			
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