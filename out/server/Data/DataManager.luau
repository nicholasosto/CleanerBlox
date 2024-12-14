-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local DataStoreService = _services.DataStoreService
local EquipmentManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "Equipment", "EquipmentManager").EquipmentManager
local SkillsManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "Skills", "SkillsManager").SkillsManager
local InventoryManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "Inventory", "InventoryManager").InventoryManager
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local IData = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Interfaces", "IData")
-- Data Types
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
		self._minSaveInterval = 2
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
			Logger:Log("DM", "\n Data Loaded")
		end
	end
	function DataCache:Save()
		-- Save the player data to the DataStore
		local timeSinceLastSave = os.time() - self._lastSaveTimestamp
		if timeSinceLastSave <= self._minSaveInterval then
			-- Do not save if the last save was less than 2 seconds ago
			Logger:Log("SaveSkipped", timeSinceLastSave)
			return "Save Skipped"
		end
		local success = self._dataStore:SetAsync(self._userId, self._playerData)
		-- Update the last save timestamp
		self._lastSaveTimestamp = os.time()
		return success
	end
	function DataCache:SetDataCache(dataCache)
		self._playerData = dataCache
		local timeSinceLastSave = os.time() - self._lastSaveTimestamp
		if timeSinceLastSave <= 2 then
			-- Do not save if the last save was less than 2 seconds ago
			return nil
		end
		if timeSinceLastSave >= 60 then
			self:Save()
		end
	end
	function DataCache:GetDataCache()
		return self._playerData
	end
end
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
		local _result = DataManager.playerAddedConnection
		if _result ~= nil then
			_result:Disconnect()
		end
		DataManager.playerAddedConnection = Players.PlayerAdded:Connect(function(player)
			DataManager:RegisterPlayer(player)
		end)
	end
	function DataManager:Start()
		if self._instance == nil then
			self._instance = DataManager.new()
		end
	end
	function DataManager:RegisterPlayer(player)
		-- 01 - Get the player data from the DataStore or Cache
		local userId = tostring(player.UserId)
		local storedData = (DataManager.GameDataStore:GetAsync(userId))
		local dataCache = DataCache.new(userId, DataManager.GameDataStore)
		local skillSlotManager = SkillsManager.new(dataCache)
		local equipmentManager = EquipmentManager.new(dataCache)
		local inventoryManager = InventoryManager.new(dataCache)
		local _exp = self.PlayerCache
		table.insert(_exp, dataCache)
	end
	function DataManager:GetDataCache(userId)
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
		return _result
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
	end
	DataManager.DataStoreService = DataStoreService
	DataManager.DatastoreId = "SOULSTEEL_12_2024"
	DataManager.GameDataStore = DataManager.DataStoreService:GetDataStore(DataManager.DatastoreId)
	DataManager.PlayerCache = {}
	DataManager.AutoSaveInterval = 15
end
return {
	DataTemplate = DataTemplate,
	DataCache = DataCache,
	DataManager = DataManager,
}
