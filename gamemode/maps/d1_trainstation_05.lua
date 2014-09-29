NEXT_MAP = "d1_trainstation_06"

PLAYER_IS_CITIZEN = true

BRUSH_PLAYERCLIP = {
	{Vector(-7600, 4379, 10822), Vector(-6750, 5055, 10928)}
}

BRUSH_PLAYERFREEZE = {
	{Vector(3653, -4537, 9830), Vector(3520, -4438, 9984)},
	{Vector(-13418, -178, 32), Vector(-13376, -136, 128)}
}

TRIGGER_CHECKPOINT = {
	{Vector(-6505, -1157, 0), Vector(-6458, -1104, 97)},
	{Vector(-7093, -1471, 0), Vector(-7074, -1302, 107)},
	{Vector(3653, -4537, 9830), Vector(3520, -4438, 9984)},
	{Vector(-10307, -4745, 349), Vector(-10395, -4697, 432)}
}

hook.Add("EntityRemoved", "hl2cEntityRemoved", function(ent)
	if ent:GetClass() == "item_suit" then
		PLAYER_IS_CITIZEN = false
	end
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	if !game.SinglePlayer() then
		local viewcontroller = ents.FindByName("viewcontrol_ickycam")
		viewcontroller[1]:Remove()
	end
end)