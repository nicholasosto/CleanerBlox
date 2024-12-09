-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local ReplicatedStorage = _services.ReplicatedStorage
local Players = _services.Players
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local CreateServer = _wcs.CreateServer
local Character = _wcs.Character
local DefaultMoveset = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Movesets", "DefaultMoveset").DefaultMoveset
local DataService = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataService").DataService
local CharacterConfigurator = TS.import(script, game:GetService("ServerScriptService"), "TS", "Test Ideas", "CharacterConfigurator").CharacterConfigurator
local dataService = DataService.new()
local skillsFolder = ReplicatedStorage:FindFirstChild("Skills", true)
local movesetFolder = ReplicatedStorage:FindFirstChild("Movesets", true)
local statusEffectsFolder = ReplicatedStorage:FindFirstChild("StatusEffects", true)
local Server = CreateServer()
if skillsFolder and movesetFolder and statusEffectsFolder then
	Server:RegisterDirectory(skillsFolder)
	Server:RegisterDirectory(movesetFolder)
	Server:RegisterDirectory(statusEffectsFolder)
end
Server:Start()
local characterConfigurator = CharacterConfigurator.new()
Players.PlayerAdded:Connect(function(Player)
	local userId = Player.UserId
	Player.CharacterAdded:Connect(function(CharacterModel)
		-- apply the wrap when character model gets created
		local WCS_Character = Character.new(CharacterModel)
		local spotlightButton = Player:WaitForChild("PlayerGui"):WaitForChild("Action Bar"):FindFirstChild("SpotlightButton", true)
		print("SpotlightButton: ", spotlightButton)
		WCS_Character:ApplyMoveset(DefaultMoveset)
		WCS_Character.SkillStarted:Connect(function(skill)
			print(`Skill {skill:GetName()} started`)
		end)
		spotlightButton.Activated:Connect(function()
			print("Spotlight Button Activated")
			local _result = WCS_Character:GetSkillFromString("Spotlights")
			if _result ~= nil then
				_result:Start()
			end
		end)
		-- destroy it when humanoid dies
		local humanoid = CharacterModel:WaitForChild("Humanoid")
		humanoid.Died:Once(function()
			return WCS_Character:Destroy()
		end)
	end)
end)
