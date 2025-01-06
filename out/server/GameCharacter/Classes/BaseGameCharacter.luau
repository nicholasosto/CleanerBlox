-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- GameCharacter.ts: Game Character Classes
-- BaseGameCharacter: Base Class for Game Characters
-- PlayerGameCharacter: Player Character
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local CharacterResource = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "Subclasses", "CharacterResource").CharacterResource
local CharacterAnimations = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Animations").CharacterAnimations
local getDefaultCharacterStats = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Character", "CharacterStats").getDefaultCharacterStats
local AnimationIds = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Indexes", "AssetIndex").AnimationIds
-- Utility Imports
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local BasicHold = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "BasicHold").BasicHold
local BasicRanged = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "BasicRanged").BasicRanged
local BasicRanged = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "BasicRanged").BasicRanged
local BasicMelee = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "BasicMelee").BasicMelee
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
		self.Animations = CharacterAnimations
		self.AnimationTracks = {}
		self._State = "Idle"
		-- Assign Character Name
		self.CharacterName = characterName
		self.CharacterStats = getDefaultCharacterStats()
		-- Assign Character Model
		self.CharacterModel = characterModel
		if self.CharacterModel == nil then
			error("BaseGameCharacter: Character Model not found")
		end
		-- Assign Animator
		self.Animator = self.CharacterModel:FindFirstChild("Animator", true)
		if self.Animator == nil then
			error("BaseGameCharacter: Animator not found")
		end
		-- Create WCS Character
		self.WCS_Character = Character.new(characterModel)
		-- Create Resources: Health, Mana, Stamina
		self.Health = CharacterResource.new(self, "Health")
		self.Mana = CharacterResource.new(self, "Mana")
		self.Stamina = CharacterResource.new(self, "Stamina")
		-- Assign Skills
		-- Assign Skills
		BasicMelee.new(self.WCS_Character)
		BasicHold.new(self.WCS_Character)
		BasicRanged.new(self.WCS_Character)
		BasicRanged.new(self.WCS_Character)
		-- Initialize Connections
		self:initializeConnections()
		self:_LoadAnimations()
		repeat
			do
				self:_PlayAnimation(AnimationIds.SKILL_BasicMelee)
				wait(1)
			end
		until not (self.AnimationTracks ~= nil)
		return self
	end
	function BaseGameCharacter:_AssignSkills(skillNames)
		-- TODO: Assign skills via skill names
	end
	function BaseGameCharacter:_LoadAnimations()
		-- Load Animations
		for animationName, animation in pairs(CharacterAnimations) do
			animation.Parent = self.CharacterModel
			animation.Name = animationName
			local animationTrack = self.Animator:LoadAnimation(animation)
			self.AnimationTracks[animationName] = animationTrack
		end
	end
	function BaseGameCharacter:_PlayAnimation(animationName)
		Logger:Log(script, "SuperClass-PlayAnimation(): " .. animationName)
		local _exp = self.AnimationTracks
		-- ▼ ReadonlyMap.forEach ▼
		local _callback = function(animationTrack)
			animationTrack:Stop()
		end
		for _k, _v in _exp do
			_callback(_v, _k, _exp)
		end
		-- ▲ ReadonlyMap.forEach ▲
		local _animationTracks = self.AnimationTracks
		local _animationName = animationName
		local animationTrack = _animationTracks[_animationName]
		if animationTrack then
			animationTrack:Play()
		end
	end
	function BaseGameCharacter:onStateChange(newState)
		Logger:Log(script, "SuperClass-OnStateChange(): " .. newState)
	end
	function BaseGameCharacter:SetState(state)
		Logger:Log(script, "SuperClass-SetState(): " .. state)
		self.CharacterModel:SetAttribute("State", state)
		self._State = self.CharacterModel:GetAttribute("State")
	end
	function BaseGameCharacter:updateAttributes()
		-- Set the Stats Attributes
		self.CharacterModel:SetAttribute("Strength", self.CharacterStats.Strength)
		self.CharacterModel:SetAttribute("Dexterity", self.CharacterStats.Dexterity)
		self.CharacterModel:SetAttribute("Intelligence", self.CharacterStats.Intelligence)
		self.CharacterModel:SetAttribute("Constitution", self.CharacterStats.Constitution)
		self.CharacterModel:SetAttribute("Speed", self.CharacterStats.Speed)
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
return {
	BaseGameCharacter = BaseGameCharacter,
}
