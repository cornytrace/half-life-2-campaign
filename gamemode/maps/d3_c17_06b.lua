NEXT_MAP = "d3_c17_07"

TRIGGER_CHECKPOINT = {
	{Vector(3537, 1539, 256), Vector(3616, 1581, 349)}
}

TRIGGER_DELAYMAPLOAD = {Vector(5040, 1575, 75), Vector(5105, 1497, 174)}

-- hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	-- for _, fdr in pairs(ents.FindByClass("func_door_rotating")) do
		-- if fdr:GetName() == "long_plank_1_rotator" then
			-- fdr:SetMoveType(0)
			-- fdr:SetAngles(fdr:GetAngles() + Vector(0, -45, 0))
		-- end
	-- end
-- end)

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