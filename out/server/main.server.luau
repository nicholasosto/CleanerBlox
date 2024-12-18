-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local CreateServer = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateServer
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local EntityManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "EntityManager").EntityManager
local CommunicationGod = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Events", "CommunicationGod").CommunicationGod
-- testRig
local testRig = game.Workspace:WaitForChild("Positional Testing"):WaitForChild("TestRig")
local animator = testRig:FindFirstChild("Animator", true)
local testAnimation = Instance.new("Animation")
testAnimation.Name = "TestAnimation"
testAnimation.AnimationId = "rbxassetid://0"
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
