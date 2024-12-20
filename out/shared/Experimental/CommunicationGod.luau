-- Compiled with roblox-ts v3.0.0
local CommunicationGod
do
	CommunicationGod = setmetatable({}, {
		__tostring = function()
			return "CommunicationGod"
		end,
	})
	CommunicationGod.__index = CommunicationGod
	function CommunicationGod.new(...)
		local self = setmetatable({}, CommunicationGod)
		return self:constructor(...) or self
	end
	function CommunicationGod:constructor()
		CommunicationGod:_registerSignal("TestSignal")
		CommunicationGod:_registerSignal("Entity_Created")
		CommunicationGod:_registerSignal("Entity_Destroyed")
		CommunicationGod:_registerSignal("Spawn_Request")
		-- Equipment Signals
		CommunicationGod:_registerSignal("Equipment_Request")
		CommunicationGod:_registerSignal("Equipment_Response")
		-- Player Signals
		CommunicationGod:_registerSignal("Player_LevelUp")
		CommunicationGod:_registerSignal("Player_SetTarget")
		-- Movement Signals
		CommunicationGod:_registerSignal("Movement_DashRequest")
		CommunicationGod:_registerSignal("Movement_DashResponse")
		CommunicationGod:_registerSignal("Movement_FlightRequest")
		CommunicationGod:_registerSignal("Movement_FlightResponse")
		-- Notification Signals
		CommunicationGod:_registerSignal("Notify_Player")
		CommunicationGod:_registerSignal("Notify_All")
		-- AI Signals
		CommunicationGod:_registerSignal("AI_Request")
		CommunicationGod:_registerSignal("AI_Response")
		return self
	end
	function CommunicationGod:Summon()
		if self._god == nil then
			self._god = CommunicationGod.new()
		end
		return self._god
	end
	function CommunicationGod:_registerSignal(eventName)
		local _serverSignals = self.ServerSignals
		local _eventName = eventName
		if _serverSignals[_eventName] ~= nil then
			--Logger.Log("CommunicationGod", "Signal already registered: ", eventName);
			return nil
		end
		local remoteEvent = Instance.new("RemoteEvent", game:GetService("ReplicatedStorage"))
		remoteEvent.Name = eventName
		--Logger.Log("CommunicationGod", "Signal registered: ", eventName);
		local _serverSignals_1 = CommunicationGod.ServerSignals
		local _eventName_1 = eventName
		_serverSignals_1[_eventName_1] = remoteEvent
	end
	function CommunicationGod:getSignals()
		return self.ServerSignals
	end
	CommunicationGod.ServerSignals = {}
end
return {
	CommunicationGod = CommunicationGod,
}
