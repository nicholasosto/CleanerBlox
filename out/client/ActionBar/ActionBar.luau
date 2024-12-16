-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local ActionBar
do
	ActionBar = setmetatable({}, {
		__tostring = function()
			return "ActionBar"
		end,
	})
	ActionBar.__index = ActionBar
	function ActionBar.new(...)
		local self = setmetatable({}, ActionBar)
		return self:constructor(...) or self
	end
	function ActionBar:constructor()
		self._eventEntityCreated = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ENTITY_Created")
		self._connectionEntityLoaded = self._eventEntityCreated.OnClientEvent:Connect(function(entity)
			Logger:Log("ActionBar", "Entity Loaded: ", entity)
		end)
		return self
	end
	function ActionBar:Start()
		if not self._instance then
			self._instance = ActionBar.new()
		end
		return self._instance
	end
end
return {
	ActionBar = ActionBar,
}
