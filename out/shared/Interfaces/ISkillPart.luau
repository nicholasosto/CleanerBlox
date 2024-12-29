-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
-- Interfaces
-- Skill Part States
local ESkillPartState = {
	Spawning = "Spawning",
	Active = "Active",
	Triggered = "Triggered",
	Ending = "Ending",
}
-- Example Skill Part Class (Template)
local TestPart
do
	TestPart = setmetatable({}, {
		__tostring = function()
			return "TestPart"
		end,
	})
	TestPart.__index = TestPart
	function TestPart.new(...)
		local self = setmetatable({}, TestPart)
		return self:constructor(...) or self
	end
	function TestPart:constructor(spawnCFrame, targetCFrame, owner)
		self.SkillPartModel = GameStorage:cloneModel("TestPart")
		self.PartState = "Spawning"
		self.HealthChangeAmount = 0
		self._primaryPart = self.SkillPartModel.PrimaryPart
		self._hitPart = self.SkillPartModel:FindFirstChild("HitPart")
		-- Check if the primary part, hit part, and skill part model exist
		if not self._primaryPart or not self._hitPart or not self.SkillPartModel then
			error("PrimaryPart, HitPart, or SkillPartModel not found")
		end
		-- Set the CFrames
		self.SpawnCFrame = spawnCFrame
		self.TargetCFrame = targetCFrame
		-- Set the Owner
		if owner then
			self.Owner = owner
		else
			self.Owner = GameStorage:cloneModel("TestOwner")
		end
		-- Log the creation of the skill part instance
		Logger:Log("SkillPart", self.SkillPartModel.Name, "Created")
		return self
	end
	function TestPart:OnStart()
		Logger:Log("SkillPart", self.SkillPartModel.Name, "OnStart")
	end
	function TestPart:WhileActive()
		Logger:Log("SkillPart", self.SkillPartModel.Name, "WhileActive")
	end
	function TestPart:OnEnd()
		Logger:Log("SkillPart", self.SkillPartModel.Name, "OnEnd")
	end
end
return {
	ESkillPartState = ESkillPartState,
	TestPart = TestPart,
}
