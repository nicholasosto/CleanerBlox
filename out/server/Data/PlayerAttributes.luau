-- Compiled with roblox-ts v3.0.0
local PlayerAttributes
do
	PlayerAttributes = setmetatable({}, {
		__tostring = function()
			return "PlayerAttributes"
		end,
	})
	PlayerAttributes.__index = PlayerAttributes
	function PlayerAttributes.new(...)
		local self = setmetatable({}, PlayerAttributes)
		return self:constructor(...) or self
	end
	function PlayerAttributes:constructor()
		-- Private constructor to prevent instantiation
		-- Private constructor to prevent instantiation
	end
	function PlayerAttributes:createAttributes(player, playerData)
		-- Set Core Stats
		self:setCoreStats(player, playerData.Stats)
		-- Sets Derived Stats
		-- Health
		self:setHealthStat(player, playerData.Level, playerData.Stats.Constitution)
		self:setManaStat(player, playerData.Level, playerData.Stats.Intelligence)
		self:setStaminaStat(player, playerData.Level, playerData.Stats.Strength, playerData.Stats.Constitution)
		self:setExperienceStats(player, playerData)
	end
	function PlayerAttributes:setCoreStats(player, statData)
		player:SetAttribute("Strength", statData.Strength)
		player:SetAttribute("Speed", statData.Speed)
		player:SetAttribute("Dexterity", statData.Dexterity)
		player:SetAttribute("Intelligence", statData.Intelligence)
		player:SetAttribute("Constitution", statData.Constitution)
	end
	function PlayerAttributes:setHealthStat(player, level, constitution)
		local maxHealth = math.round(constitution * (level / 3) + 100)
		player:SetAttribute("Health", maxHealth)
		player:SetAttribute("CurrentHealth", maxHealth)
	end
	function PlayerAttributes:setManaStat(player, level, intelligence)
		local maxMana = math.round(intelligence * (level / 3) + 100)
		player:SetAttribute("Mana", maxMana)
		player:SetAttribute("CurrentMana", maxMana)
	end
	function PlayerAttributes:setStaminaStat(player, level, strength, constitution)
		local maxStamina = math.round((strength + constitution) * (level / 3) + 100)
		player:SetAttribute("Stamina", maxStamina)
		player:SetAttribute("CurrentStamina", maxStamina)
	end
	function PlayerAttributes:setExperienceStats(player, playerData)
		player:SetAttribute("Level", playerData.Level)
		player:SetAttribute("Experience", playerData.Experience)
		player:SetAttribute("ExperienceToNextLevel", playerData.ExperienceToNextLevel)
	end
end
return {
	PlayerAttributes = PlayerAttributes,
}
