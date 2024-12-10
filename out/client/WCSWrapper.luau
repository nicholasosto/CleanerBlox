-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
-- WCS
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local CreateClient = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateClient
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
-- WCS Shared Folder
local ParentFolder = ReplicatedStorage:WaitForChild("TS"):WaitForChild("WCS")
-- WCS Folders
local skillsFolder = ParentFolder:WaitForChild("Skills")
local movesetFolder = ParentFolder:WaitForChild("Movesets")
local statusEffectsFolder = ParentFolder:WaitForChild("StatusEffects")
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
		self.Client = CreateClient()
		-- Register Folders
		self:RegisterFolders()
		-- Get Player Character
		local character = self.Player.Character or (self.Player.CharacterAdded:Wait())
		self.wcsCharacter = WCSWrapper:getWCSCharacter(character)
		self.wcsCharacter:andThen(function(character)
			print("WCSWrapper: WCS Character: ", character:GetAppliedProps())
		end)
		return self
	end
	function WCSWrapper:RegisterFolders()
		if skillsFolder and movesetFolder and statusEffectsFolder then
			print("WCSWrapper: Registering Folders")
			self.Client:RegisterDirectory(skillsFolder)
			self.Client:RegisterDirectory(movesetFolder)
			self.Client:RegisterDirectory(statusEffectsFolder)
		end
	end
	WCSWrapper.getWCSCharacter = TS.async(function(self, characterModel)
		local wcsCharacter = Character.GetCharacterFromInstance(characterModel)
		if wcsCharacter then
			return wcsCharacter
		end
		return TS.Promise.new(function(resolve)
			Players.LocalPlayer.CharacterAdded:Connect(function(newCharacter)
				local wcsCharacter = Character.GetCharacterFromInstance(newCharacter)
				if wcsCharacter then
					resolve(wcsCharacter)
				end
			end)
		end)
	end)
end
return {
	WCSWrapper = WCSWrapper,
}
