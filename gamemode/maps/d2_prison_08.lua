NEXT_MAP = "d3_c17_01"

TRIGGER_CHECKPOINT = {
	{Vector(-1013, 953, 960), Vector(-803, 1001, 1122)},
	{Vector(-496, 631, 928), Vector(-355, 672, 1083)},
	{Vector(-255, 519, 928), Vector(-215, 640, 1089)},
	{Vector(95, -26, 1044), Vector(156, 34, 1125)}
}

TRIGGER_DELAYMAPLOAD = {Vector(-954, -1049, 912), Vector(-868, -965, 995)}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local ai_relationship_turret = ents.Create( "ai_relationship" )
	ai_relationship_turret:SetPos( Vector( 0,0,0 ) )
	ai_relationship_turret:SetKeyValue( "targetname", "relationship_turret_vs_player_like" )
	ai_relationship_turret:SetKeyValue( "target", "player" )
	ai_relationship_turret:SetKeyValue( "subject", "npc_turret_floor" )
	ai_relationship_turret:SetKeyValue( "rank", "99" )
	ai_relationship_turret:SetKeyValue( "StartActive", "1" )
	ai_relationship_turret:Spawn()
end)

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