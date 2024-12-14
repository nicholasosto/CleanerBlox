-- Compiled with roblox-ts v3.0.0
local function calculateMaxHealth(level, Constitution)
	return level * Constitution * 10
end
local function calculateMaxMana(level, Intelligence)
	return level * Intelligence * 10
end
local function calculateMaxStamina(level, Speed)
	return level * Speed * 10
end
local function calculateExperienceToNextLevel(level)
	return level * 100
end
return {
	calculateMaxHealth = calculateMaxHealth,
	calculateMaxMana = calculateMaxMana,
	calculateMaxStamina = calculateMaxStamina,
	calculateExperienceToNextLevel = calculateExperienceToNextLevel,
}
