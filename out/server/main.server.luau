-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local CreateServer = _wcs.CreateServer
local Character = _wcs.Character
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local CharacterConfigurator = TS.import(script, game:GetService("ServerScriptService"), "TS", "Test Ideas", "CharacterConfigurator").CharacterConfigurator
local DefaultMoveset = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Movesets", "DefaultMoveset").DefaultMoveset
local AnimationManager = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "AnimationManager").AnimationManager
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local ServerTests = TS.import(script, game:GetService("ServerScriptService"), "TS", "ServerTests").ServerTests
--const dataService = new DataService();
-- WCS Server Start
local WCSServer = CreateServer()
WCSServer:RegisterDirectory(WCSFolders.Skills)
WCSServer:RegisterDirectory(WCSFolders.Movesets)
WCSServer:RegisterDirectory(WCSFolders.StatusEffects)
WCSServer:Start()
-- WCS Server End
-- Server Tests
ServerTests:TestHomingSphere()
-- Server Tests End
local characterConfigurator = CharacterConfigurator.new()
local function handleCharacterAdded(character)
	local player = Players:GetPlayerFromCharacter(character)
	DataManager:OnCharacterSpawn(player)
	-- Log Character Added
	Logger:Log("Server", "\n------------   Character Added ---------------\n", character.Name)
	-- WCS Character setup
	local WCS_Character = Character.new(character)
	WCS_Character:ApplySkillsFromMoveset(DefaultMoveset)
	local _exp = WCS_Character:GetSkills()
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(skill)
		return Logger:Log("WCS", "Skill", skill:GetName())
	end
	for _k, _v in _exp do
		_callback(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.forEach ▲
	-- WCS Cleanup
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.Died:Connect(function()
		Logger:Log("WCS", "Character Destroying", character)
		WCS_Character:Destroy()
	end)
	-- Animation Manager
	AnimationManager:RegisterAnimationsFor(WCS_Character)
end
local function handlePlayerAdded(player)
	Logger:Log("Server", "\n------------   Player Joined ---------------\n", player.Name)
	-- Call DataManager OnPlayerJoined to load player data to the DataCache
	DataManager:RegisterPlayer(player)
	-- Handle Character Added
	player.CharacterAdded:Connect(handleCharacterAdded)
end
Players.PlayerAdded:Connect(handlePlayerAdded)
