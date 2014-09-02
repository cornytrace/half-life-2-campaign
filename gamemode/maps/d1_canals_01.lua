NEXT_MAP = "d1_canals_01a"

RESPAWN_ALLOWED = true

TRIGGER_CHECKPOINT = {
	{Vector(136, -4365, 267), Vector(379, -4083, 469)},
	{Vector(824, 2605, -37), Vector(887, 2668, 49)},
	{Vector(704, 2707, -94), Vector(747, 2759, 3)}
}

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_medkit")
end)