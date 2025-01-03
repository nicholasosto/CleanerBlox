-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local EAnimations = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "GameReference").EAnimations
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
}
return {
	ESkillName = ESkillName,
	ESkillImage = ESkillImage,
	SkillConfigurations = SkillConfigurations,
}
