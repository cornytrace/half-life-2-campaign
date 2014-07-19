NEXT_MAP = "d3_c17_02"

TRIGGER_CHECKPOINT = {
	{Vector(-7050, -1475, 1), Vector(-7003, -1307, 107)},
	{Vector(-6586, -1030, 1), Vector(-6363, -990, 122)}
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