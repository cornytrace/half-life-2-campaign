NEXT_MAP = "d1_trainstation_04"

TRIGGER_CHECKPOINT = {
	{Vector(-3672, -4524, 264), Vector(-3758, -4648, 368)},
	{Vector(-4998, -4918, 512), Vector(-4978, -4699, 619)}
}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local trigger_push = ents.FindByName("attic_door_push")
	trigger_push[1]:Remove()
end)