-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local SkillConfigurations = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Interfaces", "SkillConfigurations").SkillConfigurations
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local HttpService = _services.HttpService
local TweenService = _services.TweenService
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
		self.SkillConfiguration = SkillConfigurations.DevilBeam
		self.DisplayName = "Devil Beam"
		self.ActivationTime = 1
		self._defaultHoldTime = 5
		self._defaultCooldownTime = 3
		self._defaultManaCost = 10
		self._defaultStaminaCost = 10
	end
	function DevilBeam:OnConstructServer()
		-- Load Animations and Particles
		--Logger.Log("DevilBeam", " - Constructed\n");
		local humanoid = self.Character.Humanoid
		local _animator = humanoid
		if _animator ~= nil then
			_animator = _animator:FindFirstChildOfClass("Animator")
		end
		local animator = _animator
		local animation = GameStorage:getAnimation("DevilBeam Fired")
		local _result = animator
		if _result ~= nil then
			_result = _result:LoadAnimation(animation)
		end
		self._animationTrack = _result
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
		local characterModel = self.Character.Instance
		local primartyPart = characterModel.PrimaryPart
		if self._animationTrack then
			primartyPart.Anchored = true
			local animationSpeed = self._animationTrack.Length / self.ActivationTime
			self._animationTrack:Play()
			self._animationTrack:AdjustSpeed(animationSpeed)
		end
		task.delay(self.ActivationTime, function()
			primartyPart.Anchored = false
		end)
		local hitPart = self.Character.Instance:FindFirstChild("HitPart", true)
		local tweenInfo = TweenInfo.new(self.ActivationTime, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
		local _object = {
			Size = Vector3.new(3, 30, 3),
		}
		local _left = "CFrame"
		local _exp = hitPart.Position
		local _position = hitPart.Position
		local _vector3 = Vector3.new(0, 30, 0)
		_object[_left] = CFrame.new(_exp, _position + _vector3)
		local tween = TweenService:Create(hitPart, tweenInfo, _object)
		tween:Play()
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
	end
	function DevilBeam:stageActivated(seconds)
		Logger:Log(self:GetName(), "\n--------  Stage Activated Server  --------\n")
		--const devilBeamTool = GameStorage.cloneTool("DevilBeam");
		repeat
			if seconds == 1 then
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
