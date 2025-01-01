-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- GameCharacter.ts: Game Character Classes
-- BaseGameCharacter: Base Class for Game Characters
-- PlayerGameCharacter: Player Character
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
-- Entity Related Imports
local EntityResource = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "Implementation", "EntityResource").EntityResource
-- Data Related Imports
-- Utility Imports
local Calculator = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "Implementation", "EntityCalculator")
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
-- BaseGameCharacter (NPCs and Players inherit from this)
local BaseGameCharacter
do
	BaseGameCharacter = setmetatable({}, {
		__tostring = function()
			return "BaseGameCharacter"
		end,
	})
	BaseGameCharacter.__index = BaseGameCharacter
	function BaseGameCharacter.new(...)
		local self = setmetatable({}, BaseGameCharacter)
		return self:constructor(...) or self
	end
	function BaseGameCharacter:constructor(characterModel, characterName)
		if characterName == nil then
			characterName = "Default Character Name"
		end
		self.StatsData = {
			Strength = 10,
			Dexterity = 10,
			Intelligence = 10,
			Constitution = 10,
			Speed = 10,
			Level = 1,
			Experience = 0,
			ExperienceToNextLevel = 100,
			AttributePoints = 0,
		}
		self._State = "Idle"
		self._MovesetName = "DefaultMoveset"
		-- Assign Character Name
		self.CharacterName = characterName
		-- Assign Character Model
		self.CharacterModel = characterModel
		if self.CharacterModel == nil then
			error("BaseGameCharacter: Character Model not found")
		end
		-- Create WCS Character
		self.WCS_Character = Character.new(characterModel)
		-- Create Resources: Health, Mana, Stamina
		self.Health = EntityResource.new(self.CharacterModel, "Health", 100, 1, 10)
		self.Mana = EntityResource.new(self.CharacterModel, "Mana", 100, 1, 10)
		self.Stamina = EntityResource.new(self.CharacterModel, "Stamina", 100, 1, 10)
		-- Apply Default Moveset
		self.WCS_Character:ApplyMoveset(self._MovesetName)
		-- Initialize Connections
		self:initializeConnections()
		return self
	end
	function BaseGameCharacter:onStateChange(newState)
		Logger:Log("SuperClass-OnStateChange(): " .. newState)
	end
	function BaseGameCharacter:SetState(state)
		Logger:Log("SuperClass-SetState(): " .. state)
		self.CharacterModel:SetAttribute("State", state)
		self._State = self.CharacterModel:GetAttribute("State")
	end
	function BaseGameCharacter:initializeConnections()
		self:destroyConnections()
		self._connectionCharacterTakeDamage = self.WCS_Character.DamageTaken:Connect(function(damage)
			Logger:Log("SuperClass-TakeDamage(): " .. tostring(damage))
			self:handleCharacterTakeDamage(damage)
		end)
		self._connectionCharacterDealtDamage = self.WCS_Character.DamageDealt:Connect(function(enemy, damage)
			Logger:Log("SuperClass-DealDamage(): " .. tostring(damage))
			self:handleCharacterDealtDamage(enemy, damage)
		end)
		self._connectionStatusEffectAdded = self.WCS_Character.StatusEffectAdded:Connect(function(statusEffect)
			Logger:Log("SuperClass-StatusEffectAdded(): " .. tostring(statusEffect))
			self:handleStatusEffectAdded(statusEffect)
		end)
		self._connectionStatusEffectRemoved = self.WCS_Character.StatusEffectRemoved:Connect(function(statusEffect)
			Logger:Log("SuperClass-StatusEffectRemoved(): " .. tostring(statusEffect))
			self:handleStatusEffectRemoved(statusEffect)
		end)
		self._connectionStatusEffectStarted = self.WCS_Character.StatusEffectStarted:Connect(function(statusEffect)
			Logger:Log("SuperClass-StatusEffectStarted(): " .. tostring(statusEffect))
			self:handleStatusEffectStarted(statusEffect)
		end)
		self._connectionStatusEffectEnded = self.WCS_Character.StatusEffectEnded:Connect(function(statusEffect)
			Logger:Log("SuperClass-StatusEffectEnded(): " .. tostring(statusEffect))
			self:handleStatusEffectEnded(statusEffect)
		end)
	end
	function BaseGameCharacter:handleCharacterTakeDamage(damageContainer)
		Logger:Log("BaseEntity: Take Damage: " .. tostring(damageContainer.Damage))
		local currentHealth = self.CharacterModel:GetAttribute("HealthCurrent")
		local newHealth = currentHealth - damageContainer.Damage
		warn("BaseEntity: Current Health: " .. tostring(currentHealth))
		warn("BaseEntity: New Health: " .. tostring(newHealth))
		self.Health:setCurrentValue(newHealth)
	end
	function BaseGameCharacter:handleCharacterDealtDamage(enemy, damageContainer)
		Logger:Log("BaseEntity: Dealt Damage: ", damageContainer.Damage)
	end
	function BaseGameCharacter:handleStatusEffectAdded(statusEffect)
		Logger:Log("BaseEntity: Status Effect Added: ", statusEffect.Name)
	end
	function BaseGameCharacter:handleStatusEffectRemoved(statusEffect)
		Logger:Log("BaseEntity: Status Effect Removed: ", statusEffect.Name)
	end
	function BaseGameCharacter:handleStatusEffectStarted(statusEffect)
		Logger:Log("BaseEntity: Status Effect Started: ", statusEffect.Name)
	end
	function BaseGameCharacter:handleStatusEffectEnded(statusEffect)
		Logger:Log("BaseEntity: Status Effect Ended: ", statusEffect.Name)
	end
	function BaseGameCharacter:updateAttributes()
		-- Set the Max Values
		local MaxStamina = Calculator.calculateMaxStamina(self.StatsData.Speed, 11)
		local MaxMana = Calculator.calculateMaxMana(self.StatsData.Intelligence, 11)
		local MaxHealth = Calculator.calculateMaxHealth(self.StatsData.Constitution, 11)
		-- Set the Stats Attributes
		self.CharacterModel:SetAttribute("Strength", self.StatsData.Strength)
		self.CharacterModel:SetAttribute("Dexterity", self.StatsData.Dexterity)
		self.CharacterModel:SetAttribute("Intelligence", self.StatsData.Intelligence)
		self.CharacterModel:SetAttribute("Constitution", self.StatsData.Constitution)
		self.CharacterModel:SetAttribute("Speed", self.StatsData.Speed)
	end
	function BaseGameCharacter:destroyConnections()
		local _result = self._connectionCharacterTakeDamage
		if _result ~= nil then
			_result:Disconnect()
		end
		local _result_1 = self._connectionCharacterDealtDamage
		if _result_1 ~= nil then
			_result_1:Disconnect()
		end
		local _result_2 = self._connectionStatusEffectAdded
		if _result_2 ~= nil then
			_result_2:Disconnect()
		end
		local _result_3 = self._connectionStatusEffectRemoved
		if _result_3 ~= nil then
			_result_3:Disconnect()
		end
		local _result_4 = self._connectionStatusEffectStarted
		if _result_4 ~= nil then
			_result_4:Disconnect()
		end
		local _result_5 = self._connectionStatusEffectEnded
		if _result_5 ~= nil then
			_result_5:Disconnect()
		end
	end
	function BaseGameCharacter:Destroy()
		self.Health:Destroy()
		self.Mana:Destroy()
		self.Stamina:Destroy()
		self:destroyConnections()
		self.WCS_Character:Destroy()
	end
