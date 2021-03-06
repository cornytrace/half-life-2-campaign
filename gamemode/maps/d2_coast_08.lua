INFO_PLAYER_SPAWN = {Vector(3328, 1570, 1539), -90}

NEXT_MAP = "d2_coast_07"

TRIGGER_CHECKPOINT = {
	{Vector(3006, -6962, 1920), Vector(3039, -6928, 1996)}
}

hook.Add("PlayerUse", "hl2cPlayerUse", function(pl, ent)
	if ent:GetClass() == "func_door" then
		file.Write("hl2c_data/hl2c_d2_coast_08.txt", "We have been to d2_coast_08 & pushed the button!")
	end
end)

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
end)