-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
-- Events
local eventEquipRequest = GameStorage:getEvent("INVENTORY_EquipRequest")
local eventUnequipRequest = GameStorage:getEvent("INVENTORY_UnequipRequest")
local eventEquipResponse = GameStorage:getEvent("INVENTORY_EquipResponse")
local eventUnequipResponse = GameStorage:getEvent("INVENTORY_UnequipResponse")
-- Equipment Manager
local InventoryService
do
	InventoryService = setmetatable({}, {
		__tostring = function()
			return "InventoryService"
		end,
	})
	InventoryService.__index = InventoryService
	function InventoryService.new(...)
		local self = setmetatable({}, InventoryService)
		return self:constructor(...) or self
	end
	function InventoryService:constructor()
		-- Equip Request Listener
		InventoryService._connectionInventroyEquip = eventEquipRequest.OnServerEvent:Connect(function(player, ...)
			local args = { ... }
			print("Getting player data", args)
			-- Get Category and Equipment Id
			local category = args[1]
			local equipmentId = args[2]
			-- Equip Item
			local success = InventoryService:EquipPlayer(player, category, equipmentId)
			-- Fire Client Response
			eventEquipResponse:FireClient(player, if success then "Success" else "Failed")
		end)
		-- Unequip Request Listener
		InventoryService._connectionInventoryUnequip = eventUnequipRequest.OnServerEvent:Connect(function(player, ...)
			local args = { ... }
			print("Unequip Item", args)
			-- Get Slot
			local equipmentSlot = args[1]
			-- Unequip Item
			local success = InventoryService:UnequipPlayer(player, equipmentSlot)
			-- Fire Client Response
			eventUnequipResponse:FireClient(player, if success then "Success" else "Failed")
		end)
	end
	function InventoryService:Start()
		if InventoryService._instance == nil then
			InventoryService._instance = InventoryService.new()
		else
			Logger:Log("InventoryService", "Already started")
		end
	end
	function InventoryService:EquipPlayer(player, category, equipmentId)
		if InventoryService:ValidateEquipment(player, category, equipmentId) then
			print("Equipment is valid")
			return true
		else
			print("Equipment is invalid")
			return false
		end
	end
	function InventoryService:UnequipPlayer(player, equipmentSlot)
		print(player.Name, "  Unequip Item: ", equipmentSlot)
		return true
	end
	function InventoryService:ValidateEquipment(player, equipmentCategory, equipmentId)
		local userId = tostring(player.UserId)
		local playerData = DataManager:GetDataCache(userId)._playerData
		print("Validating Equipment", equipmentCategory, equipmentId, playerData.HelmetInventory)
		return true
	end
end
return {
	InventoryService = InventoryService,
}
