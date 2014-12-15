INFO_PLAYER_SPAWN = {Vector(-2584, -752, -248), 180}

NEXT_MAP = "c1a1f"
LAST_MAP = "c1a1"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()	
	for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
		if tcl.map == LAST_MAP then			
			local tclMin, tclMax = tcl:WorldSpaceAABB()
			GAMEMODE:CreatePC(tclMin, tclMax)
		end
		tcl:Remove()
	end
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
end)