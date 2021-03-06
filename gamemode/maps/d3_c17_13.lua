INFO_PLAYER_SPAWN = {Vector(4935, -2887, 4), 90}

NEXT_MAP = "d3_citadel_01"

NEXT_MAP_TIME = 0

TRIGGER_CHECKPOINT = {
	{Vector(8328, 1202, -412), Vector(8450, 1242, -292)}
}

TRIGGER_DELAYMAPLOAD = {Vector(4997, 265, 270), Vector(5187, 295, 357)}

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
	pl:Give("weapon_bugbait")
end)