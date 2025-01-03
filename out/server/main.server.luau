-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Roblox Services
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local Workspace = _services.Workspace
local CollectionService = _services.CollectionService
-- WCS System
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Character = _wcs.Character
local CreateServer = _wcs.CreateServer
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
-- Custom Imports
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local InventoryService = TS.import(script, game:GetService("ServerScriptService"), "TS", "Services", "InventoryService").InventoryService
local EntityManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "CharacterManager").EntityManager
local NotificationManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Notification", "NotificationManager").NotificationManager
local _GameAssetManagers = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "GameAssetManagers")
local PackageManager = _GameAssetManagers.PackageManager
local EPackageIDs = _GameAssetManagers.EPackageIDs
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
--Test Imports
local BaseGameCharacter = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "Classes", "BaseGameCharacter").BaseGameCharacter
--END OF IMPORTS
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
-- TESTING
local NPCCollection = CollectionService:GetTagged("NPCCharacter")
-- ▼ ReadonlyArray.forEach ▼
local _callback = function(npc)
	local npcCharacter = BaseGameCharacter.new(npc)
	Logger:Log(script.Name, "NPC Character: ", npcCharacter.CharacterName)
end
for _k, _v in NPCCollection do
	_callback(_v, _k - 1, NPCCollection)
end
-- ▲ ReadonlyArray.forEach ▲
-- END OF TESTING
-- Handle Character Added
local function handleCharacterAdded(character)
	Logger:Log(script.Name, "Character Added: ", character)
end
-- Handle Player Added
local function handlePlayerAdded(player)
	player.CharacterAdded:Connect(handleCharacterAdded)
end
-- Connect Player Added
Players.PlayerAdded:Connect(handlePlayerAdded)
Character.CharacterCreated:Connect(function(character)
	Logger:Log(script.Name, "WCS Character Created")
	local _contents = PackageManager:LoadPackage(EPackageIDs.NPC)
	if _contents ~= nil then
		_contents = _contents:GetChildren()
	end
	local contents = _contents
	local _contentChild = contents
	if _contentChild ~= nil then
		_contentChild = _contentChild[1]
		if _contentChild ~= nil then
			_contentChild = _contentChild:GetChildren()
		end
	end
	local contentChild = _contentChild
	local _result = contentChild
	if _result ~= nil then
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(child)
			child.Parent = Workspace
		end
		for _k, _v in _result do
			_callback_1(_v, _k - 1, _result)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
end)
--[[
	
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
