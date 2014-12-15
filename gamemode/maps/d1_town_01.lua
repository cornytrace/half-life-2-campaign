NEXT_MAP = "d1_town_01a"

if file.Exists("hl2c_data/hl2c_hl1_easteregg1.txt", "DATA") then
	file.Delete("hl2c_data/hl2c_hl1_easteregg1.txt")
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
end)