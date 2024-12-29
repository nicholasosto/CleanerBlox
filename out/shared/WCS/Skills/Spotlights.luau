-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local Workspace = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Workspace
local Spotlight = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Skill Parts", "Spotlight").Spotlight
local PositionGenerator = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "PositionGenerator").PositionGenerator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
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
		self.Cooldown = 10
		self.HoldTime = 5
		self.SkillId = "Spotlights"
		self.Spotlights = {}
	end
	function Spotlights:createSpotlight(cFrame)
		Logger:Log("Spotlights", "Creating Spotlight")
		local spotlightModel = GameStorage:cloneModel("Spotlight"):Clone()
		spotlightModel.Parent = Workspace
		spotlightModel:PivotTo(cFrame)
		local spotlight = Spotlight.new(spotlightModel)
	end
	function Spotlights:OnConstructServer()
		-- Set the Max Hold Time for the skill
		self:SetMaxHoldTime(5)
		-- Connect to the HoldTimer's secondReached event
		self.HoldTimer.secondReached:Connect(function(seconds)
			return self:stageActivated(seconds)
		end)
	end
	function Spotlights:OnStartServer()
		self:ApplyCooldown(10)
	end
	function Spotlights:stageActivated(stage)
		--Logger.Log("Stage Activated: ", stage, this.CooldownTimer.getTimeLeft());
		repeat
			if stage == 1 then
				self:Stage3()
				break
			end
			if stage == 2 then
				self:Stage2()
				break
			end
			if stage == 3 then
				self:Stage1()
				break
			end
			break
		until true
	end
	function Spotlights:Stage1()
		local spotlightPosition = PositionGenerator:GenerateDefaultTargetPosition(self.Character.Instance, 10)
		self:createSpotlight(CFrame.new(spotlightPosition))
		Logger:Log("Spotlights", "Stage 1", spotlightPosition)
	end
	function Spotlights:Stage2()
		Logger:Log("Spotlights", "Stage 2")
	end
	function Spotlights:Stage3()
		Logger:Log("Spotlights", "Stage 3")
	end
	function Spotlights:OnEndServer()
		Logger:Log("Spotlights", "End")
	end
	Spotlights = SkillDecorator(Spotlights) or Spotlights
end
return {
	Spotlights = Spotlights,
}
