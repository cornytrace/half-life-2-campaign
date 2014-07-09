NEXT_MAP = "d1_trainstation_06"

TRIGGER_CHECKPOINT = {
	{Vector(-6505, -1157, 0), Vector(-6458, -1104, 97)},
	{Vector(-7093, -1471, 0), Vector(-7074, -1302, 107)},
	{Vector(-10307, -4745, 349), Vector(-10395, -4697, 432)}
}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local viewcontroller = ents.FindByName("viewcontrol_ickycam")
	viewcontroller[1]:Remove()
end)