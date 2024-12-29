-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- AbilityButton Class
-- GameStorage
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local SignalButton = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "UI", "SignalButton").SignalButton
-- Template
local Template = GameStorage:cloneGUIComponent("Ability Button Template")
local CooldownBar
do
	CooldownBar = setmetatable({}, {
		__tostring = function()
			return "CooldownBar"
		end,
	})
	CooldownBar.__index = CooldownBar
	function CooldownBar.new(...)
		local self = setmetatable({}, CooldownBar)
		return self:constructor(...) or self
	end
	function CooldownBar:constructor()
	end
end
-- Attribute Label Class
local AbilityButton
do
	AbilityButton = setmetatable({}, {
		__tostring = function()
			return "AbilityButton"
		end,
	})
	AbilityButton.__index = AbilityButton
	function AbilityButton.new(...)
		local self = setmetatable({}, AbilityButton)
		return self:constructor(...) or self
	end
	function AbilityButton:constructor(displayName, wcsSkillName)
		self._instance = Template:Clone()
		self._imageButton = self._instance:FindFirstChild("ActivationButton", true)
		self._progressBarFrame = self._instance:FindFirstChild("CooldownBar", true)
		self.signalButton = SignalButton.new(self._imageButton, {
			name = "DUMMY",
			holdable = true,
		})
		self._instance.Name = displayName
		self._wcsSkillName = wcsSkillName
	end
	function AbilityButton:create(parent)
		self._instance.Parent = parent
		-- Set the connections
		self:setConnections()
	end
	function AbilityButton:setConnections()
		-- Set the connections
		self._connection = self._imageButton.Activated:Connect(function()
			local player = game:GetService("Players").LocalPlayer
			local character = player.Character
			print("Ability Button Activated")
		end)
	end
end
return {
	CooldownBar = CooldownBar,
	AbilityButton = AbilityButton,
}
