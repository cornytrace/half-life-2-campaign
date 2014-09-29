
AddCSLuaFile()

include("taunt_camera.lua")

DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.DisplayName			= "Co-Op Class"

PLAYER.DropWeaponOnDie		= true

PLAYER.TauntCam = TauntCamera()

function PLAYER:GetHandsModel()

	return { model = "models/weapons/c_arms_hev.mdl", skin = 1, body = "0100000" }

end

function PLAYER:ShouldDrawLocal() 

	if ( self.TauntCam:ShouldDrawLocalPlayer( self.Player, self.Player:IsPlayingTaunt() ) ) then return true end

end

function PLAYER:CreateMove( cmd )

	if ( self.TauntCam:CreateMove( cmd, self.Player, self.Player:IsPlayingTaunt() ) ) then return true end

end

function PLAYER:CalcView( view )

	if ( self.TauntCam:CalcView( view, self.Player, self.Player:IsPlayingTaunt() ) ) then return true end

end

player_manager.RegisterClass( "player_coop", PLAYER, "player_default" )
