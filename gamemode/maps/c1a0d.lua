INFO_PLAYER_SPAWN = {Vector(-1744, 304, -240), 169}

PLAYER_IS_CITIZEN = true

NEXT_MAP = "c1a0a"
LAST_MAP = "c1a0"

hook.Add("EntityRemoved", "hl2cEntityRemoved", function(ent)
	if ent:GetClass() == "item_suit" then
		PLAYER_IS_CITIZEN = false
	end
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
		if tcl.map == LAST_MAP then			
			local tclMin, tclMax = tcl:WorldSpaceAABB()
			GAMEMODE:CreatePC(tclMin, tclMax)
		end
		tcl:Remove()
	end
end)