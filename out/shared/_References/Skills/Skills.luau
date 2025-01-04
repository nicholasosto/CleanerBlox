-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local EAnimations = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Animation", "Animations").EAnimations
local ESoundId = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Audio", "Sounds").ESoundId
local EParticleGroup = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "ParticleGroup", "ParticleGroups").EParticleGroup
local EAuraGroup = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "AuraGroup", "AuraGroup").EAuraGroup
local ESkillName = {
	BasicMelee = "BasicMelee",
	BasicRanged = "BasicRanged",
	BasicHold = "BasicHold",
}
local ESkillImage = {
	BasicMelee = "rbxassetid://86414516608643",
	BasicRanged = "rbxassetid://110265290978403",
	BasicHold = "rbxassetid://93554304810930",
}
local SkillConfigurations = {
	BasicMelee = {
		DisplayName = "Basic Melee",
		ImageId = ESkillImage.BasicMelee,
		Animation = {
			Activation = EAnimations.SKILL_BasicMelee,
			Completion = EAnimations.SKILL_BasicMelee,
		},
		Audio = {
			Activation = ESoundId.BasicMelee,
			Completion = ESoundId.BasicMelee,
		},
		ResourceCost = {
			Mana = 5,
			Stamina = 5,
			Domain = 5,
		},
		ParticleGroup = EParticleGroup.BasicMelee,
		AuraGroup = EAuraGroup.BasicMelee,
		ActivationTime = 1,
		Damage = 10,
		HoldTime = 0,
		Cooldown = 0.5,
	},
	BasicRanged = {
		DisplayName = "Basic Ranged",
		ImageId = ESkillImage.BasicRanged,
		Animation = {
			Activation = EAnimations.SKILL_BasicRanged,
			Completion = EAnimations.SKILL_BasicRanged,
		},
		Audio = {
			Activation = ESoundId.BasicRanged,
			Completion = ESoundId.BasicRanged,
		},
		ResourceCost = {
			Mana = 5,
			Stamina = 5,
			Domain = 5,
		},
		ParticleGroup = EParticleGroup.BasicRanged,
		AuraGroup = EAuraGroup.BasicRanged,
		ActivationTime = 1,
		Damage = 10,
		HoldTime = 0,
		Cooldown = 0.5,
	},
	BasicHold = {
		DisplayName = "Basic Hold",
		ImageId = ESkillImage.BasicHold,
		Animation = {
			Activation = EAnimations.SKILL_BasicHold,
			Completion = EAnimations.SKILL_BasicHold,
		},
		Audio = {
			Activation = ESoundId.BasicHold,
			Completion = ESoundId.BasicHold,
		},
		ResourceCost = {
			Mana = 5,
			Stamina = 5,
			Domain = 5,
		},
		ParticleGroup = EParticleGroup.BasicHold,
		AuraGroup = EAuraGroup.BasicHold,
		ActivationTime = 1,
		Damage = 10,
		HoldTime = 0,
		Cooldown = 0.5,
	},
}
return {
	ESkillName = ESkillName,
	ESkillImage = ESkillImage,
	SkillConfigurations = SkillConfigurations,
}
