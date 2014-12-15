// Finds the player meta table or terminates
local meta = FindMetaTable("Player")
if !meta then return end

// Remove vehicle the player currently owns
function meta:RemoveVehicle()
	if CLIENT || !self:IsValid() then 
		return
	end
	
	if self.vehicle && self.vehicle:IsValid() then
		self.vehicle:Remove()
	end
end
