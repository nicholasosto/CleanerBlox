-- Compiled with roblox-ts v3.0.0
local InventoryType = {
	SkillInventory = "SkillInventory",
	WeaponInventory = "WeaponInventory",
	ArmorInventory = "ArmorInventory",
	HelmetInventory = "HelmetInventory",
	BootsInventory = "BootsInventory",
	FamiliarInventory = "FamiliarInventory",
	AccessoryInventory = "AccessoryInventory",
}
-- Inventory Manager
local InventoryManager
do
	InventoryManager = setmetatable({}, {
		__tostring = function()
			return "InventoryManager"
		end,
	})
	InventoryManager.__index = InventoryManager
	function InventoryManager.new(...)
		local self = setmetatable({}, InventoryManager)
		return self:constructor(...) or self
	end
	function InventoryManager:constructor(dataCache)
		self._dataCache = dataCache
	end
	function InventoryManager:AddToInventory(inventoryType, itemId)
		local playersInventory = self._dataCache._playerData[inventoryType]
		-- ▼ ReadonlyArray.find ▼
		local _callback = function(item)
			return item == itemId
		end
		local _result
		for _i, _v in playersInventory do
			if _callback(_v, _i - 1, playersInventory) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		if _result ~= nil then
			--Logger.Log("InventoryManager", "Item already Exista", itemId);
			return nil
		end
		local _itemId = itemId
		table.insert(playersInventory, _itemId)
		self._dataCache._playerData[inventoryType] = playersInventory
		self._dataCache:Save()
	end
	function InventoryManager:RemoveFromInventory(inventoryType, itemId)
		local _exp = self._dataCache._playerData[inventoryType]
		local _itemId = itemId
		local itemIndex = (table.find(_exp, _itemId) or 0) - 1
		if itemIndex > -1 then
			self._dataCache._playerData[inventoryType][itemIndex + 1] = ""
			--Logger.Log("InventoryManager", "Item Removed", itemId);
		end
		self._dataCache:Save()
	end
	function InventoryManager:GetInventory(inventoryType)
		return self._dataCache._playerData[inventoryType]
	end
end
return {
	InventoryType = InventoryType,
	InventoryManager = InventoryManager,
}
