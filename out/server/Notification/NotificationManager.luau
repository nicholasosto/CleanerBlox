-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local NotificationManager
do
	NotificationManager = setmetatable({}, {
		__tostring = function()
			return "NotificationManager"
		end,
	})
	NotificationManager.__index = NotificationManager
	function NotificationManager.new(...)
		local self = setmetatable({}, NotificationManager)
		return self:constructor(...) or self
	end
	function NotificationManager:constructor()
		-- Constructor Logic
		-- Constructor Logic
	end
	function NotificationManager:Start()
		if NotificationManager._instance == nil then
			NotificationManager._instance = NotificationManager.new()
		end
		return NotificationManager._instance
	end
	function NotificationManager:Notify(player, message)
		NotificationManager._notificationEvent:FireClient(player, message)
		local playerGui = player:FindFirstChildOfClass("PlayerGui")
		local _result = playerGui
		if _result ~= nil then
			_result = _result:FindFirstChild("NotificationPanel")
		end
		local NotificationPanel = _result
		NotificationPanel.Enabled = true
		local MessageLabel = NotificationPanel:FindFirstChild("MessageLabel", true)
		MessageLabel.Text = message
		task.delay(2, function()
			NotificationPanel.Enabled = false
			MessageLabel.Text = ""
		end)
	end
	NotificationManager._notificationEvent = GameStorage:getEvent("NOTIFY_Player")
end
return {
	NotificationManager = NotificationManager,
}
