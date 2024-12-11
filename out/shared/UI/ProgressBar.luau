-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Objective: Progress Bar Class
-- GameStorage
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
-- ProgressBar Template
local Template = GameStorage:getGUI("Progress Bar Template")
-- ProgressBar Class
local ProgressBar
do
	ProgressBar = setmetatable({}, {
		__tostring = function()
			return "ProgressBar"
		end,
	})
	ProgressBar.__index = ProgressBar
	function ProgressBar.new(...)
		local self = setmetatable({}, ProgressBar)
		return self:constructor(...) or self
	end
	function ProgressBar:constructor(targetInstance, minAttributeName, maxAttributeName, parent, displayName, colorSequence)
		-- Clone the template
		self._instance = Template:Clone()
		-- Set the parent
		self._parent = parent
		-- Set the model
		self._targetInstance = targetInstance
		-- update the color
		local gradient = self._instance:FindFirstChild("UIGradient", true)
		local topFrame = self._instance:FindFirstChild("Top", true)
		topFrame.BackgroundColor3 = colorSequence.Keypoints[1].Value
		gradient.Color = colorSequence
		-- Set the connections
		self._targetInstance:GetAttributeChangedSignal(minAttributeName):Connect(function()
			self:updateProgressBar(minAttributeName, maxAttributeName)
		end)
		self._targetInstance:GetAttributeChangedSignal(maxAttributeName):Connect(function()
			self:updateProgressBar(minAttributeName, maxAttributeName)
		end)
		print("** Connections Set **")
		-- Set the parent
		self._instance.Parent = self._parent
		self._instance:SetAttribute("TextValue", displayName)
		-- Set the ProgressBar
		self:updateProgressBar(minAttributeName, maxAttributeName)
	end
	function ProgressBar:updateProgressBar(currentName, maxName)
		-- Get the current and max attributes from the target instance
		local currentAttribute = self._targetInstance:GetAttribute(currentName)
		local maxAttribute = self._targetInstance:GetAttribute(maxName)
		-- Check if the attributes are undefined
		if currentAttribute == nil or maxAttribute == nil then
			print("Current or Max Attribute is undefined")
			return nil
		end
		-- Calculate the percentage
		local percentage = math.round((currentAttribute / maxAttribute) * 100)
		-- Set the percentage
		self._instance:SetAttribute("BarPercent", percentage)
	end
	function ProgressBar:destroy()
		self._instance:Destroy()
	end
end
return {
	ProgressBar = ProgressBar,
}
