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

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit")
	pl:Give("weapon_frag")
	pl:Give("weapon_357")
	pl:Give("weapon_physcannon")
	if file.Exists("hl2c_d1_town_03.txt", "DATA") then
		pl:Give("weapon_shotgun")
	end
end)