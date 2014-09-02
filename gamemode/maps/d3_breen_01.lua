INFO_PLAYER_SPAWN = {Vector(-2489, -1292, 580), 90}

NEXT_MAP = "d1_trainstation_01"

NEXT_MAP_PERCENT = 100

RESET_WEAPONS = true

SUPER_GRAVITY_GUN = true

TRIGGER_CHECKPOINT = {
	{Vector(-2379, 390, 576), Vector(-2237, 531, 697)},
	{Vector(-1890, -58, 1344), Vector(-1849, 63, 1465)},
	{Vector(-820, -115, -256), Vector(-780, 111, -95)}
}

TRIGGER_DELAYMAPLOAD = {Vector(-1912, 183, 585), Vector(-2021, 124, 683)}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local player_pod = ents.FindByName("pod")
	player_pod[1]:Fire("unlock", "", "120")

	local blackout_viewcontroller = ents.FindByName("blackout_viewcontroller")
	blackout_viewcontroller[1]:Remove()
end)