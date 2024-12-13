-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local DataStoreService = _services.DataStoreService
local HttpService = _services.HttpService
local EquipmentManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "EquipmentManager").EquipmentManager
local SkillsManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "SkillsManager").SkillsManager
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local IData = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Interfaces", "IData")
-- Data Types
--export type ICharacterClassData = IData.CharacterClassData;
--export type IStatsData = IData.StatsData;
--export type ISkillsData = IData.SkillsData;
--export type IEquipmentData = IData.EquipmentData;
-- Data Template
local DataTemplate = IData.DataTemplate
-- Data Cache Class for use in the DataManager
local DataCache
do
	DataCache = setmetatable({}, {
		__tostring = function()
			return "DataCache"
		end,
	})
	DataCache.__index = DataCache
	function DataCache.new(...)
		local self = setmetatable({}, DataCache)
		return self:constructor(...) or self
	end
	function DataCache:constructor(userId, dataStore)
		self._lastSaveTimestamp = 0
		-- Set the properties
		self._userId = userId
		self._dataStore = dataStore
		-- Attempt to load the player data from the DataStore
		self._playerData = (dataStore:GetAsync(userId))
		-- If the player data is not found, create a new player data based on the DataTemplate
		if self._playerData == nil then
			self._playerData = DataTemplate
			self:Save()
		else
			Logger:Log("DataManager(DataCache)", "DataCache loaded from DataStore:", self._playerData.Level)
		end
	end
	function DataCache:Save()
		-- Save the player data to the DataStore
		local success = self._dataStore:SetAsync(self._userId, self._playerData)
		-- Update the last save timestamp
		self._lastSaveTimestamp = os.time()
		-- Return the success message
		Logger:Log("PlayerData", "DataSaved", HttpService:JSONEncode(self._playerData))
		return success
	end
	function DataCache:SetDataCache(dataCache)
		self._playerData = dataCache
		local timeSinceLastSave = os.time() - self._lastSaveTimestamp
		if timeSinceLastSave >= 60 then
			self:Save()
		end
	end
	function DataCache:GetDataCache()
		return self._playerData
	end
end
local InventoryManager
local DataManager
do
	DataManager = setmetatable({}, {
		__tostring = function()
			return "DataManager"
		end,
	})
	DataManager.__index = DataManager
	function DataManager.new(...)
		local self = setmetatable({}, DataManager)
		return self:constructor(...) or self
	end
	function DataManager:constructor()
	end
	function DataManager:RegisterPlayer(player)
		-- 01 - Get the player data from the DataStore or Cache
		local userId = tostring(player.UserId)
		local storedData = (DataManager.GameDataStore:GetAsync(userId))
		local dataCache = DataCache.new(userId, DataManager.GameDataStore)
		local skillSlotManager = SkillsManager.new(dataCache)
		local equipmentManager = EquipmentManager.new(dataCache)
		local inventoryManager = InventoryManager.new(dataCache)
		-- Manager TESTS
		skillSlotManager:SetSkillSlot(5, "StunXXX")
		equipmentManager:SetEquipmentSlot("Weapon", "Sword")
		inventoryManager:AddToInventory(IData.InventoryTypeKeys.SkillInventory, "Stun")
		local _exp = self.PlayerCache
		table.insert(_exp, dataCache)
	end
	function DataManager:OnPlayerLeaving(player)
		-- 01 - Get the data cache for the player
		local userId = tostring(player.UserId)
		local _exp = DataManager.PlayerCache
		-- ▼ ReadonlyArray.find ▼
		local _callback = function(cache)
			return cache._userId == userId
		end
		local _result
		for _i, _v in _exp do
			if _callback(_v, _i - 1, _exp) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local dataCache = _result
		dataCache:Save()
		print(dataCache)
	end
	function DataManager:OnCharacterSpawn(player)
		-- 01 - Get the data cache for the player
		local userId = tostring(player.UserId)
		local _exp = DataManager.PlayerCache
		-- ▼ ReadonlyArray.find ▼
		local _callback = function(cache)
			return cache._userId == userId
		end
		local _result
		for _i, _v in _exp do
			if _callback(_v, _i - 1, _exp) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local dataCache = _result
		-- 02 - Update the player data
		dataCache:Save()
	end
	DataManager.DataStoreService = DataStoreService
	DataManager.DatastoreId = "SOULSTEEL_12_2024"
	DataManager.GameDataStore = DataManager.DataStoreService:GetDataStore(DataManager.DatastoreId)
	DataManager.PlayerCache = {}
	DataManager.AutoSaveInterval = 15
end
-- Inventory Manager
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
			Logger:Log("InventoryManager", "Item already Exista", itemId)
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
			Logger:Log("InventoryManager", "Item Removed", itemId)
		end
		self._dataCache:Save()
	end
	function InventoryManager:GetInventory(inventoryType)
		return self._dataCache._playerData[inventoryType]
	end
end
return {
	DataTemplate = DataTemplate,
	DataCache = DataCache,
	DataManager = DataManager,
	InventoryManager = InventoryManager,
}
