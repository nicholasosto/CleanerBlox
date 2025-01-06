-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Note: Spawner Service
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local NotificationManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Notification", "NotificationManager").NotificationManager
local EInventoryEvent = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Inventory").EInventoryEvent
-- Requests
local eventSpawnRequest = GameStorage:getEvent(EInventoryEvent.EquipRequest)
-- Responses
local eventSpawnResponse = GameStorage:getEvent(EInventoryEvent.EquipResponse)
local SpawnerService
do
	SpawnerService = setmetatable({}, {
		__tostring = function()
			return "SpawnerService"
		end,
	})
	SpawnerService.__index = SpawnerService
	function SpawnerService.new(...)
		local self = setmetatable({}, SpawnerService)
		return self:constructor(...) or self
	end
	function SpawnerService:constructor()
		SpawnerService:ClearConnections()
		SpawnerService.spawnRequestConnection = eventSpawnRequest.OnServerEvent:Connect(function(player, ...)
			local args = { ... }
			print("Getting player data", args)
			local response = SpawnerService:_handleSpawnRequest(player)
			eventSpawnResponse:FireClient(player, response)
			NotificationManager:Notify(player, response)
		end)
	end
	function SpawnerService:_handleSpawnRequest(player)
		local spawnResponse = {
			success = false,
			message = "Failed to spawn",
		}
		return spawnResponse
	end
	function SpawnerService:Start()
		if self._instance == nil then
			self._instance = SpawnerService.new()
		end
	end
	function SpawnerService:ClearConnections()
		local _result = SpawnerService.spawnRequestConnection
		if _result ~= nil then
			_result:Disconnect()
		end
	end
end
return {
	SpawnerService = SpawnerService,
}
