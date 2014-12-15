NEXT_MAP = "d1_trainstation_05"

PLAYER_IS_CITIZEN = true

TRIGGER_CHECKPOINT = {
	{Vector(-7174, -4048, 530), Vector(-6796, -4208, 620)},
	{Vector(-7208, -4038, 394), Vector(-7144, -3930, 502)},
	{Vector(-7645, -4029, -247), Vector(-7610, -3897, -115)}
}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	if !game.SinglePlayer() then
		local telepl = ents.Create("point_hl2cteleport")
		telepl:SetPos(Vector(-7740, -3960, 389))
		telepl:SetKeyValue("targetname", "hl2c_teleport")
		telepl:Spawn()
		telepl:Activate()
		
		local trigger = ents.FindByName("trigger_elevator_go_down")
		trigger[1]:Fire("addoutput", "OnTrigger hl2c_teleport,Teleport,,0.1,-1")
		
		local door = ents.FindByName("door_inside_secret")
		door[1]:Fire("addoutput", "OnFullyClosed !self,Unlock,,0.4,-1")
		door[1]:Fire("addoutput", "OnFullyClosed !self,Open,,0.5,-1")
		
		local teledest = ents.FindByName("destination_knockout_1")
		teledest[1]:Remove()
	end
end)