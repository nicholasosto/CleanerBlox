-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local CreateServer = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateServer
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local InventoryService = TS.import(script, game:GetService("ServerScriptService"), "TS", "Services", "InventoryService").InventoryService
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local EntityManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "EntityManager").EntityManager
local AIInstanceCreator = TS.import(script, game:GetService("ServerScriptService"), "TS", "AI", "AIInstanceCreator").AIInstanceCreator
local TagGod = TS.import(script, game:GetService("ServerScriptService"), "TS", "TagClasses", "TagGod").TagGod
local NotificationManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Notification", "NotificationManager").NotificationManager
local NPCController = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "NPCController").NPCController
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
-- NPC Testing
local function runNPCTesting(character)
	local NPCModel = game.Workspace:WaitForChild("First_Boss")
	local _result = NPCModel
	if _result ~= nil then
		_result:PivotTo(character:GetPivot())
	end
	if NPCModel then
		local NPC = NPCController.new(NPCModel)
		local _result_1 = NPC.rigModel:FindFirstChild("RightUpperArm")
		if _result_1 ~= nil then
			_result_1:Destroy()
		end
	else
		Logger:Log("Main", "NPC Model not found")
	end
end
-- Handle Character Added
local function handleCharacterAdded(character)
	Logger:Log("Main", "Character Added")
	runNPCTesting(character)
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
