-- Compiled with roblox-ts v3.0.0
local EntityAttachments
do
	EntityAttachments = setmetatable({}, {
		__tostring = function()
			return "EntityAttachments"
		end,
	})
	EntityAttachments.__index = EntityAttachments
	function EntityAttachments.new(...)
		local self = setmetatable({}, EntityAttachments)
		return self:constructor(...) or self
	end
	function EntityAttachments:constructor(character)
		self.Head = character:FindFirstChild("HatAttachment")
		self.LeftHand = character:FindFirstChild("LeftGripAttachment")
		self.RightHand = character:FindFirstChild("RightGripAttachment")
		self.LeftFoot = character:FindFirstChild("LeftFootAttachment")
		self.RightFoot = character:FindFirstChild("RightFootAttachment")
		self.Floor = character:FindFirstChild("FloorAttachment")
		self.Halo = character:FindFirstChild("HaloAttachment")
		self.Body = character:FindFirstChild("BodyAttachment")
	end
end
return {
	EntityAttachments = EntityAttachments,
}
