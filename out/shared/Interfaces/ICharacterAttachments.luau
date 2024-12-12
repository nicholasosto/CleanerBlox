-- Compiled with roblox-ts v3.0.0
local CharacterAttachments
do
	CharacterAttachments = setmetatable({}, {
		__tostring = function()
			return "CharacterAttachments"
		end,
	})
	CharacterAttachments.__index = CharacterAttachments
	function CharacterAttachments.new(...)
		local self = setmetatable({}, CharacterAttachments)
		return self:constructor(...) or self
	end
	function CharacterAttachments:constructor(rig)
		self.Character = rig
		local _result = rig:FindFirstChild("Head")
		if _result ~= nil then
			_result = _result:FindFirstChild("HairAttachment")
		end
		self.Head = _result
		local _result_1 = rig:FindFirstChild("LeftHand")
		if _result_1 ~= nil then
			_result_1 = _result_1:FindFirstChild("LeftGripAttachment")
		end
		self.LeftHand = _result_1
		local _result_2 = rig:FindFirstChild("RightHand")
		if _result_2 ~= nil then
			_result_2 = _result_2:FindFirstChild("RightGripAttachment")
		end
		self.RightHand = _result_2
		local _result_3 = rig:FindFirstChild("LeftFoot")
		if _result_3 ~= nil then
			_result_3 = _result_3:FindFirstChild("LeftFootAttachment")
		end
		self.LeftFoot = _result_3
		local _result_4 = rig:FindFirstChild("RightFoot")
		if _result_4 ~= nil then
			_result_4 = _result_4:FindFirstChild("RightFootAttachment")
		end
		self.RightFoot = _result_4
		local _result_5 = rig:FindFirstChild("Floor")
		if _result_5 ~= nil then
			_result_5 = _result_5:FindFirstChild("FloorAttachment")
		end
		self.Floor = _result_5
		local _result_6 = rig:FindFirstChild("Halo")
		if _result_6 ~= nil then
			_result_6 = _result_6:FindFirstChild("HaloAttachment")
		end
		self.Halo = _result_6
		local _result_7 = rig:FindFirstChild("LowerTorso")
		if _result_7 ~= nil then
			_result_7 = _result_7:FindFirstChild("WaistCenterAttachment")
		end
		self.Body = _result_7
		if not self.Halo then
			self.Halo = Instance.new("Attachment")
			self.Halo.Name = "HaloAttachment"
			self.Halo.Position = Vector3.new(0, 2, 0)
			self.Halo.Parent = rig:FindFirstChild("Head")
		end
		if not self.Floor then
			self.Floor = Instance.new("Attachment")
			self.Floor.Name = "FloorAttachment"
			self.Floor.Position = Vector3.new(0, -2, 0)
			self.Floor.Parent = rig:FindFirstChild("HumanoidRootPart")
		end
		if not self.Head or not self.LeftHand or not self.RightHand or not self.LeftFoot or not self.RightFoot or not self.Floor or not self.Halo or not self.Body then
			error("CharacterAttachments: One or more attachments are missing")
		end
		return self
	end
end
return {
	CharacterAttachments = CharacterAttachments,
}
