ALLOWED_VEHICLE = "Jeep"

NEXT_MAP = "d2_coast_03"

BRUSH_PLAYERCOLLIDE = {
	{Vector(-8201, 258, 976), Vector(-8663, 763, 1022)}
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
end)