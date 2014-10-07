// Finds the player meta table or terminates
local meta = FindMetaTable("Player")
if !meta then return end

// Used to avoid errors when setting the bot's name
meta.RealPlayerNick = meta.Nick

// Remove vehicle the player currently owns
function meta:RemoveVehicle()
	if CLIENT || !self:IsValid() then 
		return
	end
	
	if self.vehicle && self.vehicle:IsValid() then
		self.vehicle:Remove()
	end
end

// Bots will be given a random name
function meta:Nick()
	if self.BotName then return self.BotName end
	if !self:IsBot() then return self:RealPlayerNick() end
	
	self.BotName = BOT_NAMES[math.random(1, #BOT_NAMES)]
	return self.BotName
end

// Player:Name() will return Player:Nick()
function meta:Name()
	return self:Nick()
end
