-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local DataStoreService = _services.DataStoreService
local HttpService = _services.HttpService
local DataTemplate = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Interfaces", "TInterfaces").DataTemplate
local PlayerAttributes = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "PlayerAttributes").PlayerAttributes
local DATASTORE_NAME = "SoulSteel_TS"
local DataService
do
	DataService = setmetatable({}, {
		__tostring = function()
			return "DataService"
		end,
	})
	DataService.__index = DataService
	function DataService.new(...)
		local self = setmetatable({}, DataService)
		return self:constructor(...) or self
	end
	function DataService:constructor()
		self.dataStore = DataStoreService:GetDataStore(DATASTORE_NAME)
		self.playerDataCache = {}
		Players.PlayerAdded:Connect(function(player)
			return self:onPlayerAdded(player)
		end)
		Players.PlayerRemoving:Connect(function(player)
			return self:onPlayerRemoving(player)
		end)
	end
	DataService.onPlayerAdded = TS.async(function(self, player)
		-- 00. Convert player.UserId to string
		local userId = tostring(player.UserId)
		-- 00. Call loadPlayerData with userId
		local data = TS.await(self:loadPlayerData(userId))
		-- 00. If data is not defined or data.version is not equal to DataTemplate.version
		if not data or data.version ~= DataTemplate.version then
			local _object = table.clone(DataTemplate)
			setmetatable(_object, nil)
			_object.version = DataTemplate.version
			data = _object
		end
		-- 01. Set playerDataCache with userId and data
		local _playerDataCache = self.playerDataCache
		local _data = data
		_playerDataCache[userId] = _data
		-- 02. Create player attributes
		if data then
			local JSONData = HttpService:JSONEncode(data)
			warn(`Loaded data for user {userId}: {JSONData}`)
			PlayerAttributes:createAttributes(player, data)
		end
	end)
	DataService.onPlayerRemoving = TS.async(function(self, player)
		-- 00. Convert player.UserId to string
		local userId = tostring(player.UserId)
		-- 01. Call savePlayerData with userId and this.playerDataCache.get(userId)
		local data = self.playerDataCache[userId]
		-- 02. Save player data if data is not undefined
		if data then
			TS.await(self:savePlayerData(userId, data))
			self.playerDataCache[userId] = nil
		end
	end)
	DataService.loadPlayerData = TS.async(function(self, userId)
		-- 00. Try to load data for user
		local _exitType, _returns = TS.try(function()
			-- 00. Call this.dataStore.GetAsync with userId
			local stored = TS.await({ self.dataStore:GetAsync(`{userId}`) })
			local _value = stored[1]
			if _value ~= 0 and _value == _value and _value ~= "" and _value then
				-- Cast stored data to unknown first to resolve TS2352 error
				local rawData = stored
				-- Return rawData as PlayerData
				return TS.TRY_RETURN, { rawData }
			end
		end, function(e)
			warn(`Failed to load data for user {userId}: {e}`)
		end)
		if _exitType then
			return unpack(_returns)
		end
		return nil
	end)
	DataService.savePlayerData = TS.async(function(self, userId, data)
		TS.try(function()
			TS.await(self.dataStore:SetAsync(`{userId}`, data))
		end, function(e)
			warn(`Failed to save data for user {userId}: {e}`)
		end)
	end)
end
return {
	DataService = DataService,
}
