ALLOWED_VEHICLE = "Named Airboat"

NEXT_MAP = "d1_canals_12"

--TRIGGER_CHECKPOINT = {
	--{Vector(5643, 4736, -939), Vector(5669, 5083, -779), false, function() ALLOWED_VEHICLE = "Airboat Gun" end},
	--{Vector(289, -7412, -896), Vector(315, -7064, -736)}
--}

hook.Add("PlayerSpawn", "hl2cPlayerSpawn", function(pl)
	pl:Give("weapon_crowbar")
	pl:Give("weapon_pistol")
	pl:Give("weapon_smg1")
	pl:Give("weapon_medkit")
end)

hook.Add("EntityRemoved", "hl2cEntityRemoved", function(ent)
	if ent:GetName() == "door_guncave_exit" then
		local entity2 = ents.FindByClass("prop_vehicle_airboat")
		for _, ent2 in pairs(entity2) do
			ent2:Fire("enablegun", "1")
		end
		ALLOWED_VEHICLE = "Airboat Gun"
	end
end)

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local physbox = ents.FindByName("gate1")
	physbox[1]:Remove()
	
	local gate_relay = ents.FindByName("relay_guncave_gate_entrance_close")
	gate_relay[1]:Remove()

	local gate = ents.FindByName("door_guncave_exit")
	gate[1]:Fire("addoutput", "OnFullyOpen !self,Kill,,0,-1", "0")
end)