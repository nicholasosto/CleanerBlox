-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Roblox Services
-- WCS System
local CreateServer = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateServer
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
-- Custom Imports
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local InventoryService = TS.import(script, game:GetService("ServerScriptService"), "TS", "Services", "InventoryService").InventoryService
local EntityManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "EntityManager").EntityManager
local NotificationManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Notification", "NotificationManager").NotificationManager
--Services Needing to Start
DataManager:Start()
-- Inventory Service
InventoryService:Start()
-- Entity Manager
EntityManager:Start()
-- Notification Manager
NotificationManager:Start()
-- WCS Server Start
local WCSServer = CreateServer()
WCSServer:RegisterDirectory(WCSFolders.Skills)
WCSServer:RegisterDirectory(WCSFolders.Movesets)
WCSServer:RegisterDirectory(WCSFolders.StatusEffects)
WCSServer:Start()
--[[
	
	// Handle Character Added
	function handleCharacterAdded(character: Model) {
		Logger.Log("Character Added", character.Name);
	}
	
	// Handle Player Added
	function handlePlayerAdded(player: Player) {
		player.CharacterAdded.Connect(handleCharacterAdded);
	}
	
	// Connect Player Added
	Players.PlayerAdded.Connect(handlePlayerAdded);
	
	Character.CharacterCreated.Connect((character) => {
		warn("WCS Character Created", character);
	});
	
	
	// Test Functions
	function getAIResponse(prompt: string) {
		const apiKey = "sk-...";
		const response = HttpService.RequestAsync({
			Url: "https://api.openai.com/v1/chat/completions",
			Method: "POST",
			Headers: {
				"Content-Type": "application/json",
				Authorization: `Bearer ${apiKey}`,
			},
			Body: HttpService.JSONEncode({
				model: "gpt-3.5-turbo",
				messages: [{ role: "user", content: prompt }],
			}),
		});
		return HttpService.JSONDecode(response.Body);
	}
	
]]
