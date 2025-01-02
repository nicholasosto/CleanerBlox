-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- GameCharacter.ts: Game Character Classes
-- BaseGameCharacter: Base Class for Game Characters
-- PlayerGameCharacter: Player Character
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local _GameAssetManagers = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "GameAssetManagers")
local GuiReferenceHandler = _GameAssetManagers.GuiReferenceHandler
local EGUIElements = _GameAssetManagers.EGUIElements
local EScreenGuis = _GameAssetManagers.EScreenGuis
local CharacterResource = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "Implementation", "CharacterResource").CharacterResource
-- Data Related Imports
local ESkillNames = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Interfaces", "RSkills").ESkillNames
local AbilityButton = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "UI", "AbilityButton").AbilityButton
-- Utility Imports
local ResourceCalculator = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "Implementation", "Calculators").ResourceCalculator
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
		self.Health = CharacterResource.new(self, "Health")
		self.Mana = CharacterResource.new(self, "Mana")
		self.Stamina = CharacterResource.new(self, "Stamina")
		-- Apply Default Moveset
		self.WCS_Character:ApplyMoveset(self._MovesetName)
		-- TODO: Add skill buttons to action bar in player gui
		-- Initialize Connections
		self:initializeConnections()
		return self
	end
	function BaseGameCharacter:onStateChange(newState)
		Logger:Log(script, "SuperClass-OnStateChange(): " .. newState)
	end
	function BaseGameCharacter:SetState(state)
		Logger:Log(script, "SuperClass-SetState(): " .. state)
		self.CharacterModel:SetAttribute("State", state)
		self._State = self.CharacterModel:GetAttribute("State")
	end
	function BaseGameCharacter:initializeConnections()
		self:destroyConnections()
		self._connectionCharacterTakeDamage = self.WCS_Character.DamageTaken:Connect(function(damage)
			Logger:Log(script, "SuperClass-TakeDamage(): " .. tostring(damage))
			self:handleCharacterTakeDamage(damage)
		end)
		self._connectionCharacterDealtDamage = self.WCS_Character.DamageDealt:Connect(function(enemy, damage)
			Logger:Log(script, "SuperClass-DealDamage(): " .. tostring(damage))
			self:handleCharacterDealtDamage(enemy, damage)
		end)
		self._connectionStatusEffectAdded = self.WCS_Character.StatusEffectAdded:Connect(function(statusEffect)
			Logger:Log(script, "SuperClass-StatusEffectAdded(): " .. tostring(statusEffect))
			self:handleStatusEffectAdded(statusEffect)
		end)
		self._connectionStatusEffectRemoved = self.WCS_Character.StatusEffectRemoved:Connect(function(statusEffect)
			Logger:Log(script, "SuperClass-StatusEffectRemoved(): " .. tostring(statusEffect))
			self:handleStatusEffectRemoved(statusEffect)
		end)
		self._connectionStatusEffectStarted = self.WCS_Character.StatusEffectStarted:Connect(function(statusEffect)
			Logger:Log(script, "SuperClass-StatusEffectStarted(): " .. tostring(statusEffect))
			self:handleStatusEffectStarted(statusEffect)
		end)
		self._connectionStatusEffectEnded = self.WCS_Character.StatusEffectEnded:Connect(function(statusEffect)
			Logger:Log(script, "SuperClass-StatusEffectEnded(): " .. tostring(statusEffect))
			self:handleStatusEffectEnded(statusEffect)
		end)
	end
	function BaseGameCharacter:handleCharacterTakeDamage(damageContainer)
		Logger:Log(script, "BaseEntity: Take Damage: " .. tostring(damageContainer.Damage))
		local currentHealth = self.CharacterModel:GetAttribute("HealthCurrent")
		local newHealth = currentHealth - damageContainer.Damage
		warn("BaseEntity: Current Health: " .. tostring(currentHealth))
		warn("BaseEntity: New Health: " .. tostring(newHealth))
		self.Health:SetCurrent(newHealth)
	end
	function BaseGameCharacter:handleCharacterDealtDamage(enemy, damageContainer)
		Logger:Log(script, "BaseEntity: Dealt Damage: ", damageContainer.Damage)
	end
	function BaseGameCharacter:handleStatusEffectAdded(statusEffect)
		Logger:Log(script, "BaseEntity: Status Effect Added: ", statusEffect.Name)
	end
	function BaseGameCharacter:handleStatusEffectRemoved(statusEffect)
		Logger:Log(script, "BaseEntity: Status Effect Removed: ", statusEffect.Name)
	end
	function BaseGameCharacter:handleStatusEffectStarted(statusEffect)
		Logger:Log(script, "BaseEntity: Status Effect Started: ", statusEffect.Name)
	end
	function BaseGameCharacter:handleStatusEffectEnded(statusEffect)
		Logger:Log(script, "BaseEntity: Status Effect Ended: ", statusEffect.Name)
	end
	function BaseGameCharacter:updateAttributes()
		-- Set the Max Values
		local MaxStamina = ResourceCalculator:calculateMaxStamina(self.StatsData.Speed, self.StatsData.Level)
		local MaxMana = ResourceCalculator:calculateMaxMana(self.StatsData.Intelligence, self.StatsData.Level)
		local MaxHealth = ResourceCalculator:calculateMaxHealth(self.StatsData.Constitution, self.StatsData.Level)
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
			Logger:Log(script, "PlayerGameCharacter: Character not found")
			error("PlayerGameCharacter: Character Model not found")
		end
		-- Super Constructor: BaseGameCharacter
		super.constructor(self, character)
		self._abilityButtons = {}
		-- Assign Player
		self._player = player
		-- DataCache
		self._dataCache = DataManager:GetDataCache(tostring(player.UserId))
		-- Assign GUI
		self._playerGui = player:WaitForChild("PlayerGui")
		-- HUD GUI
		self._hudGui = GuiReferenceHandler:getScreenGui(player, EScreenGuis.HUD)
		-- Action Bar
		self._actionBar = GuiReferenceHandler:getUIElement(player, EScreenGuis.HUD, EGUIElements.ActionBar)
		-- Character Frame
		self._characterFrame = GuiReferenceHandler:getUIElement(player, EScreenGuis.HUD, EGUIElements.CharacterFrame)
		-- Create Ability Buttons
		self:createAbilityButton(ESkillNames.BasicMelee, 1)
		Logger:Log(script, "PlayerGameCharacter Created: \n", self._characterFrame, " ", self._actionBar, " ", self._hudGui)
		local _exp = self.WCS_Character:GetSkills()
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(skill)
			print(" - ", skill:GetName())
		end
		for _k, _v in _exp do
			_callback(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.forEach ▲
		return self
	end
	function PlayerGameCharacter:createAbilityButton(skillName, slot)
		local skill = self.WCS_Character:GetSkillFromString(skillName)
		if skill == nil then
			Logger:Log(script.Name, "Skill not found")
		end
		local abilityButton = AbilityButton.new(self._actionBar, skill, slot)
		local __abilityButtons = self._abilityButtons
		local _skillName = skillName
		__abilityButtons[_skillName] = abilityButton
	end
	function PlayerGameCharacter:Destroy()
		super.Destroy(self)
	end
end
return {
	BaseGameCharacter = BaseGameCharacter,
	PlayerGameCharacter = PlayerGameCharacter,
}
