-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local Character = _wcs.Character
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local ReplicatedStorage = _services.ReplicatedStorage
local Workspace = _services.Workspace
local Spotlight = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Creations", "Spotlight").Spotlight
local CFrameGenerator = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "CFrameGenerator").CFrameGenerator
local AnimationManager = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "AnimationManager").AnimationManager
local SkillConfiguration = ReplicatedStorage:FindFirstChild("Config_Spotlights", true)
local cFrameGenerator = CFrameGenerator.new()
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
		self.Spotlights = {}
	end
	function Spotlights:ToadDance()
		local _exp = Workspace:WaitForChild("ToadArmy"):GetChildren()
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _callback = function(child)
			return child:IsA("Model")
		end
		local _length = 0
		for _k, _v in _exp do
			if _callback(_v, _k - 1, _exp) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		local toadies = _newValue
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(toadie)
			local wcsToadie = Character.GetCharacterFromInstance(toadie)
			AnimationManager:PlayAnimationFor(wcsToadie, "DanteBackflip")
		end
		for _k, _v in toadies do
			_callback_1(_v, _k - 1, toadies)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function Spotlights:OnConstructServer()
		-- Set the Max Hold Time for the skill
		self:SetMaxHoldTime(5)
		-- Connect to the HoldTimer's secondReached event
		self.HoldTimer.secondReached:Connect(function(seconds)
			return self:stageActivated(seconds)
		end)
		AnimationManager:RegisterAnimationsFor(self.Character)
	end
	function Spotlights:OnStartServer()
		self:ToadDance()
		task.wait(0.1)
		AnimationManager:PlayAnimationFor(self.Character, "Godlike")
	end
	function Spotlights:stageActivated(stage)
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
		local userCFrame = (self.Character.Instance):GetPivot()
		local spotlight = Spotlight.new(cFrameGenerator:createTargetFrame(userCFrame, 10), self.Character.Instance)
		local PrimaryPart = spotlight.instance.PrimaryPart
		if not PrimaryPart then
			error("PrimaryPart not found")
		end
		PrimaryPart.Anchored = true
		local _exp = self.Spotlights
		table.insert(_exp, spotlight)
		print("Stage 1 User CFrame: ", userCFrame)
	end
	function Spotlights:Stage2()
		local userCFrame = (self.Character.Instance):GetPivot()
		local spotlightCFrames = cFrameGenerator:createRing(userCFrame, 10, 8)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(cFrame)
			local spotlight = Spotlight.new(cFrame, self.Character.Instance)
			local PrimaryPart = spotlight.instance.PrimaryPart
			if not PrimaryPart then
				error("PrimaryPart not found")
			end
			PrimaryPart.Anchored = true
			local _exp = self.Spotlights
			table.insert(_exp, spotlight)
		end
		for _k, _v in spotlightCFrames do
			_callback(_v, _k - 1, spotlightCFrames)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function Spotlights:Stage3()
		local userCFrame = (self.Character.Instance):GetPivot()
		local spotlightCFrames = cFrameGenerator:createRing(userCFrame, 50, 18)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(cFrame)
			local spotlight = Spotlight.new(cFrame, self.Character.Instance)
			local PrimaryPart = spotlight.instance.PrimaryPart
			if not PrimaryPart then
				error("PrimaryPart not found")
			end
			PrimaryPart.Anchored = true
			local _exp = self.Spotlights
			table.insert(_exp, spotlight)
		end
		for _k, _v in spotlightCFrames do
			_callback(_v, _k - 1, spotlightCFrames)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function Spotlights:OnEndServer()
		warn("Spotlights Ended")
		self.Character.Humanoid.WalkSpeed = 16
		local _exp = self.Spotlights
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(spotlight)
			spotlight:Destroy()
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
