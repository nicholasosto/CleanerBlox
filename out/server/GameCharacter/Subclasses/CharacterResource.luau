-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Roblox Services
local RunService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").RunService
-- Custom Imports
local EResourceTypes = {
	Health = "Health",
	Mana = "Mana",
	Stamina = "Stamina",
	Experience = "Experience",
	DomainEnergy = "DomainEnergy",
}
local CharacterResourceBar
do
	CharacterResourceBar = setmetatable({}, {
		__tostring = function()
			return "CharacterResourceBar"
		end,
	})
	CharacterResourceBar.__index = CharacterResourceBar
	function CharacterResourceBar.new(...)
		local self = setmetatable({}, CharacterResourceBar)
		return self:constructor(...) or self
	end
	function CharacterResourceBar:constructor(progressBarFrame, name)
		self._progressBarFrame = progressBarFrame
		self._progressBarFrame:SetAttribute("TextValue", name)
		self._progressBarFrame:SetAttribute("BarPercent", 100)
	end
	function CharacterResourceBar:setProgressByValues(currentValue, maxValue)
		self._progressBarFrame:SetAttribute("BarPercent", (currentValue / maxValue) * 100)
	end
	function CharacterResourceBar:setProgressByPercent(percentage)
		self._progressBarFrame:SetAttribute("BarPercent", percentage)
	end
end
local CharacterResource
do
	CharacterResource = setmetatable({}, {
		__tostring = function()
			return "CharacterResource"
		end,
	})
	CharacterResource.__index = CharacterResource
	function CharacterResource.new(...)
		local self = setmetatable({}, CharacterResource)
		return self:constructor(...) or self
	end
	function CharacterResource:constructor(gameCharacter, resourceName)
		self.Name = "DefaultResource"
		self.AttributeNameCurrent = "DefaultResourceCurrent"
		self.AttributeNameMax = "DefaultResourceMax"
		self._maxValue = 100
		self._currentValue = 100
		self._regenRate = 1
		self._regenAmount = 10
		self._regenActive = true
		self._lastRegenTick = 0
		-- Parent GameCharacter
		self.GameCharacter = gameCharacter.CharacterModel
		-- Attribute Names and Values
		self.Name = resourceName
		self.AttributeNameCurrent = self.Name .. "Current"
		self.AttributeNameMax = self.Name .. "Max"
		-- Create Attributes on the GameCharacter
		self.GameCharacter:SetAttribute(self.AttributeNameMax, self._maxValue)
		self.GameCharacter:SetAttribute(self.AttributeNameCurrent, self._currentValue)
		-- initializeConnections
		self:_initializeConnections()
		self:_onResourceChange()
		return self
	end
	function CharacterResource:_initializeConnections()
		-- Disconnect Connections if they exist
		self:_disconnectConnections()
		--Heartbeat Connection
		self._heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
			self:_regenStep()
		end)
		-- Min Change Connection
		self._minChangeConnection = self.GameCharacter:GetAttributeChangedSignal(self.Name .. "Current"):Connect(function()
			--Logger.Log(script,"CharacterResource", this.Name, this._currentValue);
			self:_onResourceChange()
		end)
		-- Max Change Connection
		self._maxChangeConnection = self.GameCharacter:GetAttributeChangedSignal(self.Name .. "Max"):Connect(function()
			--Logger.Log(script,"CharacterResource", this.Name, this._maxValue);
			self:_onResourceChange()
		end)
	end
	function CharacterResource:SetMax(value)
		self._maxValue = value
		self.GameCharacter:SetAttribute(self.Name .. "Max", value)
	end
	function CharacterResource:SetCurrent(value)
		self._currentValue = value
		self.GameCharacter:SetAttribute(self.Name .. "Current", value)
	end
	function CharacterResource:RegenToggle(activate)
		self._regenActive = activate
	end
	function CharacterResource:_regenStep()
		-- Time Since Last Tick
		local timeSinceLastTick = tick() - self._lastRegenTick
		if self._regenActive and timeSinceLastTick >= self._regenRate then
			--warn("CharacterResource - Regen Step");
			self._lastRegenTick = tick()
			self:SetCurrent(self._currentValue + self._regenAmount)
		end
	end
	function CharacterResource:_onResourceChange()
		local _result = self._resourceBar
		if _result ~= nil then
			_result:setProgressByValues(self._currentValue, self._maxValue)
		end
	end
	function CharacterResource:_disconnectConnections()
		local _result = self._heartbeatConnection
		if _result ~= nil then
			_result:Disconnect()
		end
		local _result_1 = self._minChangeConnection
		if _result_1 ~= nil then
			_result_1:Disconnect()
		end
		local _result_2 = self._maxChangeConnection
		if _result_2 ~= nil then
			_result_2:Disconnect()
		end
	end
	function CharacterResource:Destroy()
		self:_disconnectConnections()
	end
end
return {
	EResourceTypes = EResourceTypes,
	CharacterResourceBar = CharacterResourceBar,
	CharacterResource = CharacterResource,
}
