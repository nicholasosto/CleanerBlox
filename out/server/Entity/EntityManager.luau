-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier 
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local BaseEntity = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "Implementation", "Entity").BaseEntity
local CommunicationGod = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Experimental", "CommunicationGod").CommunicationGod
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
	EntityManager._entityCreatedEvent = CommunicationGod.ServerSignals.Entity_Created
end
return {
	EntityManager = EntityManager,
}
