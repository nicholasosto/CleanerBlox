-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local CollectionService = _services.CollectionService
local Players = _services.Players
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local CreateServer = _wcs.CreateServer
local Character = _wcs.Character
local DataService = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataService").DataService
local CharacterConfigurator = TS.import(script, game:GetService("ServerScriptService"), "TS", "Test Ideas", "CharacterConfigurator").CharacterConfigurator
local DefaultMoveset = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Movesets", "DefaultMoveset").DefaultMoveset
local AnimationManager = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "AnimationManager").AnimationManager
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local SkillPartClass = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Skill Parts", "SkillPart").SkillPartClass
local dataService = DataService.new()
-- Collection Service Tests
local skillParts = CollectionService:GetTagged("SkillPart")
-- ▼ ReadonlyArray.forEach ▼
local _callback = function(skillPart)
	local spotlightInstance = SkillPartClass.new(skillPart)
end
for _k, _v in skillParts do
	_callback(_v, _k - 1, skillParts)
end
-- ▲ ReadonlyArray.forEach ▲
-- WCS Server Start
local WCSServer = CreateServer()
WCSServer:RegisterDirectory(WCSFolders.Skills)
WCSServer:RegisterDirectory(WCSFolders.Movesets)
WCSServer:RegisterDirectory(WCSFolders.StatusEffects)
WCSServer:Start()
-- WCS Server End
local characterConfigurator = CharacterConfigurator.new()
local function handleCharacterAdded(character)
	-- WCS Character setup
	local WCS_Character = Character.new(character)
	WCS_Character:ApplySkillsFromMoveset(DefaultMoveset)
	local _exp = WCS_Character:GetSkills()
	-- ▼ ReadonlyArray.forEach ▼
	local _callback_1 = function(skill)
		return Logger:Log("WCS", "Skill", skill:GetName())
	end
	for _k, _v in _exp do
		_callback_1(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.forEach ▲
	-- Animation Manager
	AnimationManager:RegisterAnimationsFor(WCS_Character)
	-- WCS Cleanup
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.Died:Connect(function()
		Logger:Log("WCS", "Character Destroying", character)
		WCS_Character:Destroy()
	end)
end
Players.PlayerAdded:Connect(function(Player)
	local userId = Player.UserId
	Player.CharacterAdded:Connect(function(character)
		handleCharacterAdded(character)
	end)
end)
