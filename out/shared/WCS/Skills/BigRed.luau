-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local CFrameGenerator = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "CFrameGenerator").CFrameGenerator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local cFrameGenerator = CFrameGenerator.new()
local BigRed
do
	local super = HoldableSkill
	BigRed = setmetatable({}, {
		__tostring = function()
			return "BigRed"
		end,
		__index = super,
	})
	BigRed.__index = BigRed
	function BigRed.new(...)
		local self = setmetatable({}, BigRed)
		return self:constructor(...) or self
	end
	function BigRed:constructor(...)
		super.constructor(self, ...)
	end
	function BigRed:OnConstructServer()
		Logger:Log("BigRed", "Construct")
	end
	function BigRed:OnStartServer()
		Logger:Log("BigRed", "Start")
	end
	function BigRed:stageActivated(stage)
		Logger:Log("BigRed", "Stage Activated: ", tostring(stage), tostring(self.CooldownTimer:getTimeLeft()))
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
	function BigRed:Stage1()
		Logger:Log("BigRed", "Stage 1")
	end
	function BigRed:Stage2()
		Logger:Log("BigRed", "Stage 2")
	end
	function BigRed:Stage3()
		Logger:Log("BigRed", "Stage 3")
	end
	function BigRed:OnEndServer()
		Logger:Log("BigRed", "End")
	end
	BigRed = SkillDecorator(BigRed) or BigRed
end
return {
	BigRed = BigRed,
}
