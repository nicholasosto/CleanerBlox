-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local AttributeFrameTemplate = ReplicatedStorage:WaitForChild("UITemplates"):WaitForChild("AttributeFrame")
local UIFactory
do
	UIFactory = setmetatable({}, {
		__tostring = function()
			return "UIFactory"
		end,
	})
	UIFactory.__index = UIFactory
	function UIFactory.new(...)
		local self = setmetatable({}, UIFactory)
		return self:constructor(...) or self
	end
	function UIFactory:constructor()
		-- Private constructor to prevent instantiation
		-- Private constructor to prevent instantiation
	end
	function UIFactory:createAttributeFrame(player, attribute)
		-- Clone the template
		local attributeFrame = AttributeFrameTemplate:Clone()
		-- Listen for attribute changes
		player:GetAttributeChangedSignal(attribute):Connect(function(changedAttribute)
			print(`Attribute {attribute} changed to {changedAttribute}`)
		end)
		return attributeFrame
	end
end
return {
	UIFactory = UIFactory,
}
