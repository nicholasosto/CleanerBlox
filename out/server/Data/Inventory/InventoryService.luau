-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local EquipmentSlots = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Enums", "GameEnums").EquipmentSlots
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
		InventoryService:ClearConnections()
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
			local equipment = GameStorage:cloneAccessory(equipmentId)
			if equipment == nil then
				print("Equipment is undefined")
				return false
			end
			equipment.Parent = player.Character
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
		-- Get the Player Data
		local userId = tostring(player.UserId)
		local playerData = DataManager:GetDataCache(userId)._playerData
		-- Map the Inventory to the Equipment Category
		local inventoryMap = {}
		local _helmet = EquipmentSlots.Helmet
		local _helmetInventory = playerData.HelmetInventory
		inventoryMap[_helmet] = _helmetInventory
		local _weapon = EquipmentSlots.Weapon
		local _weaponInventory = playerData.WeaponInventory
		inventoryMap[_weapon] = _weaponInventory
		local _boots = EquipmentSlots.Boots
		local _bootsInventory = playerData.BootsInventory
		inventoryMap[_boots] = _bootsInventory
		local _familiar = EquipmentSlots.Familiar
		local _familiarInventory = playerData.FamiliarInventory
		inventoryMap[_familiar] = _familiarInventory
		local _accessory = EquipmentSlots.Accessory
		local _accessoryInventory = playerData.AccessoryInventory
		inventoryMap[_accessory] = _accessoryInventory
		-- Set the Inventory
		local _equipmentCategory = equipmentCategory
		local inventory = inventoryMap[_equipmentCategory]
		-- Invalid Category Check
		if inventory == nil then
			print("Invalid Equipment Category", equipmentCategory)
			return false
		end
		-- Inventory Check
		-- ▼ ReadonlyArray.find ▼
		local _callback = function(item)
			return item == equipmentId
		end
		local _result
		for _i, _v in inventory do
			if _callback(_v, _i - 1, inventory) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		if _result == nil then
			print("Item not found in inventory", equipmentId)
			return false
		end
		return true
	end
	function InventoryService:ClearConnections()
		local _result = InventoryService._connectionInventroyEquip
		if _result ~= nil then
			_result:Disconnect()
		end
		local _result_1 = InventoryService._connectionInventoryUnequip
		if _result_1 ~= nil then
			_result_1:Disconnect()
		end
	end
end
return {
	InventoryService = InventoryService,
}
