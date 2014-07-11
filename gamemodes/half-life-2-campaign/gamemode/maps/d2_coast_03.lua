ALLOWED_VEHICLE = "Jeep"

NEXT_MAP = "d2_coast_04"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local wep = ents.Create("weapon_rpg")
	wep:SetPos(Vector(8513, 4299, 270))
	wep:Spawn()
	wep:Activate()

	local filter = ents.FindByName("jeep_filter")
	filter[1]:Remove()
end)

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