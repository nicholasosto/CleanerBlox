-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local EntityResource = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "Implementation", "EntityResource").EntityResource
local EntityAttachments = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "Implementation", "EntityAttachment").EntityAttachments
local Calculator = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "Implementation", "EntityCalculator")
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local BaseEntity
do
	BaseEntity = setmetatable({}, {
		__tostring = function()
			return "BaseEntity"
		end,
	})
	BaseEntity.__index = BaseEntity
	function BaseEntity.new(...)
		local self = setmetatable({}, BaseEntity)
		return self:constructor(...) or self
	end
	function BaseEntity:constructor(rig)
		self.StatsData = {
			Level = 1,
			Strength = 10,
			Dexterity = 10,
			Intelligence = 10,
			Constitution = 10,
			Speed = 10,
		}
		-- Set the CharacterModel
		self.CharacterModel = rig
		-- WCS Character
		self.WCS_Character = Character.new(rig)
		self.WCS_Character:ApplyMoveset("DefaultMoveset")
		-- Create the Entity Resources
		self.Health = EntityResource.new(rig, "Health", 200, 5, 11)
		self.Mana = EntityResource.new(rig, "Mana", 200, 5, 11)
		self.Stamina = EntityResource.new(rig, "Stamina", 200, 5, 11)
		-- Set the Attachments
		self.EntityAttachments = EntityAttachments.new(rig)
		self:setAttributes()
		local humanoid = rig:WaitForChild("Humanoid")
		humanoid.Died:Connect(function()
			self.WCS_Character:Destroy()
		end)
		return self
	end
	function BaseEntity:setAttributes()
		local _result = self
		if _result ~= nil then
			_result = _result.CharacterModel
		end
		Logger:Log("BaseEntity: Setting Attributes: ", _result)
		local rig = self.CharacterModel
		-- Health Calculation
		local maxHealth = Calculator.calculateMaxHealth(self.StatsData.Constitution, 11)
		self.Health = EntityResource.new(rig, "Health", maxHealth, 5, 11)
		-- Health Attributes
		-- this.CharacterModel.SetAttribute("MaxHealth", this.Health.MaxValue);
		-- this.CharacterModel.SetAttribute("CurrentHealth", this.Health.MaxValue);
		-- Mana Calculation
		local maxMana = Calculator.calculateMaxMana(self.StatsData.Intelligence, 11)
		self.Mana = EntityResource.new(rig, "Mana", maxMana, 5, 11)
		-- Mana Attributes
		-- this.CharacterModel.SetAttribute("MaxMana", this.Mana.MaxValue);
		-- this.CharacterModel.SetAttribute("CurrentMana", this.Mana.MaxValue);
		-- Stamina Calculation
		local maxStamina = Calculator.calculateMaxStamina(self.StatsData.Speed, 11)
		self.Stamina = EntityResource.new(rig, "Stamina", maxStamina, 5, 11)
		-- Stamina Attributes
		-- this.CharacterModel.SetAttribute("MaxStamina", this.Stamina.MaxValue);
		-- this.CharacterModel.SetAttribute("CurrentStamina", this.Stamina.MaxValue);
		-- Stats Attributes
		self.CharacterModel:SetAttribute("Strength", self.StatsData.Strength)
		self.CharacterModel:SetAttribute("Dexterity", self.StatsData.Dexterity)
		self.CharacterModel:SetAttribute("Intelligence", self.StatsData.Intelligence)
	end
	function BaseEntity:setTarget(target)
		self.Target = target
	end
end
return {
	BaseEntity = BaseEntity,
}
