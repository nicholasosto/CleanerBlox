-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local Message = _wcs.Message
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local AnimationsFolder = ReplicatedStorage:FindFirstChild("Melee Unarmed", true)
local _exp = AnimationsFolder:GetChildren()
-- ▼ ReadonlyArray.map ▼
local _newValue = table.create(#_exp)
local _callback = function(animation)
	return animation
end
for _k, _v in _exp do
	_newValue[_k] = _callback(_v, _k - 1, _exp)
end
-- ▲ ReadonlyArray.map ▲
local Animations = _newValue
local Block
do
	local super = HoldableSkill
	Block = setmetatable({}, {
		__tostring = function()
			return "Block"
		end,
		__index = super,
	})
	Block.__index = Block
	function Block.new(...)
		local self = setmetatable({}, Block)
		return self:constructor(...) or self
	end
	function Block:constructor(...)
		super.constructor(self, ...)
	end
	function Block:ClientCode()
		warn("Block Activated")
	end
	function Block:OnStartServer()
		warn("Block Started")
		local humanoid = self.Character.Humanoid
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if not animator then
			warn("Animator not found")
			return nil
		end
		local animationTrack = animator:LoadAnimation(Animations[2])
		--animationTrack.Play();
	end
	function Block:OnEndServer()
		warn("Block Ended")
	end
	function Block:OnConstructServer()
		warn("Block Constructed")
		self:SetMaxHoldTime(3)
		self.HoldTimer.secondReached:Connect(function(second)
			warn("Block Held: ", second)
		end)
		self.HoldTimer:start()
	end
	local _descriptor = Message({
		Type = "Event",
		Destination = "Client",
	})(Block, "ClientCode", {
		value = Block.ClientCode,
	})
	if _descriptor then
		Block.ClientCode = _descriptor.value
	end
	Block = SkillDecorator(Block) or Block
end
return {
	Block = Block,
}
