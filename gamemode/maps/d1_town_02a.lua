NEXT_MAP = "d1_town_04"

TRIGGER_CHECKPOINT = {
	{Vector(-7564, -286, -3408), Vector(-7461, -157, -3279)}
}

if file.Exists("hl2c_data/hl2c_d1_town_03.txt", "DATA") then
	file.Delete("hl2c_data/hl2c_d1_town_03.txt")
end

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit")
	pl:Give("weapon_frag")
	pl:Give("weapon_357")
	pl:Give("weapon_physcannon")
	pl:Give("weapon_shotgun")
end)