-- THE WHOLE POINT OF THIS CLASS IS TO LOAD HEV HANDS!

DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

function PLAYER:GetHandsModel()

	return { model = "models/weapons/c_arms_hev.mdl", skin = 1, body = "0100000" }

end

player_manager.RegisterClass( "player_coop", PLAYER, "player_default" )
