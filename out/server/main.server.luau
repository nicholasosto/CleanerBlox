-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local CreateServer = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateServer
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local EntityManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "EntityManager").EntityManager
local CommunicationGod = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Events", "CommunicationGod").CommunicationGod
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
-- Test imports
--const dataService = new DataService();
DataManager:Start()
EntityManager:Start()
CommunicationGod:Summon()
-- WCS Server Start
local WCSServer = CreateServer()
WCSServer:RegisterDirectory(WCSFolders.Skills)
WCSServer:RegisterDirectory(WCSFolders.Movesets)
WCSServer:RegisterDirectory(WCSFolders.StatusEffects)
WCSServer:Start()
-- Handle Character Added
local function handleCharacterAdded(character)
	Logger:Log("Main", "Character Added")
	warn("GameModels")
	local _exp = GameStorage:getUniqueModelNameswithinWorkspace()
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(name)
		print(name)
	end
	for _k, _v in _exp do
		_callback(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.forEach ▲
	local humanoid = character:WaitForChild("Humanoid")
	local connection = humanoid.HealthChanged:Connect(function(health)
		warn("Health Changed: ", health)
	end)
	local connection2 = humanoid.StateChanged:Connect(function(oldState, newState)
		warn("State Changed: ")
		print(oldState, " ==> ", newState)
	end)
end
-- Handle Player Added
local function handlePlayerAdded(player)
	-- Call DataManager OnPlayerJoined to load player data to the DataCache
	--DataManager.RegisterPlayer(player);
	-- Handle Character Added
	player.CharacterAdded:Connect(handleCharacterAdded)
end
-- Connect Player Added
Players.PlayerAdded:Connect(handlePlayerAdded)
