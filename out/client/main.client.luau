-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Game Services
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local CreateClient = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateClient
-- Controllers
local KeyboardController = TS.import(script, script.Parent, "Controllers", "KeyboardController").KeyboardController
local SkillController = TS.import(script, script.Parent, "Controllers", "SkillController").SkillController
local FlightController = TS.import(script, script.Parent, "Controllers", "FlightController").FlightController
local GUIController = TS.import(script, script.Parent, "Controllers", "GUIController").GUIController
-- References
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local CommunicationGod = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Events", "CommunicationGod").CommunicationGod
-- Start Controllers
KeyboardController:Start()
SkillController:Start()
FlightController:Start()
GUIController:Start()
CommunicationGod:Summon()
--UIController.Start();
-- WCS Client Start
local wcsClient = CreateClient()
wcsClient:RegisterDirectory(WCSFolders.Skills)
wcsClient:RegisterDirectory(WCSFolders.Movesets)
wcsClient:RegisterDirectory(WCSFolders.StatusEffects)
wcsClient:Start()
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
