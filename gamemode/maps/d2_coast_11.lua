NEXT_MAP = "d2_coast_12"

TRIGGER_CHECKPOINT = {
	{Vector(4556, 6631, 599), Vector(4208, -6875, 666)}
}

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
end)

-- Let me set things for "player" and not "!player"
hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local vort_follow = ents.FindByName("aigf_vort")
	vort_follow[1]:Fire("addoutput", "goal player", "0.0")

	local math_counter = ents.FindByName("mc_both_in")
	math_counter[1]:Remove()

	local ant_spawnat_player = ents.FindByName("antlion_expanse_spawner_1")
	ant_spawnat_player[1]:Fire("addoutput", "spawntarget player", "0.0")
end)