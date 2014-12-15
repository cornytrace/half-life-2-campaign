NEXT_MAP = "d3_c17_10a"

RESPAWN_ALLOWED = true

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit_hl2c")
	pl:Give("weapon_frag")
	pl:Give("weapon_357")
	pl:Give("weapon_physcannon")
	pl:Give("weapon_shotgun")
	pl:Give("weapon_ar2")
	pl:Give("weapon_rpg")
	pl:Give("weapon_crossbow")
	pl:Give("weapon_bugbait")
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	if !game.SinglePlayer() then

		local aisc_look = ents.FindByName("can_see_barney_aisc")
		aisc_look[1]:Remove()
		
		local ai_lead = ents.FindByName("barney_lead")
		ai_lead[1]:Remove()
		
		local barney_end_seq = ents.FindByName("barney_end_seq")
		barney_end_seq[1]:Fire("addoutput", "m_flRadius 0")
		
		local aisc_look_r = ents.Create("logic_relay")
		aisc_look_r:SetPos(Vector(7386, 6423, 393))
		aisc_look_r:SetKeyValue("targetname", "can_see_barney_aisc_relay")
		aisc_look_r:Spawn()
		aisc_look_r:Activate()
		aisc_look_r:Fire("addoutput", "OnTrigger !self,Disable,,0,-1", "2.0")
		aisc_look_r:Fire("addoutput", "OnTrigger barney_pinned_down_vcd_trigger,Kill,,0,-1", "2.0")
		aisc_look_r:Fire("addoutput", "OnTrigger lcs_barney_uphere,Kill,,0,-1", "2.0")
		aisc_look_r:Fire("addoutput", "OnTrigger lcs_barney_medic,Start,,0,-1", "2.0")

		local lcs_barney_uphere = ents.FindByName("lcs_barney_uphere")
		lcs_barney_uphere[1]:Fire("addoutput", "OnCompletion can_see_barney_aisc_relay,Trigger,,2,1")

		local healed = ents.FindByName("barney_healed_relay")
		healed[1]:Fire("addoutput", "OnTrigger barney_end_seq,BeginSequence,,1,1", "3.0")
	
	end
end)