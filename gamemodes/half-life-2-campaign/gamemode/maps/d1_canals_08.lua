ALLOWED_VEHICLE = "Airboat"

INFO_PLAYER_SPAWN = {Vector(7512, -11398, -438), 0}

NEXT_MAP = "d1_canals_09"

TRIGGER_CHECKPOINT = {
	{Vector(-2931, -4529, -640), Vector(-2890, -3723, -237)}
}

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit")
end)