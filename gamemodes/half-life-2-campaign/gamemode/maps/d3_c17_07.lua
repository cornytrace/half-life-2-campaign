INFO_PLAYER_SPAWN = {Vector(4435, 1211, 291), 0}

NEXT_MAP = "d3_c17_08"

TRIGGER_CHECKPOINT = {
	{Vector(7284, 1410, -3), Vector(7341, 1663, 157)}
}

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit")
	pl:Give("weapon_frag")
	pl:Give("weapon_357")
	pl:Give("weapon_physcannon")
	pl:Give("weapon_shotgun")
	pl:Give("weapon_ar2")
	pl:Give("weapon_rpg")
	pl:Give("weapon_crossbow")
	pl:Give("weapon_bugbait")
end)