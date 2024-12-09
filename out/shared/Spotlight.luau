-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local ReplicatedStorage = _services.ReplicatedStorage
local Workspace = _services.Workspace
local TweenService = _services.TweenService
local SoulSteelStorage = ReplicatedStorage:FindFirstChild("SoulSteelStorage", true)
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
	function Spotlight:constructor(character, attachment)
		self.imageId = "rbxassetid://82703415014111"
		-- Validate the model and configuration
		-- Model Validation
		local _result = SoulSteelStorage:FindFirstChild("Spotlight", true)
		if _result ~= nil then
			_result = _result:Clone()
		end
		local _spotlightModel = _result
		local _spotlightConfiguration = _spotlightModel:FindFirstChildOfClass("Configuration")
		local _hitpart = _spotlightModel:FindFirstChild("HitPart")
		if not _spotlightModel or not _spotlightConfiguration or not _hitpart then
			error("Spotlight model or configuration not found.")
		end
		-- Initialize the spotlight
		self.instance = _spotlightModel
		self.hitPart = _hitpart
		self.instance.PrimaryPart = self.hitPart
		self.Character = character
		self.AttachmentParent = attachment
		-- Initialize the StateValue reference object
		self.StateValue = _spotlightConfiguration:FindFirstChild("State")
		-- Listen for property changes
		self:InitializePropertyChangeListeners()
		-- Set the initial state
		self.StateValue.Value = "Idle"
		return self
	end
	function Spotlight:InitializePropertyChangeListeners()
		-- State Value Changed
		self.StateValue:GetPropertyChangedSignal("Value"):Connect(function()
			self:OnStateChanged()
		end)
		-- Hit Part Touched
		self.hitPart.Touched:Connect(function(hit)
			print("Hit Part Touched")
			local _condition = hit.Parent ~= self.Character
			if _condition then
				local _result = hit.Parent
				if _result ~= nil then
					_result = _result:IsA("Model")
				end
				_condition = _result
			end
			if _condition then
				self.hitPart.Color = Color3.fromRGB(255, 0, 0)
				self.StateValue.Value = "Triggered"
			end
		end)
	end
	function Spotlight:OnStateChanged()
		local _exp = self.StateValue.Value
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
				self:OnInactive()
				break
			end
			break
		until true
	end
	function Spotlight:OnIdle()
		print("Spotlight is Idle")
		local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local _result = self.instance.PrimaryPart
		if _result ~= nil then
			_result = _result.Position
		end
		local spotlightBasePosition = _result
		local tweenService = TweenService
		--TweenTest
		local part = Instance.new("Part")
		part.Size = Vector3.new(4, 4, 4)
		part.Anchored = false
		part.Position = Vector3.new(0, 10, 0)
		part.Parent = Workspace
		local testTween = TweenService:Create(part, TweenInfo.new(2), {
			Position = Vector3.new(20, 10, 0),
		})
		testTween:Play()
		--TweenTest
		local moveSpotlight
		moveSpotlight = function()
			if self.StateValue.Value ~= "Idle" then
				return nil
			end
			local randomOffset = Vector3.new(math.random(-20, 20), math.random(0, 2), math.random(-20, 20))
			local targetPosition = spotlightBasePosition + randomOffset
			-- Ensure the CFrame is constructed with the target position
			local targetCFrame = CFrame.new(targetPosition)
			-- Create the tween to move the spotlight
			local _exp = self.instance.PrimaryPart
			local _object = {}
			local _left = "CFrame"
			local _arg0 = CFrame.Angles(0, 0, math.rad(90))
			_object[_left] = targetCFrame * _arg0
			local tween = tweenService:Create(_exp, tweenInfo, _object)
			tween.Completed:Connect(function()
				if self.StateValue.Value == "Idle" then
					print("Spotlight has reached the target position")
					moveSpotlight()
				end
			end)
			tween:Play()
		end
		moveSpotlight()
	end
	function Spotlight:OnTriggered()
		print("Spotlight is Triggered")
	end
	function Spotlight:OnInactive()
		print("Spotlight is Inactive")
	end
	function Spotlight:SpawnSpotlight()
		self.instance.Parent = Workspace
		local _WorldCFrame = self.AttachmentParent
		if _WorldCFrame ~= nil then
			_WorldCFrame = _WorldCFrame.WorldCFrame
		end
		local WorldCFrame = _WorldCFrame
		if not WorldCFrame then
			warn("AttachmentParent WorldCFrame is not set.")
			return nil
		end
		-- Apply a rotation to adjust the orientation
		local _arg0 = CFrame.Angles(0, 0, math.rad(90))
		local adjustedCFrame = WorldCFrame * _arg0
		local _adjustedCFrame = adjustedCFrame
		local _vector3 = Vector3.new(0, 13, 0)
		adjustedCFrame = _adjustedCFrame + _vector3
		self.instance:PivotTo(adjustedCFrame)
		local stringVector = "Location: [" .. tostring(math.round(self.instance:GetPivot().Position.X)) .. ", " .. tostring(math.round(self.instance:GetPivot().Position.Y)) .. ", " .. tostring(math.round(self.instance:GetPivot().Position.Z)) .. "]"
		print("Spawning spotlight at position: ", stringVector)
		return self.instance
	end
end
return {
	Spotlight = Spotlight,
}
