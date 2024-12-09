-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Game Services
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local ReplicatedStorage = _services.ReplicatedStorage
local Players = _services.Players
local UserInputService = _services.UserInputService
local KeyboardClient = TS.import(script, script.Parent, "Keyboard").KeyboardClient
local UIService = TS.import(script, script.Parent, "UI", "UIService").UIService
--import { ActionBar } from "./ActionBar";
-- Keyboard Client
-- To use this class
local keyboardClient = KeyboardClient.new()
-- WCS
local CreateClient = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateClient
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
-- WCS: get the folders we need to register
local skillsFolder = ReplicatedStorage:FindFirstChild("Skills", true)
local movesetFolder = ReplicatedStorage:FindFirstChild("Movesets", true)
local statusEffectsFolder = ReplicatedStorage:FindFirstChild("StatusEffects", true)
-- WCS: create the client
local Client = CreateClient()
-- WCS: register the folders
if skillsFolder and movesetFolder and statusEffectsFolder then
	Client:RegisterDirectory(skillsFolder)
	Client:RegisterDirectory(movesetFolder)
	Client:RegisterDirectory(statusEffectsFolder)
end
-- WCS: start the client
Client:Start()
-- UI Service
local uiService = UIService.new(Players.LocalPlayer:WaitForChild("PlayerGui"))
-- WCS: get the current character
local function getCurrentWCS_Character()
	local characterModel = Players.LocalPlayer.Character
	local character = Character.GetCharacterFromInstance(characterModel)
	if not character then
		return nil
	end
	return character
end
-- Input Handling
local function handleKeyboardInputBegan(Input, character)
	local _exp = Input.KeyCode
	repeat
		if _exp == (Enum.KeyCode.F) then
			local _result = character:GetSkillFromString("Block")
			if _result ~= nil then
				_result:Start()
			end
			break
		end
		if _exp == (Enum.KeyCode.E) then
			local _result = character:GetSkillFromString("Spotlights")
			if _result ~= nil then
				_result:Start()
			end
			break
		end
	until true
end
local function handleKeyboardInputEnded(Input, character)
	local _exp = Input.KeyCode
	repeat
		if _exp == (Enum.KeyCode.F) then
			local _result = character:GetSkillFromString("Block")
			if _result ~= nil then
				_result:Stop()
			end
			break
		end
		if _exp == (Enum.KeyCode.E) then
			local _result = character:GetSkillFromString("Spotlights")
			if _result ~= nil then
				_result:Stop()
			end
			break
		end
	until true
end
local function handleInputBegan(Input, GameProcessed)
	if GameProcessed then
		return nil
	end
	local character = getCurrentWCS_Character()
	if not character then
		return nil
	end
	local _exp = Input.UserInputType
	repeat
		if _exp == (Enum.UserInputType.Keyboard) then
			handleKeyboardInputBegan(Input, character)
			break
		end
		if _exp == (Enum.UserInputType.MouseButton1) then
			local _result = character:GetSkillFromString("Attack")
			if _result ~= nil then
				_result:Start()
			end
			break
		end
		if _exp == (Enum.UserInputType.MouseButton2) then
			local _result = character:GetSkillFromString("Block")
			if _result ~= nil then
				_result:Start()
			end
			break
		end
		print("Unhandled Input", Input.KeyCode)
	until true
end
local function handleInputEnded(Input, GameProcessed)
	if GameProcessed then
		return nil
	end
	-- get the current character from WCS
	local character = getCurrentWCS_Character()
	if not character then
		return nil
	end
	local _exp = Input.UserInputType
	repeat
		if _exp == (Enum.UserInputType.Keyboard) then
			handleKeyboardInputEnded(Input, character)
			break
		end
		if _exp == (Enum.UserInputType.MouseButton1) then
			local _result = character:GetSkillFromString("Attack")
			if _result ~= nil then
				_result:Stop()
			end
			break
		end
		if _exp == (Enum.UserInputType.MouseButton2) then
			local _result = character:GetSkillFromString("Block")
			if _result ~= nil then
				_result:Stop()
			end
			break
		end
		print("Unhandled Input", Input.KeyCode)
	until true
end
UserInputService.InputBegan:Connect(handleInputBegan)
UserInputService.InputEnded:Connect(handleInputEnded)
