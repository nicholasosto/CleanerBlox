-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
-- Equipment Manager
local EquipmentManager
do
	EquipmentManager = setmetatable({}, {
		__tostring = function()
			return "EquipmentManager"
		end,
	})
	EquipmentManager.__index = EquipmentManager
	function EquipmentManager.new(...)
		local self = setmetatable({}, EquipmentManager)
		return self:constructor(...) or self
	end
	function EquipmentManager:constructor(dataCache)
		self._dataCache = dataCache
		local EquipmentSlots = self:GetEquipmentSlots()
		Logger:Log("EquipmentManager", "Constructor: \n\n", EquipmentSlots.Helmet, EquipmentSlots.Armor, EquipmentSlots.Boots, EquipmentSlots.Weapon, EquipmentSlots.Familiar, EquipmentSlots.Accessory, "\n\n")
	end
	function EquipmentManager:ValidateEquipment(equipmentId, inventory)
		-- ▼ ReadonlyArray.find ▼
		local _callback = function(equipment)
			return equipment == equipmentId
		end
		local _result
		for _i, _v in inventory do
			if _callback(_v, _i - 1, inventory) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		return _result ~= nil
	end
	function EquipmentManager:SetEquipmentSlot(slot, equipmentId)
		local playersEquipment = self._dataCache._playerData.Equipment
		local weaponInventory = self._dataCache._playerData.WeaponInventory
		local ArmorInventory = self._dataCache._playerData.ArmorInventory
		local HelmetInventory = self._dataCache._playerData.HelmetInventory
		local BootsInventory = self._dataCache._playerData.BootsInventory
		local FamiliarInventory = self._dataCache._playerData.FamiliarInventory
		local AccessoryInventory = self._dataCache._playerData.AccessoryInventory
		repeat
			if slot == "Weapon" then
				if self:ValidateEquipment(equipmentId, weaponInventory) == true then
					playersEquipment.Weapon = equipmentId
				end
				break
			end
			if slot == "Armor" then
				if self:ValidateEquipment(equipmentId, ArmorInventory) == true then
					playersEquipment.Armor = equipmentId
				end
				break
			end
			if slot == "Helmet" then
				if self:ValidateEquipment(equipmentId, HelmetInventory) == true then
					playersEquipment.Helmet = equipmentId
				end
				break
			end
			if slot == "Boots" then
				if self:ValidateEquipment(equipmentId, BootsInventory) == true then
					playersEquipment.Boots = equipmentId
				end
				break
			end
			if slot == "Familiar" then
				if self:ValidateEquipment(equipmentId, FamiliarInventory) == true then
					playersEquipment.Familiar = equipmentId
				end
				break
			end
			if slot == "Accessory" then
				if self:ValidateEquipment(equipmentId, AccessoryInventory) == true then
					playersEquipment.Accessory = equipmentId
				end
				break
			end
			break
		until true
	end
	function EquipmentManager:GetEquipmentSlots()
		return self._dataCache._playerData.Equipment
	end
end
return {
	EquipmentManager = EquipmentManager,
}
