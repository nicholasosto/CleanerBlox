-- Compiled with roblox-ts v3.0.0
local AttachmentPoints = {
	Head = "Head",
	LeftHand = "LeftHand",
	RightHand = "RightHand",
	LeftFoot = "LeftFoot",
	RightFoot = "RightFoot",
	Floor = "Floor",
	Halo = "Halo",
	Body = "Body",
}
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
		local characterHead = character:WaitForChild("Head")
		self.Head = character:FindFirstChild("HatAttachment")
		self.LeftHand = character:FindFirstChild("LeftGripAttachment")
		self.RightHand = character:FindFirstChild("RightGripAttachment")
		self.LeftFoot = character:FindFirstChild("LeftFootAttachment")
		self.RightFoot = character:FindFirstChild("RightFootAttachment")
		self.Floor = character:FindFirstChild("FloorAttachment")
		self.Halo = character:FindFirstChild("HaloAttachment")
		self.Body = character:FindFirstChild("BodyAttachment")
		-- Halo Attachment
		if self.Halo == nil then
			self.Halo = Instance.new("Attachment")
			self.Halo.Name = "HaloAttachment"
			self.Halo.Parent = characterHead
			self.Halo.Position = Vector3.new(0, 1, 0)
		end
		-- Body Attachment
		if self.Floor == nil then
			self.Floor = Instance.new("Attachment")
			self.Floor.Name = "FloorAttachment"
			self.Floor.Parent = self.Body
			self.Floor.Position = Vector3.new(0, -2, 0)
		end
	end
end
return {
	AttachmentPoints = AttachmentPoints,
	EntityAttachments = EntityAttachments,
}
