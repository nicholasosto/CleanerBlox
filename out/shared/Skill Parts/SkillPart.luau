-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local TweenService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").TweenService
local SkillPartState = {
	Spawning = "Spawning",
	Active = "Active",
	Triggered = "Triggered",
	Ending = "Ending",
}
local SkillPartClass
do
	SkillPartClass = setmetatable({}, {
		__tostring = function()
			return "SkillPartClass"
		end,
	})
	SkillPartClass.__index = SkillPartClass
	function SkillPartClass.new(...)
		local self = setmetatable({}, SkillPartClass)
		return self:constructor(...) or self
	end
	function SkillPartClass:constructor(model)
		self.State = SkillPartState.Spawning
		self._vectorForce = Instance.new("VectorForce")
		-- Dummy VectorForce
		self._vectorForce.Force = Vector3.new(0, 2990, 0)
		self._vectorForce.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
		self._vectorForce.ApplyAtCenterOfMass = true
		self._vectorForce.Name = "DummyVectorForce"
		-- Set the instance
		self.instance = model
		self._primaryPart = model.PrimaryPart
		self._hitPart = model:FindFirstChild("HitPart")
		if not self._hitPart or not self._primaryPart then
			Logger:Log("SkillPart", "HitPart not found", model.Name)
			error("HitPart not found in SkillPart")
		end
		-- Set the Initial State
		self:transitionTo(SkillPartState.Spawning)
		-- Hit Connection
		self._hitConnection = self._hitPart.Touched:Connect(function(hit)
			local attachment = hit:FindFirstChildOfClass("Attachment")
			if not attachment then
				return nil
			end
			self._vectorForce.Attachment0 = attachment
			self._vectorForce.Parent = hit
			self._vectorForce.Enabled = true
			self:transitionTo(SkillPartState.Triggered)
		end)
		return self
	end
	function SkillPartClass:transitionTo(newState)
		-- Example: simple state transition with a switch for any specific logic
		self.State = newState
		repeat
			if newState == "Spawning" then
				self:onSpawn()
				break
			end
			if newState == "Active" then
				self:onActivate()
				break
			end
			if newState == "Triggered" then
				self:onTrigger()
				break
			end
			if newState == "Ending" then
				self:onEnd()
				break
			end
		until true
	end
	function SkillPartClass:onSpawn()
		self._hitPart.Color = Color3.fromRGB(255, 222, 220)
		Logger:Log("SkillPart", "Spawn!", self.State)
		-- Add any initialization or setup logic here
		task.wait(2)
		self:transitionTo(SkillPartState.Active)
	end
	function SkillPartClass:onActivate()
		self._hitPart.Color = Color3.fromRGB(255, 22, 220)
		task.spawn(function()
			while self.State == SkillPartState.Active do
				print("Active")
				local randomX = math.random(-10, 10)
				local randomZ = math.random(-10, 10)
				local _cFrame = self._primaryPart.CFrame
				local _vector3 = Vector3.new(randomX, 0, randomZ)
				local goalCFrame = _cFrame + _vector3
				local goal = {
					CFrame = goalCFrame,
				}
				local tween = TweenService:Create(self._primaryPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), goal)
				tween:Play()
				tween.Completed:Connect(function()
					tween:Destroy()
				end)
				task.wait(2)
			end
		end)
		local randomX = math.random(-10, 10)
		local randomZ = math.random(-10, 10)
		local _cFrame = self._primaryPart.CFrame
		local _vector3 = Vector3.new(randomX, 0, randomZ)
		local goalCFrame = _cFrame + _vector3
		local goal = {
			CFrame = goalCFrame,
		}
		local tween = TweenService:Create(self._primaryPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), goal)
		tween:Play()
		Logger:Log("SkillPart", "onEnd", self.State)
		-- Add logic for when the skill becomes active
	end
	function SkillPartClass:onTrigger()
		Logger:Log("SkillPart", "onEnd", self.State)
		self._hitPart.Color = Color3.fromRGB(255, 0, 0)
		task.wait(2)
		self:transitionTo(SkillPartState.Active)
		-- Add logic for triggered behavior (like firing a projectile or applying an effect)
	end
	function SkillPartClass:onEnd()
		Logger:Log("SkillPart", "onEnd", self.State)
		-- Add cleanup logic here
	end
end
return {
	SkillPartState = SkillPartState,
	SkillPartClass = SkillPartClass,
}
