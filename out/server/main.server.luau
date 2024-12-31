-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local HttpService = _services.HttpService
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Character = _wcs.Character
local CreateServer = _wcs.CreateServer
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local InventoryService = TS.import(script, game:GetService("ServerScriptService"), "TS", "Services", "InventoryService").InventoryService
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local EntityManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Entity", "EntityManager").EntityManager
local AIInstanceCreator = TS.import(script, game:GetService("ServerScriptService"), "TS", "AI", "AIInstanceCreator").AIInstanceCreator
local TagGod = TS.import(script, game:GetService("ServerScriptService"), "TS", "TagClasses", "TagGod").TagGod
local NotificationManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Notification", "NotificationManager").NotificationManager
local NPCController = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "NPCController").NPCController
local BasicMelee = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "BasicMelee").BasicMelee
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
local reduceHealth
local function handlePlayerAdded(player)
	player.CharacterAdded:Connect(handleCharacterAdded)
	reduceHealth()
end
-- Connect Player Added
Players.PlayerAdded:Connect(handlePlayerAdded)
function reduceHealth()
	local characters = Character.GetCharacterMap()
	while true do
		-- ▼ ReadonlyMap.size ▼
		local _size = 0
		for _ in characters do
			_size += 1
		end
		-- ▲ ReadonlyMap.size ▲
		if not (_size < 1) then
			break
		end
		wait(1)
		-- ▼ ReadonlyMap.size ▼
		local _size_1 = 0
		for _ in characters do
			_size_1 += 1
		end
		-- ▲ ReadonlyMap.size ▲
		Logger:Log("Main", "Waiting for Characters, size: " .. tostring(_size_1))
		characters = Character.GetCharacterMap()
	end
	-- ▼ ReadonlyMap.forEach ▼
	local _callback = function(character)
		character.DamageTaken:Connect(function(damage)
			Logger:Log("Main", "XDamage Taken: " .. tostring(damage.Damage))
		end)
	end
	for _k, _v in characters do
		_callback(_v, _k, characters)
	end
	-- ▲ ReadonlyMap.forEach ▲
	repeat
		do
			-- ▼ ReadonlyMap.forEach ▼
			local _callback_1 = function(character)
				local MeleeSkill = character:GetSkillFromConstructor(BasicMelee)
				local _DamageContainer = MeleeSkill
				if _DamageContainer ~= nil then
					_DamageContainer = _DamageContainer.DamageContainer
				end
				local DamageContainer = _DamageContainer
				if DamageContainer == nil then
					Logger:Log("Main", "No Damage Container Found")
					return nil
				end
				local damage = character:TakeDamage(DamageContainer)
				Logger:Log("Main", "Damage Taken: " .. tostring(damage.Damage))
			end
			for _k, _v in characters do
				_callback_1(_v, _k, characters)
			end
			-- ▲ ReadonlyMap.forEach ▲
			wait(1)
		end
		-- ▼ ReadonlyMap.size ▼
		local _size = 0
		for _ in characters do
			_size += 1
		end
		-- ▲ ReadonlyMap.size ▲
	until not (_size > 0)
end
local function getAIResponse(prompt)
	local apiKey = "sk-..."
	local response = HttpService:RequestAsync({
		Url = "https://api.openai.com/v1/chat/completions",
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
			Authorization = `Bearer {apiKey}`,
		},
		Body = HttpService:JSONEncode({
			model = "gpt-3.5-turbo",
			messages = { {
				role = "user",
				content = prompt,
			} },
		}),
	})
	return HttpService:JSONDecode(response.Body)
end
