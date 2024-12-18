-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local GUIController
do
	GUIController = setmetatable({}, {
		__tostring = function()
			return "GUIController"
		end,
	})
	GUIController.__index = GUIController
	function GUIController.new(...)
		local self = setmetatable({}, GUIController)
		return self:constructor(...) or self
	end
	function GUIController:constructor()
		local NotificationEvent = GameStorage:getEvent("NOTIFY_Player")
		GUIController._notificationConnection = NotificationEvent.OnClientEvent:Connect(function(message)
			warn("Notification: ", message)
			-- Logic to display the message
		end)
	end
	function GUIController:Start()
		if GUIController._instance == nil then
			GUIController._instance = GUIController.new()
		end
		return GUIController._instance
	end
end
return {
	GUIController = GUIController,
}
