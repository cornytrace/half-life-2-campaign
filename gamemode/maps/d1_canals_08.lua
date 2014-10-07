ALLOWED_VEHICLE = "Airboat"

INFO_PLAYER_SPAWN = {Vector(7512, -11398, -438), 0}

NEXT_MAP = "d1_canals_09"

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit_hl2c")
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local doors_close = ents.FindByName("trigger_close_gates")
	doors_close[1]:Remove()
end)