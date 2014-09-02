NEXT_MAP = "d2_coast_12"

RESPAWN_ALLOWED = true

TRIGGER_DELAYMAPLOAD = {Vector(4241, 6827, 576), Vector(4654, 6807, 696)}

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	-- Fix antlions not spawning on players
	pl:Fire("addoutput", "targetname !player", "0.0")
	
	-- Give items
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