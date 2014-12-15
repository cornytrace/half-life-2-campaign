INFO_PLAYER_SPAWN = {Vector(580, 176, 40), 180}

NEXT_MAP = "t0a0b1"

BRUSH_PLAYERCLIP = {
	{Vector(-446, 903, 266), Vector(-663, 601, 269)}
}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local block1 = ents.FindByName("block")
	block1[1]:Remove()
	
	local elestop2 = ents.FindByName("floathumanlift2")
	elestop2[1]:Fire("addoutput", "OnPass floathumanlift,Start,,3.0,-1", "0.0")
end)