-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
-- WCS
local WCSFolders = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Folders").WCSFolders
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local CreateClient = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateClient
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
-- WCS Shared Folder
local ParentFolder = ReplicatedStorage:WaitForChild("TS"):WaitForChild("WCS")
-- WCS Folders
-- const skillsFolder = ParentFolder.WaitForChild("Skills");
-- const movesetFolder = ParentFolder.WaitForChild("Movesets");
-- const statusEffectsFolder = ParentFolder.WaitForChild("StatusEffects");
local WCSWrapper
do
	WCSWrapper = setmetatable({}, {
		__tostring = function()
			return "WCSWrapper"
		end,
	})
	WCSWrapper.__index = WCSWrapper
	function WCSWrapper.new(...)
		local self = setmetatable({}, WCSWrapper)
		return self:constructor(...) or self
	end
	function WCSWrapper:constructor()
		self.Player = Players.LocalPlayer
		Logger:Log("Wrapper", "Wrapper Created")
		self.Client = CreateClient()
		-- Register Folders
		self.Client:RegisterDirectory(WCSFolders.Skills)
		self.Client:RegisterDirectory(WCSFolders.Movesets)
		self.Client:RegisterDirectory(WCSFolders.StatusEffects)
		return self
	end
	function WCSWrapper:Start()
		Logger:Log("WCS", "Start")
		if WCSWrapper._instance then
			Logger:Log("WCS", "WCS Already Started")
			return WCSWrapper._instance
		end
		Logger:Log("WCS", "WCS Starting")
		WCSWrapper._instance = WCSWrapper.new()
		return WCSWrapper._instance
	end
	function WCSWrapper:RegisterCharacter(character)
		Logger:Log("WCS", "Register Character: ", character)
		local WCS_Character = Character.new(character)
	end
	function WCSWrapper:OnCharacterAdded(character)
		Logger:Log("WCSX", "Character Added: ", character)
		-- apply the wrap when character model gets created
		WCSWrapper.wcsCharacter = Character.new(character)
		Logger:Log("WCS", "WCS", WCSWrapper.wcsCharacter)
		-- destroy it when humanoid dies
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.Died:Once(function()
			if WCSWrapper.wcsCharacter then
				WCSWrapper.wcsCharacter:Destroy()
			end
		end)
	end
	WCSWrapper.getWCSCharacter = TS.async(function(self, characterModel)
		local character = Character.GetCharacterFromInstance(characterModel)
		return TS.Promise.new(function(resolve)
			resolve(character)
		end)
	end)
end
return {
	WCSWrapper = WCSWrapper,
}
