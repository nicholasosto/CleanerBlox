-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Roblox Services
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local CollectionService = _services.CollectionService
local BaseGameCharacter = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "Classes", "BaseGameCharacter").BaseGameCharacter
-- WCS System
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Character = _wcs.Character
local CreateServer = _wcs.CreateServer
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
-- Custom Imports
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
--import { InventoryService } from "./Services/InventoryService";
local GameCharacterRegistry = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "CharacterManager").GameCharacterRegistry
--import { NotificationManager } from "./Notification/NotificationManager";
--import { Logger } from "shared/Utility/Logger";
--Services Needing to Start
DataManager:Start()
-- Inventory Service
--InventoryService.Start();
-- Entity Manager
GameCharacterRegistry:Start()
-- Notification Manager
--NotificationManager.Start();
-- WCS Server Start
local WCSServer = CreateServer()
WCSServer:RegisterDirectory(WCSFolders.Skills)
WCSServer:RegisterDirectory(WCSFolders.Movesets)
WCSServer:RegisterDirectory(WCSFolders.StatusEffects)
WCSServer:Start()
-- TESTING
local NPCCollection = CollectionService:GetTagged("NPCCharacter")
-- ▼ ReadonlyArray.forEach ▼
local _callback = function(npc)
	local npcCharacter = BaseGameCharacter.new(npc)
	--Logger.Log(script.Name, "NPC Character: ", npcCharacter.CharacterName);
end
for _k, _v in NPCCollection do
	_callback(_v, _k - 1, NPCCollection)
end
-- ▲ ReadonlyArray.forEach ▲
-- END OF TESTING
-- Handle Character Added
local function handleCharacterAdded(character)
	--Logger.Log(script.Name, "Character Added: ", character);
end
-- Handle Player Added
local function handlePlayerAdded(player)
	player.CharacterAdded:Connect(handleCharacterAdded)
end
-- Connect Player Added
Players.PlayerAdded:Connect(handlePlayerAdded)
Character.CharacterCreated:Connect(function(character)
	--Logger.Log(script.Name, "WCS Character Created");
end)
