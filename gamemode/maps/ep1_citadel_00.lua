INFO_PLAYER_SPAWN = {Vector(-9003, 5784, -140), 45}

NEXT_MAP = "ep1_citadel_01"

NEXT_MAP_TIME = 5

RESET_PL_INFO = true

TRIGGER_CHECKPOINT = {
	{Vector(-7999, 5480, 32), Vector(-7837, 5520, 153)}
}

TRIGGER_DELAYMAPLOAD = {Vector(4237, 4279, -6338), Vector(4245, 4018, -6207)}

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	if !game.SinglePlayer() then
	local viewcontrol = ents.FindByClass("point_viewcontrol")
	viewcontrol[1]:Remove()
	viewcontrol[2]:Remove()
	viewcontrol[3]:Remove()
	viewcontrol[4]:Remove()
	viewcontrol[5]:Remove()
	
	local speaker = ents.FindByName("speaker_TakeGravGun1Nag")
	speaker[1]:Remove()
	
	local gravgun = ents.Create("weapon_physcannon")
	gravgun:SetPos(Vector(-8977, 5784, -127))
	gravgun:Spawn()
	gravgun:Activate()
	
	local ss_dt = ents.FindByName("SS_dogthrow")
	ss_dt[1]:Fire("addoutput", "OnBeginSequence Dog,StopScripting,,0.0,1", "0.0")
	
	local ss_dc = ents.FindByName("ss_dog_climb")
	ss_dc[1]:Fire("addoutput", "OnEndSequence Dog,StartScripting,,0.0,1", "0.0")
	
	local vanend = ents.FindByName("relay_vanride_endcrash_1")
	vanend[1]:Fire("addoutput", "OnTrigger hl2c_timer_parent,Disable,,1.0,1", "0.0")
	vanend[1]:Fire("addoutput", "OnTrigger player,ClearParent,,1.1,1", "0.0")
	vanend[1]:Fire("addoutput", "OnTrigger hl2c_global,TurnOff,,1.2,-1", "0.0")
	vanend[1]:Fire("addoutput", "OnTrigger Van,ExitVehicle,,1.6,1", "0.0")
	
	local timer = ents.Create( "logic_timer" )
	timer:SetPos(Vector(1066, 353, -631))
	timer:SetKeyValue( "RefireTime", "0.1" )
	timer:SetKeyValue( "targetname", "hl2c_timer_parent" )
	timer:SetKeyValue( "StartDisabled", "1" )
	timer:Fire("addoutput", "OnTimer player,SetParentAttachment,attachment_alyx,0.0,-1", "5")
	timer:Spawn()
	
	local van = ents.FindByName("Van")
	van[1]:Fire("addoutput", "PlayerOn player,SetParent,Van,0.0,-1", "5")
	van[1]:Fire("addoutput", "PlayerOn hl2c_global,TurnOn,,0.0,-1", "5")
	van[1]:Fire("addoutput", "PlayerOn hl2c_timer_parent,Enable,,1.0,1", "0.0")
	
	local fall = ents.FindByName("trigger_falldeath")
	fall[1]:Remove()
	
	local inv = ents.Create("env_global")
	inv:SetPos(Vector(1067, 354, -632))
	inv:SetKeyValue( "targetname", "hl2c_global" )
	inv:SetKeyValue( "globalstate", "gordon_invulnerable" )
	inv:Spawn()
	end
end)