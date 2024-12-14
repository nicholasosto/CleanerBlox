-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
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
		local testFire = Instance.new("Fire")
		testFire.Parent = game.Workspace
		testFire.Size = 3
		testFire.Heat = 2
		testFire.Enabled = true
		local testClone = testFire:Clone()
		-- Halo Attachment
		if self.Halo == nil then
			self.Halo = Instance.new("Attachment")
			self.Halo.Name = "HaloAttachment"
			self.Halo.Parent = characterHead
			self.Halo.Position = Vector3.new(0, 1, 0)
			testClone.Parent = self.Halo
			Logger:Log("Halo", " - Constructed\n")
		end
		-- Body Attachment
		if self.Floor == nil then
			self.Floor = Instance.new("Attachment")
			self.Floor.Name = "FloorAttachment"
			self.Floor.Parent = self.Body
			self.Floor.Position = Vector3.new(0, -2, 0)
		end
		Logger:Log("EntityAttachments", " - Constructed\n")
	end
end
return {
	EntityAttachments = EntityAttachments,
}
