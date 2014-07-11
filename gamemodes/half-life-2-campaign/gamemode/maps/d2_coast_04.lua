ALLOWED_VEHICLE = "Named Jeep"

NEXT_MAP = "d2_coast_05"

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
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local push = ents.FindByName("push_car_superjump_01")
	push[1]:Fire("addoutput", "StartDisabled 0", "0")

	local push_timer = ents.Create( "logic_timer" )
	push_timer:SetPos( Vector( -2033, 738, 909 ) )
	push_timer:SetKeyValue( "RefireTime", "3" )
	push_timer:SetKeyValue( "targetname", "hl2c_push_timer" )
	push_timer:Fire("addoutput", "OnTimer push_car_superjump_01,Enable,,0.00,-1", "0")
	push_timer:Spawn()
end)