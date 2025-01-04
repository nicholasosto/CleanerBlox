-- Compiled with roblox-ts v3.0.0
-- SkillId could be a string union or just 'string'
-- if you have many dynamically loaded skill IDs
local SkillDefinitions = {
	BasicMelee = {
		displayName = "Fireball",
		description = "Launch a fireball that deals AoE damage.",
		icon = "rbxassetid://12345",
		cooldown = 5,
	},
	BasicRanged = {
		displayName = "Lightning Bolt",
		description = "Strike a single target with lightning.",
		icon = "rbxassetid://12346",
		cooldown = 8,
	},
	BasicHold = {
		displayName = "Heal",
		description = "Restore your health or an ally’s.",
		icon = "rbxassetid://12347",
		cooldown = 10,
	},
	Teleport = {
		displayName = "Teleport",
		description = "Teleport to a short distance.",
		icon = "rbxassetid://12348",
		cooldown = 15,
	},
	Dash = {
		displayName = "Dash",
		description = "Dash forward quickly.",
		icon = "rbxassetid://12349",
		cooldown = 12,
	},
	MultiJump = {
		displayName = "Double Jump",
		description = "Jump in mid-air a second time.",
		icon = "rbxassetid://12350",
		cooldown = 0,
	},
	Fly = {
		displayName = "Fly",
		description = "Gain the ability to fly.",
		icon = "rbxassetid://12351",
		cooldown = 30,
	},
	Meditate = {
		displayName = "Meditate",
		description = "Regenerate health and mana.",
		icon = "rbxassetid://12352",
		cooldown = 20,
	},
	Charge = {
		displayName = "Charge",
		description = "Charge at an enemy.",
		icon = "rbxassetid://12353",
		cooldown = 18,
	},
}
local function getDefaultPlayerSkillsData()
	return {
		unlockedSkills = {},
		assignedSlots = { nil, nil, nil, nil, nil },
	}
end
return {
	getDefaultPlayerSkillsData = getDefaultPlayerSkillsData,
	SkillDefinitions = SkillDefinitions,
}
