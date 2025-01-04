-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier 
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local PlayerGameCharacter = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "Classes", "PlayerGameCharacter").PlayerGameCharacter
local BaseGameCharacter = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "Classes", "BaseGameCharacter").BaseGameCharacter
local CommunicationGod = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Experimental", "CommunicationGod").CommunicationGod
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local GameCharacterRegistry
do
	GameCharacterRegistry = setmetatable({}, {
		__tostring = function()
			return "GameCharacterRegistry"
		end,
	})
	GameCharacterRegistry.__index = GameCharacterRegistry
	function GameCharacterRegistry.new(...)
		local self = setmetatable({}, GameCharacterRegistry)
		return self:constructor(...) or self
	end
	function GameCharacterRegistry:constructor()
		-- Handle Character Added
		GameCharacterRegistry._connectionCharacterAdded = Players.PlayerAdded:Connect(function(player)
			player.CharacterAdded:Connect(function(character)
				local playerGameCharacter = PlayerGameCharacter.new(player)
				Logger:Log(script, "Registering Player: ", playerGameCharacter._player.Name)
				local __playerCharacterMap = GameCharacterRegistry._playerCharacterMap
				local _arg0 = tostring(player.UserId)
				__playerCharacterMap[_arg0] = playerGameCharacter
			end)
		end)
	end
	function GameCharacterRegistry:Start()
		self:GetInstance()
	end
	function GameCharacterRegistry:GetInstance()
		if GameCharacterRegistry._instance == nil then
			GameCharacterRegistry._instance = GameCharacterRegistry.new()
		end
		return GameCharacterRegistry._instance
	end
	function GameCharacterRegistry:CreateEntity(rig)
		local entity = BaseGameCharacter.new(rig)
		local __characterMap = GameCharacterRegistry._characterMap
		local _name = rig.Name
		__characterMap[_name] = entity
	end
	function GameCharacterRegistry:GetEntity(name)
		local __characterMap = GameCharacterRegistry._characterMap
		local _name = name
		return __characterMap[_name]
	end
	function GameCharacterRegistry:GetPlayerCharacter(userId)
		local __playerCharacterMap = GameCharacterRegistry._playerCharacterMap
		local _arg0 = tostring(userId)
		return __playerCharacterMap[_arg0]
	end
	function GameCharacterRegistry:RemoveEntity(name)
		local __characterMap = GameCharacterRegistry._characterMap
		local _name = name
		__characterMap[_name] = nil
	end
	GameCharacterRegistry._characterMap = {}
	GameCharacterRegistry._playerCharacterMap = {}
	GameCharacterRegistry._entityCreatedEvent = CommunicationGod.ServerSignals.Entity_Created
end
return {
	GameCharacterRegistry = GameCharacterRegistry,
}
