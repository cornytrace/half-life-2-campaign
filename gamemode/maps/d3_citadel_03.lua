INFO_PLAYER_SPAWN = {Vector(7734, -1439, 2148), 90}

NEXT_MAP = "d3_citadel_04"

RESET_WEAPONS = true

SUPER_GRAVITY_GUN = true

TRIGGER_CHECKPOINT = {
	{Vector(3175, 522, 2368), Vector(3580, 562, 2529)}
}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local strip_stop = ents.FindByName("strip_stop")
	strip_stop[1]:Fire("Trigger", "", "20.0")

	local motion_ent = ents.FindByName("weapon_strip_motion_disable")
	for _, motion in pairs(motion_ent) do
		motion:Remove()
	end
	
	local motion_pl_ent = ents.FindByName("weapon_strip_motion_disable_player")
	for _, motion_pl in pairs(motion_pl_ent) do
		motion_pl:Remove()
	end
	
	local strip_ent = ents.FindByClass("trigger_weapon_strip")
	for _, strip in pairs(strip_ent) do
		strip:Remove()
	end

	local dissolve_ent = ents.FindByClass("trigger_weapon_dissolve")
	for _, dissolve in pairs(dissolve_ent) do
		dissolve:Remove()
	end

	local func_brushes = ents.FindByClass("func_brush")
	func_brushes[6]:Remove()
	func_brushes[7]:Remove()
	func_brushes[12]:Remove()
	func_brushes[13]:Remove()
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_physcannon")
end)