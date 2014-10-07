INFO_PLAYER_SPAWN = {Vector(-14576, -14208, -1264), 90}

NEXT_MAP = "d1_trainstation_02"

RESET_PL_INFO = true

PLAYER_IS_CITIZEN = true

BRUSH_PLAYERFREEZE = {
	{Vector(-14576, -14208, -1291), Vector(-14452, -14329, -1163)},
}

TRIGGER_CHECKPOINT = {
	{Vector(-9386, -2488, 24), Vector(-9264, -2367, 92), true},
	{Vector(-5396, -1984, 16), Vector(-5310, -1932, 113)},
	{Vector(-4012, -551, -32), Vector(-4004, -472, 62)},
	{Vector(-3607, -368, -17), Vector(-3273, -141, 86)},
	{Vector(-3427, -118, -32), Vector(-3417, -13, 62)}
}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local pvc_control = ents.Create("point_pvc_controller")
	pvc_control:SetPos(Vector(150, -150, 150))
	pvc_control:SetKeyValue("targetname", "hl2c_pvc_controller")
	pvc_control:Spawn()
	pvc_control:Activate()

	local o_pvc = ents.FindByName("viewcontrol_final")
	o_pvc[1]:Fire("addoutput", "targetname hl2c_viewcontrol_1")
	
	local scene1 = ents.FindByName("scene1_start")
	scene1[1]:Fire("addoutput", "OnTrigger hl2c_pvc_controller,Enable1,,0.1,1")
	
	local scene4 = ents.FindByName("scene4_start")
	scene4[1]:Fire("addoutput", "OnTrigger hl2c_viewcontrol_1,SetParent,tracktrain_finalview_move,20.0,1")
	scene4[1]:Fire("addoutput", "OnTrigger hl2c_pvc_controller,Disable1,,25.6,1")
end)