-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- WCS
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
-- WCS Shared Folder
local ParentFolder = ReplicatedStorage:FindFirstChild("WCS", true)
local WCSWrapper
do
	WCSWrapper = setmetatable({}, {
		__tostring = function()
			return "WCSWrapper"
		end,
	})
	WCSWrapper.__index = WCSWrapper
	function WCSWrapper.new(...)
		local self = setmetatable({}, WCSWrapper)
		return self:constructor(...) or self
	end
	function WCSWrapper:constructor()
		-- WCS Client Startup
		-- WCS Client Startup
	end
end
return {
	WCSWrapper = WCSWrapper,
}
