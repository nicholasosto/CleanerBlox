-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RunService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").RunService
local EntityResource
do
	EntityResource = setmetatable({}, {
		__tostring = function()
			return "EntityResource"
		end,
	})
	EntityResource.__index = EntityResource
	function EntityResource.new(...)
		local self = setmetatable({}, EntityResource)
		return self:constructor(...) or self
	end
	function EntityResource:constructor(name, maxValue, regenRate, regenAmount)
		self._regenConnection = RunService.Heartbeat:Connect(function(delta)
			return self:regen(delta)
		end)
		self.Name = name
		self.MaxValue = maxValue
		self.CurrentValue = maxValue
		self.RegenRate = regenRate
		self.RegenAmount = regenAmount
		self.RegenActive = false
		return self
	end
	function EntityResource:startRegen()
		self.RegenActive = true
	end
	function EntityResource:stopRegen()
		self.RegenActive = false
	end
	EntityResource.regen = TS.async(function(self, delta)
		while self.RegenActive do
			task.wait(self.RegenRate)
		end
	end)
	function EntityResource:BindToEntity(entity)
		self.Entity = entity
		entity:SetAttribute(self.Name .. "Max", self.MaxValue)
		entity:SetAttribute(self.Name .. "Current", self.CurrentValue)
	end
end
return {
	EntityResource = EntityResource,
}
