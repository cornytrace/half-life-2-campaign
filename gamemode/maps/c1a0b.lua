INFO_PLAYER_SPAWN = {Vector(704, 980, -128), 0}

NEXT_MAP = "c1a0e"
LAST_MAP = "c1a0a"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
		if tcl.map == LAST_MAP then			
			local tclMin, tclMax = tcl:WorldSpaceAABB()
			GAMEMODE:CreatePC(tclMin, tclMax)
		end
		tcl:Remove()
	end
	
	local ele = ents.FindByName("edoor_2")
	for _, edr in pairs(ele) do
		edr:Fire("addoutput", "OnFullyOpen ele_2,GoDown,,3.0,-1", "0.0")
	end
end)