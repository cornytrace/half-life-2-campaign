INFO_PLAYER_SPAWN = {Vector(-1290, 323, -203), 0}

NEXT_MAP = "c1a1b"
LAST_MAP = "c1a1a"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()	
	for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
		if tcl.map == LAST_MAP then			
			local tclMin, tclMax = tcl:WorldSpaceAABB()
			GAMEMODE:CreatePC(tclMin, tclMax)
		end
		tcl:Remove()
	end
	
	local wep = ents.Create("weapon_pistol")
	wep:SetPos(Vector(-293, -975, -211))
	wep:Spawn()
	wep:Activate()
	
	local dr = ents.FindByName("doors")
	dr[1]:Fire("Lock", "", "0.0")
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
end)