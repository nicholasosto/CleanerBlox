-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier 
local BaseGameCharacter = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "Classes", "BaseGameCharacter").BaseGameCharacter
local EventManager = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "GameAssetManagers").EventManager
local SkillsRef = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Character", "Skills")
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
-- PlayerGameCharacter (Inherits from BaseGameCharacter)
local PlayerGameCharacter
do
	local super = BaseGameCharacter
	PlayerGameCharacter = setmetatable({}, {
		__tostring = function()
			return "PlayerGameCharacter"
		end,
		__index = super,
	})
	PlayerGameCharacter.__index = PlayerGameCharacter
	function PlayerGameCharacter.new(...)
		local self = setmetatable({}, PlayerGameCharacter)
		return self:constructor(...) or self
	end
	function PlayerGameCharacter:constructor(player)
		-- Get Character
		local character = player.Character or (player.CharacterAdded:Wait())
		if character == nil then
			Logger:Log(script, "PlayerGameCharacter: Character not found")
			error("PlayerGameCharacter: Character Model not found")
		end
		-- Super Constructor: BaseGameCharacter
		super.constructor(self, character)
		-- Assign Player
		self._player = player
		-- DataCache
		self._dataCache = DataManager:GetDataCache(tostring(player.UserId))
		Logger:Log(script, "Skills: ", self._dataCache._playerData.Skills)
		local PlayerCharacterCreated = EventManager:GetEvent("PLAYER_CharacterCreated")
		PlayerCharacterCreated:FireClient(player)
		return self
	end
	function PlayerGameCharacter:Destroy()
		super.Destroy(self)
	end
end
return {
	PlayerGameCharacter = PlayerGameCharacter,
}
