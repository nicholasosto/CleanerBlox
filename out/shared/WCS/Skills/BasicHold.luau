-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local BasicHold
do
	local super = HoldableSkill
	BasicHold = setmetatable({}, {
		__tostring = function()
			return "BasicHold"
		end,
		__index = super,
	})
	BasicHold.__index = BasicHold
	function BasicHold.new(...)
		local self = setmetatable({}, BasicHold)
		return self:constructor(...) or self
	end
	function BasicHold:constructor(...)
		super.constructor(self, ...)
	end
	function BasicHold:OnConstruct()
		self:SetMaxHoldTime(BasicHold.SkillConfiguration.DefaultHoldTime)
	end
	function BasicHold:OnConstructClient()
		Logger:Log("BasicHold", "OnConstructClinet")
	end
	function BasicHold:OnStartServer()
		self:ApplyCooldown(BasicHold.SkillConfiguration.DefaultCooldownTime)
		-- Cooldown Timer
		self.CooldownTimer.secondReached:Connect(function(seconds)
			Logger:Log(self:GetName(), `Cooldown: {seconds}\n`)
		end)
		-- Hold Timer
		self.HoldTimer.secondReached:Connect(function(seconds)
			return self:_holdTimerReached(seconds)
		end)
	end
	function BasicHold:_holdTimerReached(seconds)
		Logger:Log("BasicHold", `Hold: {seconds}\n`)
		--const devilBeamTool = GameStorage.cloneTool("DevilBeam");
		repeat
			if seconds == 1 then
				self:Stage1()
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
	function BasicHold:ActivationStage()
		Logger:Log("BasicHold", "Activation Stage\n")
	end
	function BasicHold:Stage1()
		Logger:Log(self:GetName(), "Stage 01 called\n")
	end
	function BasicHold:Stage2()
		Logger:Log(self:GetName(), "Stage 02 called\n")
	end
	function BasicHold:Stage3()
		Logger:Log(self:GetName(), "Stage 03 called\n")
	end
	function BasicHold:OnEndServer()
		Logger:Log(self:GetName(), "OnEndServer\n")
	end
	BasicHold.SkillConfiguration = {
		DisplayName = "Clean Skill",
		ImageId = "rbxassetid://132928610589952",
		ActivationTime = 1,
		DefaultHealthChange = 0,
		DefaultHoldTime = 5,
		DefaultCooldownTime = 3,
		DefaultManaCost = 10,
		DefaultStaminaCost = 10,
	}
	BasicHold = SkillDecorator(BasicHold) or BasicHold
end
return {
	BasicHold = BasicHold,
}
