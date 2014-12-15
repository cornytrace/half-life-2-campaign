INFO_PLAYER_SPAWN = {Vector(-748, -1492, 52), 180}

TRIGGER_DELAYMAPLOAD = {Vector(184, -2857, -11), Vector(184, -2857, -11)}

NEXT_MAP = "c0a0"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local eledr = ents.FindByName("startele1")
	for _, dr in pairs(eledr) do
		dr:Remove()
	end
	
	local lvldone = ents.FindByName("donemm")
	lvldone[1]:Fire("addoutput", "OnTrigger hl2c_changelevel,Changelevel,,10.0,-1", "0.0")
	
	local change = ents.Create("point_changelevel")
	change:SetPos(Vector(279, -2482, -51))
	change:SetKeyValue("targetname", "hl2c_changelevel")
	change:Spawn()
	change:Activate()
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_smg1")
end)