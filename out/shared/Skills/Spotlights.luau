-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local rotateModel = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "PartEffects").rotateModel
local SkillModels = {
	Spotlight = ReplicatedStorage:FindFirstChild("CastingSpotlight", true),
	Casting_Circle = ReplicatedStorage:FindFirstChild("CastingCircle", true),
}
local SkillConfiguration = ReplicatedStorage:FindFirstChild("Config_Spotlights", true)
local Sounds = SkillConfiguration:FindFirstChild("_Sounds")
local Animations = SkillConfiguration:FindFirstChild("_Animations")
local Models = SkillConfiguration:FindFirstChild("_Ref_Models")
local Spotlights
do
	local super = HoldableSkill
	Spotlights = setmetatable({}, {
		__tostring = function()
			return "Spotlights"
		end,
		__index = super,
	})
	Spotlights.__index = Spotlights
	function Spotlights.new(...)
		local self = setmetatable({}, Spotlights)
		return self:constructor(...) or self
	end
	function Spotlights:constructor(...)
		super.constructor(self, ...)
	end
	function Spotlights:initiate()
		print("Spotlights initiated")
		local numSpotlights = 3
		-- Get the casting FLOOR attachment
		local characterModel = self.Character.Instance
		local castingAttachment = characterModel:FindFirstChild("CastingFloor", true)
		print(castingAttachment.Position)
		-- Clone Model Parts
		-- (1) Casting Circle
		local castingCircle = SkillModels.Casting_Circle:Clone()
		castingCircle:PivotTo(castingAttachment.WorldCFrame)
		castingCircle.Parent = castingAttachment
		-- Spotlights
		local castingSpotlights = {}
		for i = 0, numSpotlights - 1 do
			local spotlight = SkillModels.Spotlight:Clone()
			table.insert(castingSpotlights, spotlight)
			--castingSpotlights[i].Parent = characterModel;
			--castingSpotlights[i].PivotTo(characterModel.GetPivot().mul(new CFrame(1, 1, 1.5)));
		end
	end
	function Spotlights:stage1()
		print("Spotlights stage 1")
	end
	function Spotlights:stage2()
		print("Spotlights stage 2")
	end
	function Spotlights:stage3()
		print("Spotlights stage 3")
		rotateModel(self.Character.Instance, 1)
	end
	function Spotlights:OnStartServer()
		warn("Spotlights Started")
		self:initiate()
	end
	function Spotlights:OnEndServer()
		warn("Spotlights Ended")
	end
	function Spotlights:OnConstructServer()
		warn("Spotlights Constructed")
		-- Set the Max Hold Time for the skill
		self:SetMaxHoldTime(5)
		-- Connect to the HoldTimer's secondReached event
		self.HoldTimer.secondReached:Connect(function(second)
			repeat
				if second == 3 then
					self:stage1()
					break
				end
				if second == 2 then
					self:stage2()
					break
				end
				if second == 1 then
					self:stage3()
					break
				end
				break
			until true
		end)
		self.HoldTimer:start()
	end
	Spotlights = SkillDecorator(Spotlights) or Spotlights
end
return {
	Spotlights = Spotlights,
}
