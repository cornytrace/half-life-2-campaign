INFO_PLAYER_SPAWN = {Vector(4158, -4447, 1082), 0}

NEXT_MAP = "d2_prison_02"

TRIGGER_CHECKPOINT = {
	{Vector(1057, -1599, 1600), Vector(1104, -1397, 1707)}
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