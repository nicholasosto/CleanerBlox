-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier 
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local EntityResource = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "Subclasses", "EntityResource").EntityResource
local Calculator = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "AttributeCalculations")
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local EntityAttachments
do
	EntityAttachments = setmetatable({}, {
		__tostring = function()
			return "EntityAttachments"
		end,
	})
	EntityAttachments.__index = EntityAttachments
	function EntityAttachments.new(...)
		local self = setmetatable({}, EntityAttachments)
		return self:constructor(...) or self
	end
	function EntityAttachments:constructor(rigModel)
		local _result = rigModel:FindFirstChild("LowerTorso")
		if _result ~= nil then
			_result = _result:FindFirstChild("WaistCenterAttachment")
		end
		self.Body = _result
		local _result_1 = rigModel:FindFirstChild("Head")
		if _result_1 ~= nil then
			_result_1 = _result_1:FindFirstChild("HairAttachment")
		end
		self.Head = _result_1
		local _result_2 = rigModel:FindFirstChild("LeftHand")
		if _result_2 ~= nil then
			_result_2 = _result_2:FindFirstChild("LeftGripAttachment")
		end
		self.LeftHand = _result_2
		local _result_3 = rigModel:FindFirstChild("RightHand")
		if _result_3 ~= nil then
			_result_3 = _result_3:FindFirstChild("RightGripAttachment")
		end
		self.RightHand = _result_3
		local _result_4 = rigModel:FindFirstChild("LeftFoot")
		if _result_4 ~= nil then
			_result_4 = _result_4:FindFirstChild("LeftFootAttachment")
		end
		self.LeftFoot = _result_4
		local _result_5 = rigModel:FindFirstChild("RightFoot")
		if _result_5 ~= nil then
			_result_5 = _result_5:FindFirstChild("RightFootAttachment")
		end
		self.RightFoot = _result_5
		local _result_6 = rigModel:FindFirstChild("Floor")
		if _result_6 ~= nil then
			_result_6 = _result_6:FindFirstChild("FloorAttachment")
		end
		self.Floor = _result_6
		local _result_7 = rigModel:FindFirstChild("Head")
		if _result_7 ~= nil then
			_result_7 = _result_7:FindFirstChild("HaloAttachment")
		end
		self.Halo = _result_7
		if not self.Halo then
			self.Halo = Instance.new("Attachment")
			self.Halo.Name = "HaloAttachment"
			self.Halo.Position = Vector3.new(0, 2, 0)
			self.Halo.Parent = rigModel:FindFirstChild("Head")
		end
		if not self.Floor then
			self.Floor = Instance.new("Attachment")
			self.Floor.Name = "FloorAttachment"
			self.Floor.Position = Vector3.new(0, -2, 0)
			self.Floor.Parent = rigModel:FindFirstChild("HumanoidRootPart")
		end
		if not self.Body or not self.Head or not self.LeftHand or not self.RightHand or not self.LeftFoot or not self.RightFoot or not self.Floor or not self.Halo then
			error("EntityAttachments: One or more attachments are missing")
		end
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
		self.StatsData = {
			Strength = 10,
			Dexterity = 10,
			Intelligence = 10,
			Constitution = 10,
			Speed = 10,
		}
		self.EntityResources = {
			Health = EntityResource.new("Health", 200, 5, 11),
			Mana = EntityResource.new("Mana", 200, 5, 11),
			Stamina = EntityResource.new("Stamina", 200, 5, 11),
		}
		-- Set the CharacterModel
		self.CharacterModel = rig
		-- WCS Character
		self.WCS_Character = Character.new(rig)
		self.WCS_Character:ApplyMoveset("DefaultMoveset")
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
		-- Health Calculation
		local maxHealth = Calculator.calculateMaxHealth(self.StatsData.Constitution, 11)
		self.EntityResources.Health = EntityResource.new("Health", maxHealth, 5, 11)
		-- Health Attributes
		self.CharacterModel:SetAttribute("MaxHealth", self.EntityResources.Health.MaxValue)
		self.CharacterModel:SetAttribute("CurrentHealth", self.EntityResources.Health.MaxValue)
		-- Mana Calculation
		local maxMana = Calculator.calculateMaxMana(self.StatsData.Intelligence, 11)
		self.EntityResources.Mana = EntityResource.new("Mana", maxMana, 5, 11)
		-- Mana Attributes
		self.CharacterModel:SetAttribute("MaxMana", self.EntityResources.Mana.MaxValue)
		self.CharacterModel:SetAttribute("CurrentMana", self.EntityResources.Mana.MaxValue)
		-- Stamina Calculation
		local maxStamina = Calculator.calculateMaxStamina(self.StatsData.Speed, 11)
		self.EntityResources.Stamina = EntityResource.new("Stamina", maxStamina, 5, 11)
		-- Stamina Attributes
		self.CharacterModel:SetAttribute("MaxStamina", self.EntityResources.Stamina.MaxValue)
		self.CharacterModel:SetAttribute("CurrentStamina", self.EntityResources.Stamina.MaxValue)
		-- Stats Attributes
		self.CharacterModel:SetAttribute("Strength", self.StatsData.Strength)
		self.CharacterModel:SetAttribute("Dexterity", self.StatsData.Dexterity)
		self.CharacterModel:SetAttribute("Intelligence", self.StatsData.Intelligence)
	end
	function BaseEntity:setTarget(target)
		self.Target = target
	end
end
local EntityManager
do
	EntityManager = setmetatable({}, {
		__tostring = function()
			return "EntityManager"
		end,
	})
	EntityManager.__index = EntityManager
	function EntityManager.new(...)
		local self = setmetatable({}, EntityManager)
		return self:constructor(...) or self
	end
	function EntityManager:constructor()
		EntityManager._connectionCharacterAdded = Players.PlayerAdded:Connect(function(player)
			player.CharacterAdded:Connect(function(character)
				local entity = BaseEntity.new(character)
				local __entities = EntityManager._entities
				local _name = character.Name
				__entities[_name] = entity
				local testAttachmentGroup = GameStorage:cloneParticleGroupAttachment("C - BLOOD SPLATTER")
				testAttachmentGroup.Parent = entity.EntityAttachments.Head
			end)
		end)
	end
	function EntityManager:Start()
		self:GetInstance()
	end
	function EntityManager:GetInstance()
		if EntityManager._instance == nil then
			EntityManager._instance = EntityManager.new()
		end
		return EntityManager._instance
	end
	function EntityManager:CreateEntity(rig)
		local entity = BaseEntity.new(rig)
		local __entities = EntityManager._entities
		local _name = rig.Name
		__entities[_name] = entity
	end
	function EntityManager:GetEntity(name)
		local __entities = EntityManager._entities
		local _name = name
		return __entities[_name]
	end
	function EntityManager:RemoveEntity(name)
		local __entities = EntityManager._entities
		local _name = name
		__entities[_name] = nil
	end
	EntityManager._entities = {}
end
return {
	EntityAttachments = EntityAttachments,
	BaseEntity = BaseEntity,
	EntityManager = EntityManager,
}
