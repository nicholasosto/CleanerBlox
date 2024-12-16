-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local SkillConfigurations = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Interfaces", "SkillConfigurations").SkillConfigurations
local HttpService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").HttpService
-- AnimationID = 132928610589952 DevilBeam Fired
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
		self._animationInstance = GameStorage:getAnimation("DevilBeam Fired")
		self._animationTrack = self.Character.Humanoid:LoadAnimation(self._animationInstance)
		self.SkillConfiguration = SkillConfigurations.DevilBeam
		self.DisplayName = "Devil Beam"
		self._defaultHoldTime = 5
		self._defaultCooldownTime = 3
		self._defaultManaCost = 10
		self._defaultStaminaCost = 10
	end
	function DevilBeam:OnConstructServer()
		-- Load Animations and Particles
		--Logger.Log("DevilBeam", " - Constructed\n");
		local humanoid = self.Character.Humanoid
		if humanoid == nil then
			Logger:Log("DevilBeam", " - Humanoid Not Found\n")
			return nil
		end
		-- Load Animation
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if animator then
			Logger:Log("DevilBeam", "Animator Found\n")
			return nil
		end
		local animation = GameStorage:getAnimation("DevilBeam Fired")
		warn(animation.AnimationId, " loaded")
		if animation then
			Logger:Log("DevilBeam", "Animation Found\n")
			return nil
		else
			Logger:Log("DevilBeam", "Animation Not Found\n")
		end
	end
	function DevilBeam:OnConstructClient()
		--Logger.Log("DevilBeam", " - Constructed\n");
		Logger:Log(HttpService:JSONEncode(self.Name))
	end
	function DevilBeam:OnStartServer()
		-- Apply Cooldown and Hold Time
		--this.AbilityModelInstance = new AbilityModel(this.Character, GameStorage.getModel("DevilBeam"));
		self:ApplyCooldown(self._defaultCooldownTime)
		self:SetMaxHoldTime(self._defaultHoldTime)
		-- Cooldown Timer
		self.CooldownTimer.secondReached:Connect(function(seconds)
			Logger:Log(self:GetName(), `Cooldown: {seconds}\n`)
		end)
		-- Hold Timer
		self.HoldTimer.secondReached:Connect(function(seconds)
			return self:stageActivated(seconds)
		end)
		local characterModel = self.Character.Instance
		local humnoidRootPart = characterModel:FindFirstChild("HumanoidRootPart")
		local _rightHand = self.Character.Instance:FindFirstChild("RightHand")
		humnoidRootPart.Anchored = true
		task.delay(10, function()
			humnoidRootPart.Anchored = false
		end)
	end
	function DevilBeam:stageActivated(seconds)
		Logger:Log(self:GetName(), "\n--------  Stage Activated Server  --------\n")
		local devilBeamTool = GameStorage:cloneTool("DevilBeam")
		repeat
			if seconds == 1 then
				--this.AbilityModelInstance.Activate(3);
				devilBeamTool.Parent = self.Character.Instance
				break
			end
			if seconds == 2 then
				self:Stage2()
				--this.AbilityModelInstance.Activate(2);
				break
			end
			if seconds == 3 then
				self:Stage1()
				--this.AbilityModelInstance.Activate(1);
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
		--this.AbilityModelInstance.OnEnded();
	end
	function DevilBeam:_loadAnimation()
		local animation = GameStorage:getAnimation("DevilBeam Fired")
		if animation then
			Logger:Log("DevilBeam", "Animation Found\n")
			return nil
		else
			Logger:Log("DevilBeam", "Animation Not Found\n")
		end
	end
	DevilBeam = SkillDecorator(DevilBeam) or DevilBeam
end
return {
	DevilBeam = DevilBeam,
}
