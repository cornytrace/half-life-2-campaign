INFO_PLAYER_SPAWN = {Vector(-1380, -1964, -24), 90}

NEXT_MAP = "t0a0a"

RESET_PL_INFO = true

PLAYER_IS_CITIZEN = true

BRUSH_PLAYERCLIP = {
	{Vector(956, 2335, -46), Vector(1763, 2065, -44)}
}

hook.Add("EntityRemoved", "hl2cEntityRemoved", function(ent)
	if ent:GetClass() == "item_suit" then
		PLAYER_IS_CITIZEN = false
	end
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local door = ents.FindByClass("func_door")
	for _, dr in pairs(door) do
		dr:Fire("addoutput", "OnFullyClosed !self,Unlock,,0.0,-1", "0.0")
		dr:Fire("addoutput", "OnFullyClosed !self,Open,,0.5,-1", "0.0")
		dr:Fire("addoutput", "OnFullyOpen !self,Lock,,0.0,-1", "0.0")
	end
	
	local duck = ents.FindByName("duckmm")
	duck[1]:Fire("addoutput", "OnTrigger duck1l,Toggle,,0.0,-1", "0.0")
	duck[1]:Fire("addoutput", "OnTrigger duck1s,PlaySound,,0.0,-1", "0.0")
	duck[1]:Fire("addoutput", "OnTrigger duck2l,Toggle,,1.0,-1", "1.0")
	duck[1]:Fire("addoutput", "OnTrigger duck2s,PlaySound,,1.0,-1", "1.0")
	duck[1]:Fire("addoutput", "OnTrigger duck3l,Toggle,,2.0,-1", "2.0")
	duck[1]:Fire("addoutput", "OnTrigger duck3s,PlaySound,,2.0,-1", "2.0")
end)