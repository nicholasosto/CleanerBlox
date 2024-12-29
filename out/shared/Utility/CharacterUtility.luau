-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local CharacterUtility
do
	CharacterUtility = setmetatable({}, {
		__tostring = function()
			return "CharacterUtility"
		end,
	})
	CharacterUtility.__index = CharacterUtility
	function CharacterUtility.new(...)
		local self = setmetatable({}, CharacterUtility)
		return self:constructor(...) or self
	end
	function CharacterUtility:constructor()
	end
	function CharacterUtility:getClosestCharacterFrom(model, maxRange)
		local wcsCharacters = Character.GetCharacterMap()
		local closestCharacter
		local closestDistance = math.huge
		local modelPosition = model:GetPivot().Position
		for _, wcsCharacter in pairs(wcsCharacters) do
			local characterModel = wcsCharacter.Instance
			if characterModel == model then
				continue
			end
			local characterPosition = characterModel:GetPivot().Position
			local distance = (characterPosition - modelPosition).Magnitude
			if distance < closestDistance and distance <= maxRange then
				Logger:Log("CharacterUtility", `Distance: {distance}`)
				closestDistance = distance
				closestCharacter = wcsCharacter
			end
		end
		return closestCharacter
	end
end
return {
	CharacterUtility = CharacterUtility,
}
