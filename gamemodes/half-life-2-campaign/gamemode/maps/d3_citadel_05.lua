NEXT_MAP = "d3_breen_01"

NEXT_MAP_PERCENT = 1

SUPER_GRAVITY_GUN = true

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local relationships = ents.FindByName("pen_camera_1")
	relationships[1]:Fire("addoutput", "subject pen_camera_1", "15")

	local playerpods1 = ents.FindByName("pod_02_track0")
	playerpods1[1]:Fire("addoutput", "OnPass playerpod_timer,Enable,,0.10,-1", "50")
	playerpods1[1]:Fire("addoutput", "OnPass gunship_relationships,ApplyRelationship,,0.00,-1", "50")

	local fades = ents.FindByClass("env_fade")
	fades[1]:Remove()
	fades[2]:Remove()
	fades[3]:Remove()
	fades[4]:Remove()
	fades[5]:Remove()

	local gunship_ai = ents.FindByName("gunship_relationships")
	gunship_ai[1]:Fire("addoutput", "target player", "15")

	local playerpod_timer = ents.Create( "logic_timer" )
	playerpod_timer:SetPos( Vector( 0,128,-2873 ) )
	playerpod_timer:SetKeyValue( "RefireTime", "5" )
	playerpod_timer:SetKeyValue( "targetname", "playerpod_timer" )
	playerpod_timer:SetKeyValue( "StartDisabled", "1" )
	playerpod_timer:Fire("addoutput", "OnTimer playerpod1_train,Resume,,0.10,-1", "25")
	playerpod_timer:Fire("addoutput", "OnTimer playerpod2_train,Resume,,0.10,-1", "25")
	playerpod_timer:Fire("addoutput", "OnTimer playerpod3_train,Resume,,0.10,-1", "25")
	playerpod_timer:Fire("addoutput", "OnTimer playerpod4_train,Resume,,0.10,-1", "25")
	playerpod_timer:Fire("addoutput", "OnTimer playerpod5_train,Resume,,0.10,-1", "25")
	playerpod_timer:Fire("addoutput", "OnTimer playerpod6_train,Resume,,0.10,-1", "25")
	playerpod_timer:Fire("addoutput", "OnTimer playerpod7_train,Resume,,0.10,-1", "25")
	playerpod_timer:Spawn()
end)