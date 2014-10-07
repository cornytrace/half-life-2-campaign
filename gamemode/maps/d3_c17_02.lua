NEXT_MAP = "d3_c17_03"

TRIGGER_CHECKPOINT = {
	{Vector(-5552, -5706, -4), Vector(-5505, -5537, 103)}
}

TRIGGER_DELAYMAPLOAD = {Vector(-5203, -4523, 0), Vector(-5143, -4483, 121)}

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