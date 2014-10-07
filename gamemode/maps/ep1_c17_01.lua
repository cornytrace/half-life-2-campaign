NEXT_MAP = "ep1_c17_02"

RESPAWN_ALLOWED = true

TRIGGER_CHECKPOINT = {
	{Vector(2773, -1314, 9), Vector(2725, -1258, 112)},
	{Vector(1629, 1812, 9), Vector(1486, 1860, 103)},
	{Vector(-3372, 413, 9), Vector(-3472, 481, 103)}
}

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	local aft = ents.FindByName("goalfollow_alyx")
	aft[1]:Fire("deactivate", "", "0.0")
	aft[1]:Fire("activate", "", "1.0")

	pl:Give("weapon_physcannon")
	pl:Give("weapon_pisol")
	pl:Give("weapon_shotgun")
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	aft = ents.FindByName("goalfollow_alyx")
	aft[1]:Fire("addoutput", "goal !player")
	
	local sa = ents.Create("ai_relationship")
	sa:SetPos(Vector(530, 312, 270))
	sa:SetKeyValue("targetname", "relationship_alyxSniper_hl2c")
	sa:SetKeyValue("rank", "999")
	sa:SetKeyValue("Reciprocal", "1")
	sa:SetKeyValue("StartActive", "1")
	sa:SetKeyValue("subject", "sniper_alyx")
	sa:SetKeyValue("target", "player")
	sa:Spawn()
	
	local timer2 = ents.Create( "logic_timer" )
	timer2:SetPos(Vector(536, 313, 275))
	timer2:SetKeyValue( "RefireTime", "0.1" )
	timer2:SetKeyValue( "targetname", "hl2c_timer_relationship" )
	timer2:SetKeyValue( "StartDisabled", "1" )
	timer2:Fire("addoutput", "OnTimer relationship_alyxSniper_hl2c,ApplyRelationship,,0.0,-1", "1")
	timer2:Spawn()
	
	local alyxisnowsniper = ents.FindByName("relay_alyx_shoot_ladder")
	alyxisnowsniper[1]:Fire("addoutput", "OnTrigger hl2c_timer_relationship,Enable,,0.0,-1", "1")
	
	local template = ents.FindByName("ptemplate_AlyxSniper")
	template[1]:Fire("addoutput", "OnEntitySpawned sniper_alyx,ProtectTarget,player,0.0,-1", "1")
	
	local asc1 = ents.FindByName("aisc_AlyxWaitsForPlayerToLook")
	asc1[1]:Remove()
	
	local asc2 = ents.FindByName("aisc_AlyxWaitsForPlayerToLook")
	asc2[1]:Remove()
	
	local ap = ents.FindByName("assaultpoint_alyxWaits")
	ap[1]:Fire("addoutput", "OnAssaultClear lcs_sniper_headoff,Start,,1.0,-1", "1")
	
	local fakeaisc = ents.FindByName("lcs_sniper_headoff")
	fakeaisc[1]:Fire("addoutput", "OnTrigger1 lcs_sniper_headoff,Resume,,1.0,-1", "1")
end)