NEXT_MAP = "d1_town_02"

TRIGGER_DELAYMAPLOAD = {Vector(-3801, -65, -3457), Vector(-3719, -7, -3335)}

if !file.Exists("hl2c_d1_town_03.txt", "DATA") then
	file.Write("hl2c_d1_town_03.txt", "We have been to d1_town_03.")
end

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit")
	pl:Give("weapon_frag")
	pl:Give("weapon_357")
	pl:Give("weapon_physcannon")
	pl:Give("weapon_shotgun")
end)