end
-- PlayerGameCharacter (Inherits from BaseGameCharacter)
local PlayerGameCharacter
do
	local super = BaseGameCharacter
	PlayerGameCharacter = setmetatable({}, {
		__tostring = function()
			return "PlayerGameCharacter"
		end,
		__index = super,
	})
	PlayerGameCharacter.__index = PlayerGameCharacter
	function PlayerGameCharacter.new(...)
		local self = setmetatable({}, PlayerGameCharacter)
		return self:constructor(...) or self
	end
	function PlayerGameCharacter:constructor(player)
		-- Get Character
		local character = player.Character or (player.CharacterAdded:Wait())
		if character == nil then
			Logger:ErrorLog("PlayerGameCharacter: Character Model not found")
			error("PlayerGameCharacter: Character Model not found")
		end
		-- Super Constructor
		super.constructor(self, character)
		-- Assign Player
		self._player = player
		-- Assign PlayerGui
		self._playerGui = player:WaitForChild("PlayerGui")
		Logger:Log(script.Name, "PlayerGameCharacter Created: " .. player.Name)
		return self
	end
	function PlayerGameCharacter:Destroy()
		super.Destroy(self)
	end
end
return {
	BaseGameCharacter = BaseGameCharacter,
	PlayerGameCharacter = PlayerGameCharacter,
}
