INFO_PLAYER_SPAWN = {Vector(2895, -2262, -636), 90}

NEXT_MAP = "d1_canals_03"

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_medkit_hl2c")
end)