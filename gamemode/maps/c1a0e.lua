INFO_PLAYER_SPAWN = {Vector(1500, -160, -320), 44}

TRIGGER_CHECKPOINT = {
	{Vector(1577, 69, -354), Vector(1756, 119, -228)}
}

NEXT_MAP = "c1a0c"
LAST_MAP = "c1a0b"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	for _, tcl in pairs(ents.FindByClass("trigger_changelevel")) do
		if tcl.map == LAST_MAP then			
			local tclMin, tclMax = tcl:WorldSpaceAABB()
			GAMEMODE:CreatePC(tclMin, tclMax)
		end
		tcl:Remove()
	end
	
	local change = ents.Create("point_changelevel")
	change:SetPos(Vector(-2087, 1013, -1575))
	change:SetKeyValue("targetname", "hl2c_changelevel")
	change:Spawn()
	change:Activate()
	
	local mm = ents.FindByName("x_black_room_sounds_mm1")
	mm[1]:Fire("addoutput", "OnTrigger hl2c_changelevel,Changelevel,,10.0,-1", "0.0")
end)