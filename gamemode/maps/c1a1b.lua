INFO_PLAYER_SPAWN = {Vector(-200, -160, -196), 0}

NEXT_MAP = "c1a1c"
LAST_MAP = "c1a1f"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()	
	for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
		if tcl.map == LAST_MAP then			
			local tclMin, tclMax = tcl:WorldSpaceAABB()
			GAMEMODE:CreatePC(tclMin, tclMax)
		end
		tcl:Remove()
	end
	
	local ammoc1 = ents.Create("item_ammo_crate")
	ammoc1:SetPos(Vector(48, -912, -47))
	ammoc1:SetKeyValue("angles", "0 120 0")
	ammoc1:SetKeyValue("AmmoType", "0")
	ammoc1:Spawn()
	ammoc1:Activate()
	
	local ammoc2 = ents.Create("item_ammo_crate")
	ammoc2:SetPos(Vector(-128, -889, -47))
	ammoc2:SetKeyValue("angles", "0 76 0")
	ammoc2:SetKeyValue("AmmoType", "5")
	ammoc2:Spawn()
	ammoc2:Activate()
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_pistol")
	pl:Give("item_ammo_pistol")
	pl:Give("weapon_crowbar")
end)