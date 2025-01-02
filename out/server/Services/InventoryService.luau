-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Note: Inventory Service
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
--import { EquipmentSlots } from "shared/Enums/GameEnums";
local NotificationManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Notification", "NotificationManager").NotificationManager
local InventoryReference = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "SharedReference").InventoryReference
-- Events
-- Requests
local eventEquipRequest = GameStorage:getEvent(InventoryReference.EInventoryEvent.EquipRequest)
local eventUnequipRequest = GameStorage:getEvent(InventoryReference.EInventoryEvent.UnequipRequest)
local eventUnlockRequest = GameStorage:getEvent(InventoryReference.EInventoryEvent.UnlockRequest)
-- Responses
local eventEquipResponse = GameStorage:getEvent(InventoryReference.EInventoryEvent.EquipResponse)
local eventUnequipResponse = GameStorage:getEvent(InventoryReference.EInventoryEvent.UnequipResponse)
local eventUnlockResponse = GameStorage:getEvent(InventoryReference.EInventoryEvent.UnlockResponse)
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
			local response = InventoryService:_handleEquipRequest(player, category, equipmentId)
			-- Fire Client Response
			eventEquipResponse:FireClient(player, response)
			NotificationManager:Notify(player, response)
		end)
		-- Unequip Request Listener
		InventoryService._connectionInventoryUnequip = eventUnequipRequest.OnServerEvent:Connect(function(player, ...)
			local args = { ... }
			print("Unequip Item", args)
			-- Get Slot
			local equipmentSlot = args[1]
			-- Unequip Item
			local response = InventoryService:_handleUnequipRequest(player, equipmentSlot)
			-- Fire Client Response
			eventUnequipResponse:FireClient(player, response)
		end)
	end
	function InventoryService:Start()
		if InventoryService._instance == nil then
			InventoryService._instance = InventoryService.new()
		else
			Logger:Log(script, "InventoryService", "Already started")
		end
	end
	function InventoryService:_handleEquipRequest(player, category, equipmentId)
		-- Validate Equipment
		local response = InventoryService:ValidatePlayerInventory(player, category, equipmentId)
		if not response.success then
			return response
		end
		-- Equip Item
		response = InventoryService:EquipCharacterModel(player.Character, category, equipmentId)
		return response
	end
	function InventoryService:EquipCharacterModel(characterRig, category, equipmentId)
		-- Get Response Ready
		local response = {
			success = true,
			message = "Successfully Equipped: " .. equipmentId,
		}
		-- Clone Equipment
		local equipmentAccessory = GameStorage:cloneAccessory(equipmentId)
		local _result = equipmentAccessory
		if _result ~= nil then
			_result = _result:FindFirstChild("Handle")
		end
		local handle = _result
		if handle == nil then
			response.message = "Handle not found"
			response.success = false
			return response
		end
		local _result_1 = handle
		if _result_1 ~= nil then
			_result_1 = _result_1:FindFirstChildWhichIsA("Attachment")
		end
		local attachment = _result_1
		if attachment == nil then
			response.message = "Attachment not found"
			response.success = false
			return response
		end
		attachment.Name = category
		-- Check if Clone Accessory Exists
		if equipmentAccessory == nil then
			response.message = "Equipment is undefined"
			response.success = false
			return response
		end
		-- Equip the Character
		equipmentAccessory.Parent = characterRig
		return response
	end
	function InventoryService:_handleUnequipRequest(player, equipmentSlot)
		-- Get the Response Ready
		local eventResponse = {
			success = true,
			message = "Removed Inventory Item: " .. equipmentSlot,
		}
		-- Unequip Item
		local character = player.Character
		if character == nil then
			eventResponse.message = "Character not found"
			eventResponse.success = false
			return eventResponse
		end
		local response = InventoryService:UnequipCharacterModel(character, equipmentSlot)
		return response
	end
	function InventoryService:UnequipCharacterModel(characterRig, equipmentSlot)
		-- Get the Response Ready
		local eventResponse = {
			success = true,
			message = "Removed Inventory Item: " .. equipmentSlot,
		}
		local _exp = characterRig:GetChildren()
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _callback = function(child)
			return child:IsA("Accessory")
		end
		local _length = 0
		for _k, _v in _exp do
			if _callback(_v, _k - 1, _exp) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		local accessories = _newValue
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(accessory)
			print("Accessory", accessory.Name)
		end
		for _k, _v in accessories do
			_callback_1(_v, _k - 1, accessories)
		end
		-- ▲ ReadonlyArray.forEach ▲
		-- ▼ ReadonlyArray.filter ▼
		local _newValue_1 = {}
		local _callback_2 = function(child)
			return child:FindFirstChild(equipmentSlot, true) ~= nil
		end
		local _length_1 = 0
		for _k, _v in accessories do
			if _callback_2(_v, _k - 1, accessories) == true then
				_length_1 += 1
				_newValue_1[_length_1] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		local accessory = _newValue_1[1]
		if accessory == nil then
			eventResponse.message = "Accessory not found"
			eventResponse.success = false
			return eventResponse
		end
		accessory:Destroy()
		return eventResponse
	end
	function InventoryService:ValidatePlayerInventory(player, equipmentCategory, equipmentId)
		-- Get the Player Data
		local userId = tostring(player.UserId)
		local playerData = DataManager:GetDataCache(userId)._playerData
		local InventorySlot = InventoryReference.EInventorySlot
		-- Map the Inventory to the Equipment Category
		local inventoryMap = {}
		local _helmet = InventorySlot.Helmet
		local _helmetInventory = playerData.HelmetInventory
		inventoryMap[_helmet] = _helmetInventory
		local _leftHand = InventorySlot.LeftHand
		local _weaponInventory = playerData.WeaponInventory
		inventoryMap[_leftHand] = _weaponInventory
		local _rightHand = InventorySlot.RightHand
		local _weaponInventory_1 = playerData.WeaponInventory
		inventoryMap[_rightHand] = _weaponInventory_1
		local _body = InventorySlot.Body
		local _armorInventory = playerData.ArmorInventory
		inventoryMap[_body] = _armorInventory
		local _familiar = InventorySlot.Familiar
		local _familiarInventory = playerData.FamiliarInventory
		inventoryMap[_familiar] = _familiarInventory
		local _accessory = InventorySlot.Accessory
		local _accessoryInventory = playerData.AccessoryInventory
		inventoryMap[_accessory] = _accessoryInventory
		-- Set the Inventory
		local _equipmentCategory = equipmentCategory
		local inventory = inventoryMap[_equipmentCategory]
		-- Get the Response Ready
		local response = {
			success = false,
			message = "Failed",
		}
		-- Invalid Category Check
		if inventory == nil then
			response.message = "Invalid Equipment Category"
			return response
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
			response.message = "Item not found in inventory"
			return response
		end
		-- Success
		response.success = true
		return response
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
