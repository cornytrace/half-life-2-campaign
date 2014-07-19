NEXT_MAP = "ep2_outland_01a"

RESET_PL_INFO = true

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local ep2_player_start_clip = ents.FindByName("brush_clip_gravdoor")
	ep2_player_start_clip[1]:Remove()

	local ep2_start_door_brush = ents.FindByName("physbox.train.door")
	ep2_start_door_brush[1]:Remove()

	local ep2_start_door_prop = ents.FindByName("prop_train_door")
	ep2_start_door_prop[1]:Remove()
	
	local ep2_alyx_mark = ents.FindByName("lcs.alyx.findplayer")
	ep2_alyx_mark[1]:Remove()
	
	local ep2_gravgun_prop_start = ents.FindByName("gravgun_prop1")
	ep2_gravgun_prop_start[1]:Remove()

	local ep2_plug_explosion = ents.FindByName("explo_plug")
	ep2_plug_explosion[1]:SetKeyValue("magnitude", "120")

	local ep2_plug = ents.FindByName("plug")
	ep2_plug[1]:Fire("enablemotion")

	local ep2_cable_start = ents.FindByName("SS_cable_fix_begin")
	ep2_cable_start[1]:SetKeyValue( "m_iszPlay", "Idle01" )
	ep2_cable_start[1]:SetKeyValue( "m_iszPostIdle", "Idle01" )

	local ep2_cable_end = ents.FindByName("SS_cable_fix_end")
	ep2_cable_end[1]:SetKeyValue( "m_iszPlay", "Idle01")

	local ep2_alyx_hopdown = ents.FindByName("SS_alyx_scrapyard_down")
	ep2_alyx_hopdown[1]:SetKeyValue( "m_iszPlay", "crawl_thru" )

	local wep = ents.Create("weapon_physcannon")
	wep:SetPos(Vector(1092, -129, -7))
	wep:Spawn()
	wep:Activate()

	local ai_relationship_start = ents.Create( "ai_goal_follow" )
	ai_relationship_start:SetPos( Vector( 0,0,0 ) )
	ai_relationship_start:SetKeyValue( "actor", "alyx" )
	ai_relationship_start:SetKeyValue( "StartActive", "1" )
	ai_relationship_start:SetKeyValue( "Formation", "6" )
	ai_relationship_start:SetKeyValue( "goal", "player" )
	ai_relationship_start:Spawn()
end)