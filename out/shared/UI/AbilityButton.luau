-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- AbilityButton Class
-- GameStorage
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
-- Template
local Template = GameStorage:getGUI("Ability Button Template")
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
	function AbilityButton:constructor(displayName, wcsSkillName, imageId)
		self._instance = Template:Clone()
		self._imageButton = self._instance:FindFirstChild("ImageButton", true)
		self._progressBarFrame = self._instance:FindFirstChild("Progress Bar", true)
		self._imageButton:SetAttribute("Image", imageId)
		self._progressBarFrame:SetAttribute("TextValue", displayName)
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
			print("Ability Button Activated")
		end)
	end
end
return {
	AbilityButton = AbilityButton,
}
