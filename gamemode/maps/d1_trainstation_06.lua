INFO_PLAYER_SPAWN = {Vector(-9984, -3668, 420), 90}

NEXT_MAP = "d1_canals_01"

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	if !game.SinglePlayer() then

	-- Fix stuff
	local hudhint = ents.FindByName("zoom_hint")
	hudhint[1]:Fire("addoutput", "spawnflags 1")
	
	local aisc1 = ents.FindByName("scriptCond_seeBarney")
	aisc1[1]:Remove()
	
	local aisc_r1 = ents.Create("logic_relay")
	aisc_r1:SetPos(Vector(-9746, -3456, 546))
	aisc_r1:SetKeyValue("targetname", "relay_scriptCond_seeBarney")
	aisc_r1:Fire("addoutput", "OnTrigger timer_heyGordon,Disable,,0.0,-1")
	aisc_r1:Fire("addoutput", "OnTrigger logic_citadel_scanners_1,Trigger,,0.0,-1")
	aisc_r1:Fire("addoutput", "OnTrigger timer_heyGordon,Kill,,0.1,-1")
	aisc_r1:Fire("addoutput", "OnTrigger lcs_crowbar_intro,Resume,,0.5,-1")
	aisc_r1:Fire("addoutput", "OnTrigger citadel,SetAnimation,open,1.7,-1")
	aisc_r1:Fire("addoutput", "OnTrigger lcs_ba_heyGordon,Kill,,3.5,-1")
	aisc_r1:Spawn()
	aisc_r1:Activate()
	
	local lcs1 = ents.FindByName("lcs_crowbar_intro")
	lcs1[1]:Fire("addoutput", "OnTrigger1 relay_scriptCond_seeBarney,Trigger,,2.0,-1")

	-- Create a medkit
	local wep = ents.Create("weapon_medkit_hl2c")
	wep:SetPos(Vector(-9723, -3459, 411))
	wep:Spawn()
	wep:Activate()
	
	end
end)