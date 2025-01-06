-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local EInventoryEvent = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Inventory").EInventoryEvent
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
-- Events
local eventEquipRequest = GameStorage:getEvent(EInventoryEvent.EquipRequest)
local eventUnequipRequest = GameStorage:getEvent(EInventoryEvent.UnequipRequest)
local eventEquipResponse = GameStorage:getEvent(EInventoryEvent.EquipResponse)
local eventUnequipResponse = GameStorage:getEvent(EInventoryEvent.UnequipResponse)
local ClientInventoryService
do
	ClientInventoryService = setmetatable({}, {
		__tostring = function()
			return "ClientInventoryService"
		end,
	})
	ClientInventoryService.__index = ClientInventoryService
	function ClientInventoryService.new(...)
		local self = setmetatable({}, ClientInventoryService)
		return self:constructor(...) or self
	end
	function ClientInventoryService:constructor()
		-- Equip Response
		ClientInventoryService._connectionEquipResponse = eventEquipResponse.OnClientEvent:Connect(function(response)
			print("Equip Response", response)
		end)
		-- Unequip Response
		ClientInventoryService._connectionUnequipResponse = eventUnequipResponse.OnClientEvent:Connect(function(response)
			print("Unequip Response", response)
		end)
	end
	function ClientInventoryService:Start()
		if ClientInventoryService._instance == nil then
			ClientInventoryService._instance = ClientInventoryService.new()
		else
			print("ClientInventoryService Already Started")
		end
	end
	function ClientInventoryService:SendEquipRequest(category, equipmentId)
		eventEquipRequest:FireServer(category, equipmentId)
	end
	function ClientInventoryService:SendUnequipRequest(category)
		eventUnequipRequest:FireServer(category)
	end
end
return {
	ClientInventoryService = ClientInventoryService,
}
