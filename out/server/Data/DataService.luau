-- Compiled with roblox-ts v3.0.0
-- DataService class to manage player data
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
		self.playerDataStore = {}
	end
	function DataService:loadPlayerData(playerId)
		local _playerDataStore = self.playerDataStore
		local _playerId = playerId
		return _playerDataStore[_playerId]
	end
	function DataService:savePlayerData(playerData)
		local _playerDataStore = self.playerDataStore
		local _id = playerData.id
		local _playerData = playerData
		_playerDataStore[_id] = _playerData
	end
	function DataService:updatePlayerData(playerId, updates)
		local _playerDataStore = self.playerDataStore
		local _playerId = playerId
		local existingData = _playerDataStore[_playerId]
		if existingData then
			local _object = table.clone(existingData)
			setmetatable(_object, nil)
			for _k, _v in updates do
				_object[_k] = _v
			end
			local updatedData = _object
			local _playerDataStore_1 = self.playerDataStore
			local _playerId_1 = playerId
			_playerDataStore_1[_playerId_1] = updatedData
		else
			warn(`Player data for {playerId} not found.`)
		end
	end
	function DataService:removePlayerData(playerId)
		local _playerDataStore = self.playerDataStore
		local _playerId = playerId
		_playerDataStore[_playerId] = nil
	end
end
return {
	DataService = DataService,
}
