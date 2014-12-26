TRIGGER_DELAYMAPLOAD = {Vector(-1716, 10946, 905), Vector(-1638 , 10991, 1006)}

TRIGGER_CHECKPOINT = {
	{Vector(-1167, 10321, 905), Vector(-1057, 10610, 1008)}
}

NEXT_MAP = "d2_coast_01"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()	
	if !game.SinglePlayer() then

	local close_door = ents.FindByName("trigger_close_door")
	close_door[1]:Remove()

	local tr_change = ents.FindByName("trigger_changelevel")
	tr_change[1]:Remove()
	
	-- Fix script conditions being a problem.
	local aisc1 = ents.FindByName("aisc_leon_waits")
	aisc1[1]:Remove()
	
	local aisc2 = ents.FindByName("aisc_leaonwait1")
	aisc2[1]:Remove()
	
	local aisc3 = ents.FindByName("aisc_attentiontoradio")
	aisc3[1]:Remove()
	
	local aisc_r1 = ents.Create("logic_relay")
	aisc_r1:SetPos(Vector(-1430, 9885, 905))
	aisc_r1:SetKeyValue("targetname", "relay_aisc_leon_waits")
	aisc_r1:Fire("addoutput", "OnTrigger warehouse_leonleads_lcs,Start,,0.0,-1")
	aisc_r1:Spawn()
	aisc_r1:Activate()
	
	local aisc_r2 = ents.Create("logic_relay")
	aisc_r2:SetPos(Vector(-1430, 9885, 905))
	aisc_r2:SetKeyValue("targetname", "relay_aisc_leaonwait1")
	aisc_r2:Fire("addoutput", "OnTrigger warehouse_leonleads_lcs,Resume,,0.0,-1")
	aisc_r2:Fire("addoutput", "OnTrigger radio_nag,Disable,,0.0,-1")
	aisc_r2:Spawn()
	aisc_r2:Activate()
	
	local aisc_r3 = ents.Create("logic_relay")
	aisc_r3:SetPos(Vector(-1430, 9885, 905))
	aisc_r3:SetKeyValue("targetname", "relay_aisc_attentiontoradio")
	aisc_r3:Fire("addoutput", "OnTrigger alyx_camera,SetOn,,0.0,-1")
	aisc_r3:Fire("addoutput", "OnTrigger lcs_leon_nag,Kill,,0.0,-1")
	aisc_r3:Fire("addoutput", "OnTrigger radio_nag,Kill,,0.0,-1")
	aisc_r3:Fire("addoutput", "OnTrigger lcs_leon_radios3,Start,,0.0,-1")
	aisc_r3:Spawn()
	aisc_r3:Activate()
	
	local lsc1 = ents.FindByName("warehouse_aftermath_lcs")
	lsc1[1]:Fire("addoutput", "OnCompletion relay_aisc_leon_waits,Trigger,,3.0,-1")
	
	local lsc2 = ents.FindByName("warehouse_leonleads_lcs")
	lsc2[1]:Fire("addoutput", "OnTrigger2 relay_aisc_leaonwait1,Trigger,,3.0,-1")
	lsc2[1]:Fire("addoutput", "OnCompletion relay_aisc_attentiontoradio,Trigger,,3.0,-1")
	
	end

	if GetConVarNumber("hl2c_additions") >= 1 then
		local map_model = ents.FindByModel("maps/"..game.GetMap()..".bsp")
		local prec = ents.Create("func_precipitation")
		prec:SetKeyValue("model", map_model[1]:GetModel())
		prec:SetKeyValue("preciptype", "0")
		prec:SetKeyValue("renderamt", "50")
		prec:SetKeyValue("rendercolor", "200 200 200")
		prec:Spawn()
		prec:Activate()
	end
end)

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit_hl2c")
	pl:Give("weapon_frag")
	pl:Give("weapon_357")
	pl:Give("weapon_physcannon")
	pl:Give("weapon_shotgun")
end)