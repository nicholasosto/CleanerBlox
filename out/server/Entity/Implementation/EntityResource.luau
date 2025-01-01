-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local RunService = _services.RunService
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local EntityResourceBar
do
	EntityResourceBar = setmetatable({}, {
		__tostring = function()
			return "EntityResourceBar"
		end,
	})
	EntityResourceBar.__index = EntityResourceBar
	function EntityResourceBar.new(...)
		local self = setmetatable({}, EntityResourceBar)
		return self:constructor(...) or self
	end
	function EntityResourceBar:constructor(parent, name)
		self.Bar = GameStorage:cloneGUIComponent("Progress Bar Template")
		self.BarName = name
		self.Bar.Parent = parent
		self.Bar.Name = name .. "Bar"
		self.Bar:SetAttribute("TextValue", name)
	end
	function EntityResourceBar:setBarValue(percentage)
		self.Bar:SetAttribute("BarPercent", percentage)
	end
end
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
		local player = Players:GetPlayerFromCharacter(parent)
		if player then
			local playerGUI = player:WaitForChild("PlayerGui")
			if playerGUI ~= nil then
				local HUD = playerGUI:WaitForChild("HUD")
				self._resourceBar = EntityResourceBar.new(HUD, name)
			end
		end
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
		self.RegenActive = true
		-- Create Attributes on the Entity
		self.Entity:SetAttribute(self.AttributeNameMax, self.MaxValue)
		self.Entity:SetAttribute(self.AttributeNameCurrent, self.CurrentValue)
		-- Connections
		self._regenConnection = RunService.Heartbeat:Connect(function(dt)
			local timeSinceLastTick = tick() - self._lastRegenTick
			--warn("time: ", timeSinceLastTick, "rate: ", this.RegenRate);
			if self.RegenActive and timeSinceLastTick >= self.RegenRate then
				--warn("EntityResource - Regen Step");
				self._lastRegenTick = tick()
				self:_regenStep()
			end
		end)
		self._minChangeConnection = self.Entity:GetAttributeChangedSignal(self.Name .. "Current"):Connect(function()
			--Logger.Log("EntityResource", this.Name, this.CurrentValue);
			self:onResourceChange()
		end)
		self._maxChangeConnection = self.Entity:GetAttributeChangedSignal(self.Name .. "Max"):Connect(function()
			--Logger.Log("EntityResource", this.Name, this.MaxValue);
			self:onResourceChange()
		end)
		self:onResourceChange()
		self:setCurrentValue(10)
		return self
	end
	function EntityResource:_regenStep()
		self:setCurrentValue(self.CurrentValue + self.RegenAmount)
	end
	function EntityResource:setMaxValue(value)
		self.MaxValue = value
		self.Entity:SetAttribute(self.Name .. "Max", value)
	end
	function EntityResource:setCurrentValue(value)
		--warn("EntityResource - Setting Value: " + value);
		self.CurrentValue = value
		self.Entity:SetAttribute(self.Name .. "Current", value)
	end
	function EntityResource:adjustCurrentValue(value)
		--Logger.Log("EntityResource - Adjusting Value by: " + value);
		self.CurrentValue += value
		self.Entity:SetAttribute(self.Name .. "Current", self.CurrentValue)
	end
	function EntityResource:onResourceChange()
		--warn(this.Entity.Name + " onResourceChange not implemented: " + this.Name + "\nCurrent: " + this.CurrentValue);
		local _result = self._resourceBar
		if _result ~= nil then
			_result:setBarValue((self.CurrentValue / self.MaxValue) * 100)
		end
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
	function EntityResource:_disconnectConnections()
		if self._regenConnection and self._regenConnection.Connected then
			self._regenConnection:Disconnect()
		end
		if self._minChangeConnection and self._minChangeConnection.Connected then
			self._minChangeConnection:Disconnect()
		end
		if self._maxChangeConnection and self._maxChangeConnection.Connected then
			self._maxChangeConnection:Disconnect()
		end
	end
	function EntityResource:Destroy()
		self:_disconnectConnections()
	end
end
return {
	EntityResourceBar = EntityResourceBar,
	EntityResource = EntityResource,
}
