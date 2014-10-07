INFO_PLAYER_SPAWN = {Vector(-9984, -3668, 420), 90}

NEXT_MAP = "d1_canals_01"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local wep = ents.Create("weapon_medkit_hl2c")
	wep:SetPos(Vector(-9723, -3459, 411))
	wep:Spawn()
	wep:Activate()
end)