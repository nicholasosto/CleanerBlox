-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Game Services
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local KeyboardClient = TS.import(script, script.Parent, "Keyboard").KeyboardClient
local UIService = TS.import(script, script.Parent, "UI", "UIService").UIService
local WCSWrapper = TS.import(script, script.Parent, "WCSWrapper").WCSWrapper
local player = Players.LocalPlayer
UIService:Start()
UIService:LoadActionBar()
player.CharacterAdded:Connect(function(character)
	-- WCS Wrapper
	local wcsWrapper = WCSWrapper.new()
	wcsWrapper.Client:Start()
	local keyboardClient = KeyboardClient.new(character)
	local wcsCharacter = wcsWrapper.wcsCharacter
end)
player.CharacterRemoving:Connect(function(character)
	print("CLIENT: Character Removed: ", character)
end)
