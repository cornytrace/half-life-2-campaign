INFO_PLAYER_SPAWN = {Vector(106, -260, -151), 225}

NEXT_MAP = "t0a0c"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local wep = ents.Create("weapon_smg1")
	wep:SetPos(Vector(-232, 56, -150))
	wep:Spawn()
	wep:Activate()
	wep:Fire("addoutput", "OnPlayerPickup mp5mm,Trigger,,0.0,-1", "0.0")
	
	local ammoc1 = ents.Create("item_ammo_crate")
	ammoc1:SetPos(Vector(-976, -224, -170))
	ammoc1:SetKeyValue("angles", "0 270 0")
	ammoc1:SetKeyValue("AmmoType", "1")
	ammoc1:Spawn()
	ammoc1:Activate()
	
	local ammoc2 = ents.Create("item_ammo_crate")
	ammoc2:SetPos(Vector(-1056, -224, -170))
	ammoc2:SetKeyValue("angles", "0 270 0")
	ammoc2:SetKeyValue("AmmoType", "9")
	ammoc2:Spawn()
	ammoc2:Activate()
	
	local dr = ents.FindByName("td11")
	dr[1]:Fire("addoutput", "OnFullyClosed !self,Unlock,,0.0,-1", "0.0")
	dr[1]:Fire("addoutput", "OnFullyClosed !self,Open,,0.5,-1", "0.0")
	dr[1]:Fire("addoutput", "OnFullyOpen !self,Lock,,0.0,-1", "0.0")
	
	local dr2 = ents.FindByName("swimblock1")
	for _, sdr in pairs(dr2) do
		sdr:Remove()
	end
	
	local dr3 = ents.FindByName("swimblock2")
	for _, sdr2 in pairs(dr3) do
		sdr2:Remove()
	end
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
end)