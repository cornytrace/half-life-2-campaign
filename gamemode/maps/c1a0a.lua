INFO_PLAYER_SPAWN = {Vector(240, 2112, 784), 0}

NEXT_MAP = "c1a0b"
LAST_MAP = "c1a0d"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
		if tcl.map == LAST_MAP then			
			local tclMin, tclMax = tcl:WorldSpaceAABB()
			GAMEMODE:CreatePC(tclMin, tclMax)
		end
		tcl:Remove()
	end
	
	local elebut1 = ents.FindByName("elebutton1")
	elebut1[1]:Fire("addoutput", "OnIn vdeath,Close,,0.0,-1", "0.0")
	
	local elebut2 = ents.FindByName("elebutton2")
	elebut2[1]:Fire("addoutput", "OnIn vdeath,Open,,0.0,-1", "0.0")
end)