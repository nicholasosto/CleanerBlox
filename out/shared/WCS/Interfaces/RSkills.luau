-- Compiled with roblox-ts v3.0.0
local ESkillNames = {
	DevilBeam = "DevilBeam",
	BigRed = "BigRed",
	Spotlights = "Spotlights",
	BasicMelee = "BasicMelee",
	BasicRanged = "BasicRanged",
	BasicHold = "BasicHold",
}
local SkillConfigurations
local function GetSkillConfiguration(skillName)
	return SkillConfigurations[skillName]
end
SkillConfigurations = {
	DevilBeam = {
		imageId = "rbxassetid://0",
		cooldownTime = 3,
		manaCost = 10,
		staminaCost = 10,
		maxHoldTime = 3,
	},
	BigRed = {
		imageId = "rbxassetid://0",
		cooldownTime = 3,
		manaCost = 10,
		staminaCost = 10,
		maxHoldTime = 3,
	},
	Spotlights = {
		imageId = "rbxassetid://0",
		cooldownTime = 3,
		manaCost = 10,
		staminaCost = 10,
		maxHoldTime = 3,
	},
	DefaultMoveset = {
		imageId = "rbxassetid://0",
		cooldownTime = 3,
		manaCost = 10,
		staminaCost = 10,
		maxHoldTime = 3,
	},
}
return {
	GetSkillConfiguration = GetSkillConfiguration,
	ESkillNames = ESkillNames,
	SkillConfigurations = SkillConfigurations,
}
