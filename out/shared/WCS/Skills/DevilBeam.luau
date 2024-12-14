-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local DevilBeam
do
	local super = HoldableSkill
	DevilBeam = setmetatable({}, {
		__tostring = function()
			return "DevilBeam"
		end,
		__index = super,
	})
	DevilBeam.__index = DevilBeam
	function DevilBeam.new(...)
		local self = setmetatable({}, DevilBeam)
		return self:constructor(...) or self
	end
	function DevilBeam:constructor(...)
		super.constructor(self, ...)
		self.DisplayName = "Devil Beam"
		self._defaultHoldTime = 5
		self._defaultCooldownTime = 3
		self._defaultManaCost = 10
		self._defaultStaminaCost = 10
	end
	function DevilBeam:OnConstructServer()
		-- Load Animations and Particles
		Logger:Log("DevilBeam", " - Constructed\n")
	end
	function DevilBeam:OnStartServer()
		self:ApplyCooldown(self._defaultCooldownTime)
		self:SetMaxHoldTime(self._defaultHoldTime)
		Logger:Log(self:GetName(), " - Skill Started\n")
		self.HoldTimer.secondReached:Connect(function(seconds)
			return self:stageActivated(seconds)
		end)
	end
	function DevilBeam:stageActivated(seconds)
		Logger:Log(self:GetName(), "\n--------  Stage Activated Server  --------\n")
		repeat
			if seconds == 1 then
				self:Stage3()
				break
			end
			if seconds == 2 then
				self:Stage2()
				break
			end
			if seconds == 3 then
				self:Stage1()
				break
			end
			break
		until true
	end
	function DevilBeam:Stage1()
		Logger:Log(self:GetName(), " - Stage 01 called\n")
	end
	function DevilBeam:Stage2()
		Logger:Log(self:GetName(), " - Stage 02 called\n")
	end
	function DevilBeam:Stage3()
		Logger:Log(self:GetName(), " - Stage 03 called\n")
	end
	function DevilBeam:OnEndServer()
		Logger:Log(self:GetName(), "\n--------  Stage Activated Server  --------\n")
	end
	DevilBeam = SkillDecorator(DevilBeam) or DevilBeam
end
return {
	DevilBeam = DevilBeam,
}
