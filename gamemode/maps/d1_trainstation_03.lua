NEXT_MAP = "d1_trainstation_04"

PLAYER_IS_CITIZEN = true

TRIGGER_CHECKPOINT = {
	{Vector(-3672, -4524, 264), Vector(-3758, -4648, 368)},
	{Vector(-4988, -4664, 522), Vector(-5048, -4616, 628)},
	{Vector(-4998, -4918, 512), Vector(-4978, -4699, 619)}
}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	if !game.SinglePlayer() then
		local ai_goal = ents.FindByName("ai_breakin_cop3goal3")
		ai_goal[1]:Remove()
		
		local blocker = ents.FindByName("ai_breakin_cop3goal3_blockplayer2")
		blocker[1]:Remove()
	end
end)