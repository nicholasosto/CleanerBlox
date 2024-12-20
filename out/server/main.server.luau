-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local CreateServer = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateServer
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local InventoryService = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "Inventory", "InventoryService").InventoryService
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local EntityManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "EntityManager").EntityManager
local AIInstanceCreator = TS.import(script, game:GetService("ServerScriptService"), "TS", "AI", "AIInstanceCreator").AIInstanceCreator
local TagGod = TS.import(script, game:GetService("ServerScriptService"), "TS", "TagClasses", "TagGod").TagGod
local NotificationManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Notification", "NotificationManager").NotificationManager
-- Data and Data related services
DataManager:Start()
InventoryService:Start()
-- Entity Manager
EntityManager:Start()
-- Notification Manager
NotificationManager:Start()
-- Testing OK to remove if necessary
AIInstanceCreator:Start()
TagGod:Start()
-- WCS Server Start
local WCSServer = CreateServer()
WCSServer:RegisterDirectory(WCSFolders.Skills)
WCSServer:RegisterDirectory(WCSFolders.Movesets)
WCSServer:RegisterDirectory(WCSFolders.StatusEffects)
WCSServer:Start()
-- Handle Character Added
local function handleCharacterAdded(character)
	Logger:Log("Main", "Character Added")
	local player = Players:GetPlayerFromCharacter(character)
	local response = {
		success = true,
		message = "Character Added",
	}
	NotificationManager:Notify(player, response)
end
-- Handle Player Added
local function handlePlayerAdded(player)
	player.CharacterAdded:Connect(handleCharacterAdded)
end
-- Connect Player Added
Players.PlayerAdded:Connect(handlePlayerAdded)
