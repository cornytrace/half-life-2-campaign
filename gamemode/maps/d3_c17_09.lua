NEXT_MAP = "d3_c17_10a"

RESPAWN_ALLOWED = true

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit")
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
	aft = ents.Create("ai_goal_follow")
	aft:SetPos(Vector(1065, 353, -631))
	aft:SetKeyValue("targetname", "hl2c_barney_temp_follow")
	aft:SetKeyValue("actor", "barney")
	aft:SetKeyValue("goal", "!player")
	aft:Spawn()

	local healed = ents.FindByName("barney_healed_relay")
	healed[1]:Fire("addoutput", "OnTrigger hl2c_barney_temp_follow,Activate,,0,1", "3.0")
end)