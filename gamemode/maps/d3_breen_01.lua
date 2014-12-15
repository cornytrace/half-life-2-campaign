INFO_PLAYER_SPAWN = {Vector(-2489, -1292, 580), 90}

NEXT_MAP = "d1_trainstation_01"

RESET_WEAPONS = true

SUPER_GRAVITY_GUN = true

TRIGGER_CHECKPOINT = {
	{Vector(-2379, 390, 576), Vector(-2237, 531, 697)},
	{Vector(-1890, -58, 1344), Vector(-1849, 63, 1465)},
	{Vector(-820, -115, -256), Vector(-780, 111, -95)}
}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local blackout_viewcontroller = ents.FindByName("blackout_viewcontroller")
	blackout_viewcontroller[1]:Remove()
	
	local logic = ents.FindByName("logic_fade_view")
	logic[1]:Fire("addoutput", "OnTrigger hl2c_changelevel,Changelevel,,2.5,-1")
	
	local change = ents.Create("point_changelevel")
	change:SetPos(Vector(3840, 13366, 4266))
	change:SetKeyValue("targetname", "hl2c_changelevel")
	change:Spawn()
	change:Activate()
	
	local player_pod = ents.FindByName("pod")
	player_pod[1]:Fire("Unlock", "", "0.1")
	player_pod[1]:Fire("Unlock", "", "0.2")
	player_pod[1]:Fire("Unlock", "", "0.3")
	player_pod[1]:Fire("Unlock", "", "0.4")
	player_pod[1]:Fire("Unlock", "", "0.5")
	player_pod[1]:Fire("Unlock", "", "0.6")
	player_pod[1]:Fire("Unlock", "", "0.7")
	player_pod[1]:Fire("Unlock", "", "0.8")
	player_pod[1]:Fire("Unlock", "", "0.9")
	player_pod[1]:Fire("Unlock", "", "1.0")
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	local player_pod = ents.FindByName("pod")
	for _, pod in pairs(player_pod) do
		pl:EnterVehicle(pl)
	end
end)