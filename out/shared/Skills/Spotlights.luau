-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local Spotlight = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Spotlight").Spotlight
local _TCFrame = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "TCFrame")
local FormationFrames = _TCFrame.FormationFrames
local TCFrame = _TCFrame.TCFrame
local SkillConfiguration = ReplicatedStorage:FindFirstChild("Config_Spotlights", true)
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
		self.Attachments = {}
	end
	function Spotlights:OnConstructServer()
		-- Set the Max Hold Time for the skill
		self:SetMaxHoldTime(5)
	end
	function Spotlights:OnStartServer()
		task.wait(0.3)
		-- Generate the attachments
		local character = self.Character.Instance
		local sourceAttachment = character:FindFirstChild("CastingFloor", true)
		self.Attachments = TCFrame:generateAttachments(sourceAttachment, FormationFrames.Line, false)
		-- Connect to the HoldTimer's secondReached event
		self.HoldTimer.secondReached:Connect(function(seconds)
			return self:stageActivated(seconds)
		end)
	end
	function Spotlights:stageActivated(stage)
		repeat
			if stage == 1 then
				self:Stage1()
				break
			end
			if stage == 2 then
				self:Stage2()
				break
			end
			if stage == 3 then
				self:Stage3()
				break
			end
			break
		until true
	end
	function Spotlights:Stage1()
		for i = 1, #self.Attachments - 1 do
			local attachment = self.Attachments[i + 1]
			local spotlight = Spotlight.new(self.Character.Instance, attachment)
			spotlight:SpawnSpotlight()
		end
	end
	function Spotlights:Stage2()
		print("Stage 2")
	end
	function Spotlights:Stage3()
		print("Stage 3")
	end
	function Spotlights:OnEndServer()
		warn("Spotlights Ended")
		self.Character.Humanoid.WalkSpeed = 16
		local _exp = self.Attachments
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(attachment)
			return attachment:Destroy()
		end
		for _k, _v in _exp do
			_callback(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	Spotlights = SkillDecorator(Spotlights) or Spotlights
end
return {
	Spotlights = Spotlights,
}
