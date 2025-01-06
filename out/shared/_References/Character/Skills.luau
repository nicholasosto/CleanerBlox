-- Compiled with roblox-ts v3.0.0
-- SkillId could be a string union or just 'string'
-- if you have many dynamically loaded skill IDs
-- TODO: MAP Asset IDs for Icons, Animations, and Audio
local SkillDefinitions = {
	BasicMelee = {
		displayName = "Strike with fury",
		skillType = "Melee",
		wcsSkillId = "BasicMelee",
		description = "Its like boxing but with swords and more ouch .",
		icon = "rbxassetid://93299862544122",
		animation = "rbxassetid://137879818226309",
		audio = "rbxassetid://113379107293734",
		cooldown = 5,
	},
	BasicRanged = {
		displayName = "Spirit Bolt",
		skillType = "Ranged",
		wcsSkillId = "BasicRanged",
		description = "Strike a single target with spirit ball.",
		icon = "rbxassetid://87692961632175",
		animation = "rbxassetid://83501648864535",
		audio = "rbxassetid://113379107293734",
		cooldown = 8,
	},
	BasicHold = {
		displayName = "Heal",
		wcsSkillId = "BasicHold",
		skillType = "Hold",
		description = "Restore your health or an ally’s.",
		icon = "rbxassetid://123557536413272",
		animation = "rbxassetid://105644658587176",
		audio = "rbxassetid://113379107293734",
		cooldown = 10,
	},
	Teleport = {
		displayName = "Teleport",
		wcsSkillId = "Teleport",
		skillType = "Utility",
		description = "Teleport to a short distance.",
		icon = "rbxassetid://76927840703129",
		animation = "rbxassetid://105644658587176",
		audio = "rbxassetid://113379107293734",
		cooldown = 15,
	},
	Dash = {
		displayName = "Dash",
		wcsSkillId = "Dash",
		skillType = "Movement",
		description = "Dash forward quickly.",
		icon = "rbxassetid://119649862368547",
		animation = "rbxassetid://87124434257649",
		audio = "rbxassetid://113379107293734",
		cooldown = 12,
	},
	MultiJump = {
		displayName = "Double Jump",
		wcsSkillId = "MultiJump",
		skillType = "Movement",
		description = "Jump in mid-air a second time.",
		icon = "rbxassetid://139595831174835",
		animation = "rbxassetid://110159074520244",
		audio = "rbxassetid://113379107293734",
		cooldown = 0,
	},
	Fly = {
		displayName = "Fly",
		wcsSkillId = "Fly",
		skillType = "Movement",
		description = "Gain the ability to fly.",
		icon = "rbxassetid://128172931372943",
		animation = "rbxassetid://12351",
		audio = "rbxassetid://113379107293734",
		cooldown = 30,
	},
	Meditate = {
		displayName = "Meditate",
		wcsSkillId = "Meditate",
		skillType = "Utility",
		description = "Regenerate health and mana.",
		icon = "rbxassetid://12352",
		animation = "rbxassetid://140479956568725",
		audio = "rbxassetid://113379107293734",
		cooldown = 20,
	},
	Charge = {
		displayName = "Charge",
		wcsSkillId = "Charge",
		skillType = "Utility",
		description = "Charge your mana reserves.",
		icon = "rbxassetid://12353",
		animation = "rbxassetid://98363948502311",
		audio = "rbxassetid://113379107293734",
		cooldown = 18,
	},
}
local function getDefaultPlayerSkillsData()
	return {
		unlockedSkills = { "BasicMelee", "BasicRanged", "BasicHold", "Teleport", "Dash" },
		assignedSlots = { "BasicMelee", "BasicRanged", nil, nil, nil },
	}
end
local function unlockSkill(skillData, skillId)
	local _unlockedSkills = skillData.unlockedSkills
	local _skillId = skillId
	if not (table.find(_unlockedSkills, _skillId) ~= nil) then
		local _unlockedSkills_1 = skillData.unlockedSkills
		local _skillId_1 = skillId
		table.insert(_unlockedSkills_1, _skillId_1)
	end
end
local function assignSkillToSlot(skillData, skillId, slotIndex)
	-- Validate slot index
	if slotIndex < 0 or slotIndex > 4 then
		error(`Slot index must be between 0 and 4 (got {slotIndex}).`)
	end
	-- Ensure the skill is unlocked before assigning
	local _unlockedSkills = skillData.unlockedSkills
	local _skillId = skillId
	if not (table.find(_unlockedSkills, _skillId) ~= nil) then
		error(`Player has not unlocked the skill: {skillId}.`)
	end
	-- Assign
	skillData.assignedSlots[slotIndex + 1] = skillId
end
local function unassignSlot(skillData, slotIndex)
	if slotIndex < 0 or slotIndex > 4 then
		error(`Slot index must be between 0 and 4 (got {slotIndex}).`)
	end
	skillData.assignedSlots[slotIndex + 1] = nil
end
local function getAssignedSkillDefinitions(skillData)
	local returnArray = {}
	local _exp = skillData.unlockedSkills
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(skillId, index)
		local assignedSkillId = skillData.assignedSlots[index + 1]
		if assignedSkillId then
			local skillDef = SkillDefinitions[assignedSkillId]
			table.insert(returnArray, skillDef)
		end
	end
	for _k, _v in _exp do
		_callback(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.forEach ▲
	return returnArray
end
return {
	getDefaultPlayerSkillsData = getDefaultPlayerSkillsData,
	unlockSkill = unlockSkill,
	assignSkillToSlot = assignSkillToSlot,
	unassignSlot = unassignSlot,
	getAssignedSkillDefinitions = getAssignedSkillDefinitions,
	SkillDefinitions = SkillDefinitions,
}
