-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Workspace = _services.Workspace
local TweenService = _services.TweenService
local CFrameGenerator = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "CFrameGenerator").CFrameGenerator
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "GameStorage").GameStorage
local Spotlight
do
	Spotlight = setmetatable({}, {
		__tostring = function()
			return "Spotlight"
		end,
	})
	Spotlight.__index = Spotlight
	function Spotlight.new(...)
		local self = setmetatable({}, Spotlight)
		return self:constructor(...) or self
	end
	function Spotlight:constructor(cFrame, character)
		-- Set the instance
		self.instance = Spotlight.template:Clone()
		self.Character = character
		print("Spotlight Instance: ", self.instance, cFrame)
		self.PrimaryPart = self.instance.PrimaryPart
		self.HitPart = self.instance:FindFirstChild("HitPart")
		self.CFrame = cFrame
		self.instance.Parent = Workspace
		self.instance:PivotTo(cFrame)
		-- Set the Attribute "State" to "UNK"
		self.instance:SetAttribute("State", "UNK")
		self.SpotlightTween = self:CreateRandomTween()
		self.HomingTween = self:CreateHomingTween()
		-- Listen for property changes
		self.HitConnection = self.PrimaryPart.Touched:Connect(function(hit)
			return self:handlePartTouched(hit)
		end)
		-- Listen for state changes
		self.StateChangeConnection = self.instance:GetAttributeChangedSignal("State"):Connect(function()
			return self:OnStateChanged()
		end)
		-- Set the State to Idle
		self.instance:SetAttribute("State", "Idle")
		return self
	end
	function Spotlight:handlePartTouched(hit)
		local parent = hit.Parent
		if not parent then
			return nil
		end
		if not parent:FindFirstChild("Humanoid") then
			return nil
		end
		if parent == self.Character then
			return nil
		end
		self.Target = parent
		self.instance:SetAttribute("State", "Triggered")
	end
	function Spotlight:CreateRandomTween()
		local hitPart = self.PrimaryPart
		-- Tween Properties
		local _duration = 2
		local _easingStyle = Enum.EasingStyle.Linear
		local _easingDirection = Enum.EasingDirection.InOut
		local _repeatCount = -1
		local _reverses = false
		-- Create the TweenInfo object
		local tweenInfo = TweenInfo.new(_duration, _easingStyle, _easingDirection, _repeatCount, _reverses)
		-- Spotlight Base Position
		if not self.CFrame then
			return nil
		end
		-- Randomize the Goal Position
		local _cFrame = self.CFrame
		local _cFrame_1 = CFrame.new(math.random(-30, 30), 0, math.random(-30, 30))
		local GoalCFrame = _cFrame * _cFrame_1
		-- Create the Tween
		local spotlightTween = TweenService:Create(hitPart, tweenInfo, {
			CFrame = GoalCFrame,
		})
		return spotlightTween
	end
	function Spotlight:CreateHomingTween()
		local hitPart = self.PrimaryPart
		-- Tween Properties
		local _duration = 1
		local _easingStyle = Enum.EasingStyle.Linear
		local _easingDirection = Enum.EasingDirection.InOut
		local _repeatCount = -1
		local _reverses = false
		-- Create the TweenInfo object
		local tweenInfo = TweenInfo.new(_duration, _easingStyle, _easingDirection, _repeatCount, _reverses)
		-- Spotlight Base Position
		if not self.CFrame then
			return nil
		end
		-- Create the Tween
		if not self.Target then
			warn("Target not found")
			return nil
		end
		local goalFrame = self.Target:GetPivot()
		local homingTween = TweenService:Create(hitPart, tweenInfo, {
			CFrame = goalFrame,
		})
		return homingTween
	end
	function Spotlight:OnStateChanged()
		print("State Changed: ", (self.instance:GetAttribute("State")))
		local _exp = self.instance:GetAttribute("State")
		repeat
			if _exp == "Idle" then
				self:OnIdle()
				break
			end
			if _exp == "Triggered" then
				self:OnTriggered()
				break
			end
			if _exp == "Inactive" then
				print("TODO: Spotlight is Inactive")
				break
			end
			if _exp == "Homing" then
				self:OnHoming()
				break
			end
			if _exp == "Exploding" then
				self:OnExploding()
				break
			end
			break
		until true
	end
	function Spotlight:OnIdle()
		print("Spotlight is Idle")
		local PrimaryPart = self.PrimaryPart
		if not PrimaryPart then
			return nil
		end
		PrimaryPart.Color = Color3.fromRGB(255, 255, 255)
		print("Tween Play: ", self.SpotlightTween)
		local _result = self.SpotlightTween
		if _result ~= nil then
			_result:Play()
		end
	end
	function Spotlight:OnExploding()
		print("Spotlight is Exploding")
		local PrimaryPart = self.PrimaryPart
		PrimaryPart.Color = Color3.fromRGB(74, 74, 135)
		local _result = self.Target
		if _result ~= nil then
			_result = _result:FindFirstChild("Humanoid")
		end
		local humanoidTarget = _result
		if humanoidTarget then
			humanoidTarget:TakeDamage(110)
		end
		self.instance:Destroy()
	end
	function Spotlight:OnTriggered()
		print("Spotlight is Triggered")
		local HitPart = self.HitPart
		HitPart.Color = Color3.fromRGB(255, 0, 0)
		self.instance:SetAttribute("State", "Homing")
	end
	function Spotlight:OnHoming()
		print("Spotlight is Homing")
		local PrimaryPart = self.PrimaryPart
		PrimaryPart.Color = Color3.fromRGB(0, 255, 0)
		self.HomingTween = self:CreateHomingTween()
		local _result = self.HomingTween
		if _result ~= nil then
			_result = _result.Completed:Connect(function()
				self.instance:SetAttribute("State", "Exploding")
			end)
		end
		local _result_1 = self.HomingTween
		if _result_1 ~= nil then
			_result_1:Play()
		end
	end
	function Spotlight:Destroy()
		local _result = self.HitConnection
		if _result ~= nil then
			_result:Disconnect()
		end
		local _result_1 = self.StateChangeConnection
		if _result_1 ~= nil then
			_result_1:Disconnect()
		end
		local state = self.instance:GetAttribute("State")
		local PrimaryPart = self.PrimaryPart
		self.instance:Destroy()
		--this.Destroy();
	end
	Spotlight.template = GameStorage:getModel("Spotlight"):Clone()
	Spotlight.cFrameGenerator = CFrameGenerator.new()
end
return {
	Spotlight = Spotlight,
}
