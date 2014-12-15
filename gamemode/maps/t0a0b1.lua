INFO_PLAYER_SPAWN = {Vector(1833, -1463, -135), 90}

TRIGGER_DELAYMAPLOAD = {Vector(-834, 831, -183), Vector(-991 , 795, -40)}

NEXT_MAP = "t0a0b2"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local push = ents.FindByClass("func_pushable")
	push[1]:Remove()
	
	local dr2 = ents.FindByName("td9")
	dr2[1]:Fire("addoutput", "OnFullyClosed !self,Unlock,,0.0,-1", "0.0")
	dr2[1]:Fire("addoutput", "OnFullyClosed !self,Open,,0.5,-1", "0.0")
	dr2[1]:Fire("addoutput", "OnFullyOpen !self,Lock,,0.0,-1", "0.0")
	
	local dr = ents.FindByName("td10")
	dr[1]:Remove()
end)