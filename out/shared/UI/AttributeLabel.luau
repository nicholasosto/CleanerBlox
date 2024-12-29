-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- AttributeLabel Class
-- GameStorage
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
-- Template
local Template = GameStorage:cloneGUIComponent("Attribute Label Template")
-- Attribute Label Class
local AttributeLabel
do
	AttributeLabel = setmetatable({}, {
		__tostring = function()
			return "AttributeLabel"
		end,
	})
	AttributeLabel.__index = AttributeLabel
	function AttributeLabel.new(...)
		local self = setmetatable({}, AttributeLabel)
		return self:constructor(...) or self
	end
	function AttributeLabel:constructor(displayName, attributeName)
		self._instance = Template:Clone()
		self.DisplayName = displayName
		self.AttributeName = attributeName
	end
	function AttributeLabel:create(parent, targetInstance)
		-- Clone the template
		local instance = Template:Clone()
		-- Get the NameFrame
		local NameFrame = instance:FindFirstChild("AttributeName", true)
		-- Set the DisplayName
		NameFrame:SetAttribute("TextValue", self.DisplayName)
		-- Get the AttributeValueImage
		self._attributeValueImage = instance:FindFirstChild("AttributeValue", true)
		-- Set the parent
		self._parent = parent
		-- Parent the instance
		instance.Parent = self._parent
		-- Set the target instance
		self._targetInstance = targetInstance
		-- Set the connections
		self:setConnections()
		-- Update the label
		self:updateLabel()
	end
	function AttributeLabel:setConnections()
		-- Set the connections
		local _result = self._targetInstance
		if _result ~= nil then
			_result = _result:GetAttributeChangedSignal(self.AttributeName):Connect(function()
				self:updateLabel()
			end)
		end
		self._connection = _result
	end
	function AttributeLabel:updateLabel()
		-- Get the current attribute from the target instance
		local _result = self._targetInstance
		if _result ~= nil then
			_result = _result:GetAttribute(self.AttributeName)
		end
		local currentAttribute = _result
		-- Check if the attribute is undefined
		if currentAttribute == nil then
			warn("Current Attribute is undefined")
			return nil
		end
		-- Set the TextValue
		local _result_1 = self._attributeValueImage
		if _result_1 ~= nil then
			_result_1:SetAttribute("TextValue", tostring(currentAttribute))
		end
	end
end
return {
	AttributeLabel = AttributeLabel,
}
