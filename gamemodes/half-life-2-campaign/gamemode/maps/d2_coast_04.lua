ALLOWED_VEHICLE = "Jeep"

NEXT_MAP = "d2_coast_05"

BRUSH_PLAYERCOLLIDE = {
	{Vector(-2033, 738, 909), Vector(-1621, 1312, 921)}
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
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local parts = ents.FindByName("jeepwindow_parts")
	parts[1]:Remove()
	parts[2]:Remove()
	parts[3]:Remove()
	parts[4]:Remove()
	parts[5]:Remove()
	parts[6]:Remove()
	parts[7]:Remove()
	parts[8]:Remove()
	parts[9]:Remove()

	local beams = ents.FindByName("jeepwindow_beams")
	beams[1]:Remove()
	beams[2]:Remove()
	beams[3]:Remove()

	local glass = ents.FindByName("jeepwindow_glass")
	glass[1]:Remove()
	glass[2]:Remove()
	glass[3]:Remove()
	glass[4]:Remove()
	glass[5]:Remove()
	glass[6]:Remove()
	glass[7]:Remove()
	glass[8]:Remove()
end)