-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Game Services
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local ReplicatedStorage = _services.ReplicatedStorage
local KeyboardClient = TS.import(script, script.Parent, "Keyboard").KeyboardClient
local UIService = TS.import(script, script.Parent, "UI", "UIService").UIService
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Character = _wcs.Character
local CreateClient = _wcs.CreateClient
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local ClientSkillManager = TS.import(script, script.Parent, "ClientSkillManager").ClientSkillManager
-- Events
local connectionSkillSlotRequest = ReplicatedStorage:FindFirstChild("SKILL_GetSlots", true)
-- const connectionSkillInventoryRequest = ReplicatedStorage.FindFirstChild("SKILL_GetInventory", true) as RemoteEvent;
--const connectionAssignSlotRequest = ReplicatedStorage.FindFirstChild("SKILL_AssignSlot", true) as RemoteEvent;
ClientSkillManager:Start()
-- UI Service Start
UIService:Start()
UIService:LoadActionBar()
-- WCS Client Start
local wcsClient = CreateClient()
wcsClient:RegisterDirectory(WCSFolders.Skills)
wcsClient:RegisterDirectory(WCSFolders.Movesets)
wcsClient:RegisterDirectory(WCSFolders.StatusEffects)
wcsClient:Start()
-- Handle Character Added
local function handleCharacterAdded(character)
	local keyboardClient = KeyboardClient.new(character)
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
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
	connectionSkillSlotRequest:FireServer(Players.LocalPlayer)
	task.wait(1)
end
-- Handle Character Removing
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
-- connectionSkillSlotRequest.OnClientEvent.Connect((data: SkillsData) => {
-- 	Logger.Log("Client", "Skill Slots", data);
-- 	const SkillInventoryScroller = playerGui.WaitForChild("Developer").WaitForChild("SkillsInventory").WaitForChild("InventoryItems");
-- });
