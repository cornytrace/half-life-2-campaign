INFO_PLAYER_SPAWN = {Vector(-1244, -996, -292), 0}

NEXT_MAP = "t0a0d"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local rec = ents.FindByClass("func_recharge")
	rec[1]:Fire("addoutput", "targetname hl2c_rechargeable")

	local timer = ents.Create("logic_timer")
	timer:SetPos(Vector(-111, -742, 28))
	timer:SetKeyValue("RefireTime", "1")
	timer:Fire("addoutput", "OnTimer hl2c_rechargeable,Recharge,,0.0,-1", "0.0")
	timer:Spawn()
	timer:Activate()
	
	local change = ents.Create("point_changelevel")
	change:SetPos(Vector(-807, -1631, 62))
	change:SetKeyValue("targetname", "hl2c_changelevel")
	change:Spawn()
	change:Activate()
	
	local button = ents.FindByName("lockedbutton")
	button[1]:Fire("addoutput", "OnPressed hl2c_changelevel,Changelevel,,3.0,-1", "0.0")
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_smg1")
end)