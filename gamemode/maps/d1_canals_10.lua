INFO_PLAYER_SPAWN = {Vector(11904, -12312, -476), 90}

ALLOWED_VEHICLE = "Airboat"

NEXT_MAP = "d1_canals_11"

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit_hl2c")
end)