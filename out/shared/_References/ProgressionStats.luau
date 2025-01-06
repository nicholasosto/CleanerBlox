-- Compiled with roblox-ts v3.0.0
-- Core Stats
local ProgressionStatDefinitions = {
	Level = {
		displayName = "Level",
		description = "Character Level",
		icon = "rbxassetid://12345",
	},
	Experience = {
		displayName = "Experience",
		description = "Experience Points",
		icon = "rbxassetid://12346",
	},
	ExperienceToNextLevel = {
		displayName = "Experience To Next Level",
		description = "Experience Points Required to Level Up",
		icon = "rbxassetid://12347",
	},
	ClassPoints = {
		displayName = "Class Points",
		description = "Class Points Available",
		icon = "rbxassetid://12348",
	},
	ClassExperience = {
		displayName = "Class Experience",
		description = "Class Experience Points",
		icon = "rbxassetid://12349",
	},
	ClassExperienceToNextLevel = {
		displayName = "Class Experience To Next Level",
		description = "Class Experience Points Required to Level Up",
		icon = "rbxassetid://12350",
	},
}
local function getDefaultProgressionStatsData()
	return {
		Level = 1,
		Experience = 0,
		ExperienceToNextLevel = 100,
		ClassPoints = 0,
		ClassExperience = 0,
		ClassExperienceToNextLevel = 100,
	}
end
return {
	getDefaultProgressionStatsData = getDefaultProgressionStatsData,
	ProgressionStatDefinitions = ProgressionStatDefinitions,
}
