-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local ReplicatedStorage = _services.ReplicatedStorage
local Players = _services.Players
local Workspace = _services.Workspace
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local CreateServer = _wcs.CreateServer
local Character = _wcs.Character
local DataService = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataService").DataService
local CharacterConfigurator = TS.import(script, game:GetService("ServerScriptService"), "TS", "Test Ideas", "CharacterConfigurator").CharacterConfigurator
local DefaultMoveset = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Movesets", "DefaultMoveset").DefaultMoveset
local AnimationManager = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "AnimationManager").AnimationManager
local dataService = DataService.new()
local skillsFolder = ReplicatedStorage:FindFirstChild("Skills", true)
local movesetFolder = ReplicatedStorage:FindFirstChild("Movesets", true)
local statusEffectsFolder = ReplicatedStorage:FindFirstChild("StatusEffects", true)
local ToadiesFolder = Workspace:WaitForChild("ToadArmy")
local WCSServer = CreateServer()
if skillsFolder and movesetFolder and statusEffectsFolder then
	WCSServer:RegisterDirectory(skillsFolder)
	WCSServer:RegisterDirectory(movesetFolder)
	WCSServer:RegisterDirectory(statusEffectsFolder)
end
WCSServer:Start()
local characterConfigurator = CharacterConfigurator.new()
Players.PlayerAdded:Connect(function(Player)
	local userId = Player.UserId
	Player.CharacterAdded:Connect(function(CharacterModel)
		-- apply the wrap when character model gets created
		local WCS_Character = Character.new(CharacterModel)
		local _exp = ToadiesFolder:GetChildren()
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _callback = function(child)
			return child:IsA("Model")
		end
		local _length = 0
		for _k, _v in _exp do
			if _callback(_v, _k - 1, _exp) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		local ToadieModels = _newValue
		local WCS_Toadies = {}
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(ToadieModel)
			local ToadieCharacter = Character.new(ToadieModel)
			table.insert(WCS_Toadies, ToadieCharacter)
			ToadieCharacter:ApplySkillsFromMoveset(DefaultMoveset)
			AnimationManager:RegisterAnimationsFor(ToadieCharacter)
		end
		for _k, _v in ToadieModels do
			_callback_1(_v, _k - 1, ToadieModels)
		end
		-- ▲ ReadonlyArray.forEach ▲
		WCS_Character:ApplySkillsFromMoveset(DefaultMoveset)
		AnimationManager:RegisterAnimationsFor(WCS_Character)
		-- destroy it when humanoid dies
		local humanoid = CharacterModel:WaitForChild("Humanoid")
		humanoid.Died:Once(function()
			return WCS_Character:Destroy()
		end)
	end)
end)
