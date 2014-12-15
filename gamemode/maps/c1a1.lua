INFO_PLAYER_SPAWN = {Vector(984, 654, -80), 101}

NEXT_MAP = "c1a1a"
LAST_MAP = "c1a0c"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()	
	for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
		if tcl.map == LAST_MAP then			
			local tclMin, tclMax = tcl:WorldSpaceAABB()
			GAMEMODE:CreatePC(tclMin, tclMax)
		end
		tcl:Remove()
	end
end)