-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Game Services
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local KeyboardClient = TS.import(script, script.Parent, "Keyboard").KeyboardClient
local UIService = TS.import(script, script.Parent, "UI", "UIService").UIService
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Character = _wcs.Character
local CreateClient = _wcs.CreateClient
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
UIService:Start()
UIService:LoadActionBar()
local wcsClient = CreateClient()
wcsClient:RegisterDirectory(WCSFolders.Skills)
wcsClient:RegisterDirectory(WCSFolders.Movesets)
wcsClient:RegisterDirectory(WCSFolders.StatusEffects)
wcsClient:Start()
-- function loadSignalButtonInstance(instanceName: string) {
-- 	const matchingInstanceNames = Players.LocalPlayer.WaitForChild("PlayerGui")
-- 		.GetDescendants()
-- 		.filter((descendant) => descendant.Name === instanceName);
-- 	// Button Instance
-- 	const buttonInstance = matchingInstanceNames.filter((instance) => instance.IsA("GuiButton"))[0];
-- 	// Check if button is already loaded
-- 	const existingButton = signalButtons.find((button) => button.getInstance() === buttonInstance);
-- 	// Create Signal Button
-- 	if (!existingButton) {
-- 		const signalButton = new SignalButton(buttonInstance, { name: instanceName });
-- 		signalButtons.push(signalButton);
-- 		Logger.Log("SignalButton", "Button Loaded: ", buttonInstance);
-- 	} else {
-- 		Logger.Log("SignalButton", "Button Already Loaded: ", buttonInstance);
-- 	}
-- }
local function handleCharacterAdded(character)
	local keyboardClient = KeyboardClient.new(character)
	Logger:Log("Client", "Character Added: ", character)
	local wcsCharacter = Character.GetLocalCharacter()
	local _result = wcsCharacter
	if _result ~= nil then
		local _exp = _result:GetSkills()
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(skill)
			return Logger:Log("Client", "Skill", skill:GetName())
		end
		for _k, _v in _exp do
			_callback(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
end
local function handleCharacterRemoving(character)
	Logger:Log("Client", "Character Removed: ", character)
end
-- Get character from LocalPlayer
local character = Players.LocalPlayer.Character
-- Check if character exists and perform Character Added event actions
if character then
	handleCharacterAdded(character)
end
-- Character Added/Removing Events
Players.LocalPlayer.CharacterAdded:Connect(handleCharacterAdded)
Players.LocalPlayer.CharacterRemoving:Connect(handleCharacterRemoving)
