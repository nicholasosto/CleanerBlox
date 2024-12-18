-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local CreateServer = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateServer
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local EntityManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "EntityManager").EntityManager
local AIInstanceCreator = TS.import(script, game:GetService("ServerScriptService"), "TS", "AI", "AIInstanceCreator").AIInstanceCreator
local TagGod = TS.import(script, game:GetService("ServerScriptService"), "TS", "TagClasses", "TagGod").TagGod
local HttpService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").HttpService
local NotificationManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Notification", "NotificationManager").NotificationManager
DataManager:Start()
EntityManager:Start()
AIInstanceCreator:Start()
TagGod:Start()
NotificationManager:Start()
-- WCS Server Start
local WCSServer = CreateServer()
WCSServer:RegisterDirectory(WCSFolders.Skills)
WCSServer:RegisterDirectory(WCSFolders.Movesets)
WCSServer:RegisterDirectory(WCSFolders.StatusEffects)
WCSServer:Start()
-- Handle Character Added
local function handleCharacterAdded(character)
	Logger:Log("Main", "Character Added")
	local JSONTestString = HttpService:JSONEncode(WCSServer)
	local player = Players:GetPlayerFromCharacter(character)
	NotificationManager:Notify(player, "Welcome to the game!")
end
-- Handle Player Added
local function handlePlayerAdded(player)
	player.CharacterAdded:Connect(handleCharacterAdded)
end
-- Connect Player Added
Players.PlayerAdded:Connect(handlePlayerAdded)
