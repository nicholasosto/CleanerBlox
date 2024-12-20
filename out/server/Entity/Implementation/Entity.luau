-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local DataTemplate = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataTemplate").DataTemplate
local EntityResource = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "Implementation", "EntityResource").EntityResource
local EntityAttachments = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "Implementation", "EntityAttachment").EntityAttachments
local Calculator = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "Implementation", "EntityCalculator")
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local AbilityButton
do
	AbilityButton = setmetatable({}, {
		__tostring = function()
			return "AbilityButton"
		end,
	})
	AbilityButton.__index = AbilityButton
	function AbilityButton.new(...)
		local self = setmetatable({}, AbilityButton)
		return self:constructor(...) or self
	end
	function AbilityButton:constructor(displayName, imageId, frame)
		Logger:Log("AbilityButton: Constructing")
		self._imageId = imageId
		self._progressBar = frame:FindFirstChild("Progress Bar", true)
		self._imageButton = frame:FindFirstChild("ImageButton", true)
		if self._imageButton == nil or self._progressBar == nil then
			Logger:Log("AbilityButton: Image Button not found")
			return nil
		end
		self._progressBar:SetAttribute("TextValue", displayName)
	end
end
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
		self.StatsData = DataTemplate.Stats
		self.MaxHealth = 15
		self.MaxMana = 15
		self.MaxStamina = 15
		self._eventEntityCreated = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ENTITY_Created")
		self._eventEntityDestroyed = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ENTITY_Destroyed")
		-- Set the CharacterModel
		self.CharacterModel = rig
		-- WCS Character
		self.WCS_Character = Character.new(rig)
		self.WCS_Character:ApplyMoveset("DefaultMoveset")
		local skill = self.WCS_Character:GetSkillFromString("ShapeTester")
		-- Set the Attachments
		self.EntityAttachments = EntityAttachments.new(rig)
		self:updateAttributes()
		-- Set the Resources
		self.Stamina = EntityResource.new(self.CharacterModel, "Stamina", self.MaxStamina, 1, 10)
		self.Mana = EntityResource.new(self.CharacterModel, "Mana", self.MaxMana, 1, 10)
		self.Health = EntityResource.new(self.CharacterModel, "Health", self.MaxHealth, 1, 10)
		local humanoid = rig:WaitForChild("Humanoid")
		local player = self.WCS_Character.Player
		local playerGui = player:WaitForChild("PlayerGui")
		local hudScreen = playerGui:WaitForChild("HUD")
		local abilitySlotsFrame = (hudScreen:FindFirstChild("AbilitySlots", true)):GetChildren()
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _callback = function(child)
			return child:IsA("Frame")
		end
		local _length = 0
		for _k, _v in abilitySlotsFrame do
			if _callback(_v, _k - 1, abilitySlotsFrame) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		local abilitySlots = _newValue
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(slot)
			local abilityButton = AbilityButton.new("ShapeTester", "102596975485791", slot)
		end
		for _k, _v in abilitySlots do
			_callback_1(_v, _k - 1, abilitySlots)
		end
		-- ▲ ReadonlyArray.forEach ▲
		if player then
			self._eventEntityCreated:FireClient(player)
		end
		humanoid.Died:Connect(function()
			local player = self.WCS_Character.Player
			if player then
				self._eventEntityDestroyed:FireClient(player)
			end
			self:Destroy()
		end)
		return self
	end
	function BaseEntity:updateAttributes()
		-- Set the Max Values
		self.MaxStamina = Calculator.calculateMaxStamina(self.StatsData.Speed, 11)
		self.MaxMana = Calculator.calculateMaxMana(self.StatsData.Intelligence, 11)
		self.MaxHealth = Calculator.calculateMaxHealth(self.StatsData.Constitution, 11)
		-- Set the Stats Attributes
		self.CharacterModel:SetAttribute("Strength", self.StatsData.Strength)
		self.CharacterModel:SetAttribute("Dexterity", self.StatsData.Dexterity)
		self.CharacterModel:SetAttribute("Intelligence", self.StatsData.Intelligence)
		self.CharacterModel:SetAttribute("Constitution", self.StatsData.Constitution)
		self.CharacterModel:SetAttribute("Speed", self.StatsData.Speed)
	end
	function BaseEntity:setTarget(target)
		self.Target = target
	end
	function BaseEntity:Destroy()
		--Logger.Log("BaseEntity: Destroying: ", this?.CharacterModel);
		self.Health:Destroy()
		self.Mana:Destroy()
		self.Stamina:Destroy()
		self.WCS_Character:Destroy()
	end
end
return {
	AbilityButton = AbilityButton,
	BaseEntity = BaseEntity,
}
