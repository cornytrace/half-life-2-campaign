ALLOWED_VEHICLE = "Jeep"

INFO_PLAYER_SPAWN = {Vector(-14200, 12494, 562), 0}

NEXT_MAP = "d2_coast_10"

if file.Exists("hl2c_data/hl2c_d2_coast_08.txt", "DATA") then
	file.Delete("hl2c_data/hl2c_d2_coast_08.txt")
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
	pl:Give("weapon_crossbow")
end)