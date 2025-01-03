-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Game Services
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local HttpService = _services.HttpService
local Players = _services.Players
-- Plugin Services
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local CreateClient = _wcs.CreateClient
local Character = _wcs.Character
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
local EventManager = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "GameAssetManagers").EventManager
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
-- Variables
local WCSCharacter
-- Handle Character Added
local function handleCharacterAdded(character)
	--const wcsCharacter = Character.GetCharacterFromInstance(character);
	--Logger.Log(script, "Client", "Character Added: ", HttpService.JSONEncode(wcsCharacter));
end
-- Handle Character Removing
local function handleCharacterRemoving(character)
	--Logger.Log(script,"Client", "Character Removed: ", character);
end
-- Check if character exists and perform Character Added event actions
if Players.LocalPlayer.Character then
	handleCharacterAdded(Players.LocalPlayer.Character)
end
-- Character Added/Removing Events
Players.LocalPlayer.CharacterAdded:Connect(handleCharacterAdded)
Players.LocalPlayer.CharacterRemoving:Connect(handleCharacterRemoving)
Character.CharacterCreated:Connect(function(character)
	WCSCharacter = character
	WCSCharacter.SkillAdded:Connect(function(skill)
		Logger:Log(script, "Client", "Skill Added: ", skill:GetMetadata())
	end)
end)
local PlayerCharacterCreated = EventManager:GetEvent("PLAYER_CharacterCreated")
PlayerCharacterCreated.OnClientEvent:Connect(function()
	local player = Players.LocalPlayer
	local character = player.Character or (player.CharacterAdded:Wait())
	local wcsCharacter = Character.GetCharacterFromInstance(character)
	local _skills = wcsCharacter
	if _skills ~= nil then
		_skills = _skills:GetSkills()
	end
	local skills = _skills
	if skills then
		Logger:Log(script, "Client", "PlayerCharacterCreated: ", HttpService:JSONEncode(skills))
	end
	Logger:Log(script, "Client", "PlayerCharacterCreated: ")
end)
