-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local UIService
do
	UIService = setmetatable({}, {
		__tostring = function()
			return "UIService"
		end,
	})
	UIService.__index = UIService
	function UIService.new(...)
		local self = setmetatable({}, UIService)
		return self:constructor(...) or self
	end
	function UIService:constructor(playerGui)
		local player = Players.LocalPlayer
		local playerAttributes = player:GetAttributes()
		warn("Player Attributes: ", playerAttributes)
		return self
	end
end
return {
	UIService = UIService,
}
