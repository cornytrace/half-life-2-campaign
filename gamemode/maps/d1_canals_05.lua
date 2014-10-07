NEXT_MAP = "d1_canals_06"

TRIGGER_CHECKPOINT = {
	{Vector(4096, 1553, -463), Vector(4288, 1593, -352)},
	{Vector(7010, 1533, -448), Vector(7091, 1613, -327), false, function() ALLOWED_VEHICLE = "Airboat" end}
}

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_medkit_hl2c")
end)