-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RunService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").RunService
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
		CommunicationGod:_registerSignal("TestSignalA")
		CommunicationGod:_registerSignal("TestSignalB")
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
			warn("Signal already exists: ", eventName)
			return nil
		end
		local remoteEvent = Instance.new("RemoteEvent", game:GetService("ReplicatedStorage"))
		remoteEvent.Name = eventName
		if RunService:IsServer() then
			remoteEvent.OnServerEvent:Connect(function(player)
				warn("Server Event: ", player, eventName, " Args: ")
			end)
		else
			remoteEvent.OnClientEvent:Connect(function()
				warn("Client Event: " .. eventName .. " Args: ")
			end)
		end
		warn("Signal Registered: ", eventName)
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
