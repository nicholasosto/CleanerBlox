-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RunService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").RunService
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
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
	function EntityResource:constructor(parent, name, maxValue, regenRate, regenAmount)
		if regenAmount == nil then
			regenAmount = 1
		end
		self._lastRegenTick = 0
		-- Parent Entity
		self.Entity = parent
		-- Attribute Names and Values
		self.Name = name
		self.AttributeNameCurrent = self.Name .. "Current"
		self.AttributeNameMax = self.Name .. "Max"
		self.MaxValue = maxValue
		self.CurrentValue = maxValue
		-- Regen Values
		self.RegenRate = regenRate
		self.RegenAmount = regenAmount
		self.RegenActive = false
		-- Create Attributes on the Entity
		self.Entity:SetAttribute(self.AttributeNameMax, self.MaxValue)
		self.Entity:SetAttribute(self.AttributeNameCurrent, self.CurrentValue)
		-- Connections
		self._regenConnection = RunService.Heartbeat:Connect(function()
			self:_regenStep()
		end)
		self._minChangeConnection = self.Entity:GetAttributeChangedSignal(self.Name .. "Current"):Connect(function()
			self:onResourceChange()
		end)
		self._maxChangeConnection = self.Entity:GetAttributeChangedSignal(self.Name .. "Max"):Connect(function()
			self:onResourceChange()
		end)
		return self
	end
	function EntityResource:_regenStep()
		local timeSinceLastTick = tick() - self._lastRegenTick
		if timeSinceLastTick >= self.RegenRate and self.CurrentValue < self.MaxValue then
			self.CurrentValue += self.RegenAmount
			Logger:Log("EntityResource", self.Name, self.CurrentValue)
		end
		if self.CurrentValue < self.MaxValue then
			self.CurrentValue += self.RegenAmount
		end
	end
	function EntityResource:onResourceChange()
		warn(self.Entity.Name .. " onResourceChange not implemented: " .. self.Name .. "\nCurrent: " .. tostring(self.CurrentValue))
	end
	function EntityResource:assignOnMinChange(callback)
		self._minChangeConnection = self.Entity:GetAttributeChangedSignal(self.Name .. "Current"):Connect(callback)
	end
	function EntityResource:assignOnMaxChange(callback)
		if self._maxChangeConnection and self._maxChangeConnection.Connected then
			self._maxChangeConnection:Disconnect()
		end
		self._maxChangeConnection = self.Entity:GetAttributeChangedSignal(self.Name .. "Max"):Connect(callback)
	end
	function EntityResource:startRegen()
		self.RegenActive = true
	end
	function EntityResource:stopRegen()
		self.RegenActive = false
	end
	function EntityResource:BindToEntity(entity)
		self.Entity = entity
		entity:SetAttribute(self.Name .. "Max", self.MaxValue)
		entity:SetAttribute(self.Name .. "Current", self.CurrentValue)
	end
end
return {
	EntityResource = EntityResource,
}
