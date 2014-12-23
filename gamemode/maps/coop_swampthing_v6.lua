RESET_PL_INFO = true

NEXT_MAP = "coop_swampthing_v6"

HL2MP_IS_COOP_MAP = true

hook.Add("InitPostEntity", "hl2cInitPostEntity", function()
	local endrelay = ents.FindByName("endrelay")
	endrelay[1]:Fire("addoutput", "OnTrigger hl2c_changelevel,Changelevel,,35,1")
end)