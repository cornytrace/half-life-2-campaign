INFO_PLAYER_SPAWN = {Vector(605, -408, -160), 90}

BRUSH_PLAYERCLIP = {
	{Vector(578, -463, -215), Vector(631, -534, -141)}
}

NEXT_MAP = "c1a1c"

if !file.Exists("hl2c_data/hl2c_hl1_c1a0c.txt", "DATA") then
	file.Write("hl2c_data/hl2c_hl1_c1a0c.txt", "We've been here before. Spawn somewhere else please.")
end

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_pistol")
	pl:Give("weapon_crowbar")
end)