-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- AbilityButton Class
local _GameAssetManagers = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "GameAssetManagers")
local PackageManager = _GameAssetManagers.PackageManager
local EGuiTemplates = _GameAssetManagers.EGuiTemplates
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
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
	function AbilityButton:constructor(actionBar, wcsSkill, slot)
		-- Action Bar Slot Configuration
		-- Ability Button GUI Element
		self._abilityButtonFrame = PackageManager:LoadGuiTemplate(EGuiTemplates.AbilityButton)
		self._abilityButtonFrame.Name = wcsSkill:GetName() .. "_ButtonFrame"
		-- Action Bar Slot Reference
		local actionBarSlot = actionBar:FindFirstChild("Slot" .. tostring(slot))
		actionBarSlot = actionBarSlot:FindFirstChild("Content")
		-- Parent Ability Button to Action Bar Slot
		self._abilityButtonFrame.Parent = actionBarSlot
		-- Image Button
		self._imageButton = self._abilityButtonFrame:FindFirstChild("ImageButton")
		-- Cooldown Bar
		self._cooldownBar = self._abilityButtonFrame:FindFirstChild("CooldownBar")
		--Skill Configuration
		self._wcsSkill = wcsSkill
		self:setConnections()
		Logger:Log(script, "Skill Name: ", self._wcsSkill:GetName())
		Logger:Log(script, "Skill Frame: ", self._abilityButtonFrame)
		return self
	end
	function AbilityButton:setConnections()
		-- Set the connections
		self._connection = self._imageButton.Activated:Connect(function()
			self._wcsSkill:Start()
			print("Ability Button Activated")
		end)
	end
	function AbilityButton:SetCooldown(percentRemaining)
		self._cooldownBar:SetAttribute("BarPercent", percentRemaining)
	end
	function AbilityButton:Destroy()
		if self._connection then
			self._connection:Disconnect()
		end
		self._imageButton:Destroy()
	end
end
return {
	AbilityButton = AbilityButton,
}
