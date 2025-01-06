-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local getDefaultPlayerSkillsData = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Character", "Skills").getDefaultPlayerSkillsData
local getDefaultCharacterStats = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Character", "CharacterStats").getDefaultCharacterStats
local getDefaultProgressionStatsData = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "ProgressionStats").getDefaultProgressionStatsData
local getDefaultResourceStats = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Character", "ResourceStats").getDefaultResourceStats
-- Equipment Slot
local DataTemplate = {
	key = "Datatemplate",
	version = 5,
	CharacterName = "Default Name",
	CharacterClass = {
		ClassId = "Vampire",
		ClassLevel = 1,
		ClassPoints = 0,
		ClassExperience = 0,
		ClassExperienceToNextLevel = 100,
	},
	CharacterStats = getDefaultCharacterStats(),
	ProgressionStats = getDefaultProgressionStatsData(),
	ResourceStats = getDefaultResourceStats(),
	Skills = getDefaultPlayerSkillsData(),
}
return {
	DataTemplate = DataTemplate,
}
