ALLOWED_VEHICLE = "Jeep"

NEW_VEHICLE_SPAWN = true

TRIGGER_VEHICLESPAWN = {
	{Vector(-8009, -9601, 905), Vector(-7658, -8136, 905)}
}

NEXT_MAP = "d2_coast_03"

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
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	-- Prevent players going through the door back to the base
	local door = ents.FindByName("warehouse_exitdoor")
	door[1]:Fire("Lock")
	
	-- Jeep spawned naturally doesn't have the HL2C features
	local jeep_map = ents.FindByName("jeep")
	jeep_map[1]:Fire("enablegun", "1")
	jeep_map[1]:SetBodygroup(1, 1)
	if !game.SinglePlayer() then
		if GetConVarNumber("hl2c_passenger_seats") >= 1 then
			local seat = ents.Create( "prop_vehicle_prisoner_pod" )
			seat:SetModel( "models/nova/jeep_seat.mdl" )
			seat:SetPos( jeep_map[1]:LocalToWorld( Vector( 21,-32,18 ) ) )
			seat:SetAngles( jeep_map[1]:LocalToWorldAngles( Angle( 0,-3.5,0 ) ) )
			seat:Spawn()
			seat:SetKeyValue( "limitview", "1" )
			seat:SetKeyValue( "targetname", "hl2c_passenger_seat" )
			seat:SetMoveType( MOVETYPE_NONE )
			seat:SetParent( jeep_map[1], -1 )
		end
	end

	local push = ents.FindByName("push_car_superjump_01")
	push[1]:Fire("addoutput", "StartDisabled 0", "0")

	local push_timer = ents.Create( "logic_timer" )
	push_timer:SetPos( Vector( -7940,303,1063 ) )
	push_timer:SetKeyValue( "RefireTime", "3" )
	push_timer:SetKeyValue( "targetname", "hl2c_push_timer" )
	push_timer:Fire("addoutput", "OnTimer push_car_superjump_01,Enable,,0.00,-1", "0")
	push_timer:Spawn()
	
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