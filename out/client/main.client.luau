-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Game Services
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
-- Plugin Services
local CreateClient = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateClient
-- My Services
local ClientInventoryService = TS.import(script, script.Parent, "Services", "ClientInventoryService").ClientInventoryService
local ClientSkillService = TS.import(script, script.Parent, "Services", "ClientSkillService").ClientSkillService
-- Controllers
local KeyboardController = TS.import(script, script.Parent, "Controllers", "KeyboardController").KeyboardController
local FlightController = TS.import(script, script.Parent, "Controllers", "FlightController").FlightController
local GUIController = TS.import(script, script.Parent, "Controllers", "GUIController").GUIController
-- References
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local CommunicationGod = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Experimental", "CommunicationGod").CommunicationGod
-- Start Services
ClientInventoryService:Start()
ClientSkillService:Start()
--UIController.Start();
-- WCS Client Start
local wcsClient = CreateClient()
wcsClient:RegisterDirectory(WCSFolders.Skills)
wcsClient:RegisterDirectory(WCSFolders.Movesets)
wcsClient:RegisterDirectory(WCSFolders.StatusEffects)
wcsClient:Start()
-- Start Controllers
KeyboardController:Start()
FlightController:Start()
GUIController:Start()
CommunicationGod:Summon()
-- Handle Character Added
local function handleCharacterAdded(character)
	Logger:Log("Client", "Character Added: ", character)
end
-- Handle Character Removing
local function handleCharacterRemoving(character)
	Logger:Log("Client", "Character Removed: ", character)
end
-- Check if character exists and perform Character Added event actions
if Players.LocalPlayer.Character then
	handleCharacterAdded(Players.LocalPlayer.Character)
end
-- Character Added/Removing Events
Players.LocalPlayer.CharacterAdded:Connect(handleCharacterAdded)
Players.LocalPlayer.CharacterRemoving:Connect(handleCharacterRemoving)
