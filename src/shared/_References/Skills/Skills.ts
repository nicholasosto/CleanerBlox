import { EAnimations } from "../Animation/Animations";
import { ESoundId } from "../Audio/Sounds";
import { EParticleGroup } from "../ParticleGroup/ParticleGroups";
import { EAuraGroup } from "../AuraGroup/AuraGroup";

export enum ESkillName {
	BasicMelee = "BasicMelee",
	BasicRanged = "BasicRanged",
	BasicHold = "BasicHold",
}

export enum ESkillImage {
	BasicMelee = "rbxassetid://86414516608643",
	BasicRanged = "rbxassetid://110265290978403",
	BasicHold = "rbxassetid://93554304810930",
}

export type TSkillConfiguration = {
	[key: string]: {
		DisplayName: string;
		ImageId: string;
		Animation: {
			Activation: EAnimations;
			Completion: EAnimations;
		};
		Audio: {
			Activation: ESoundId;
			Completion: ESoundId;
		};
		ResourceCost: {
			Mana: number;
			Stamina: number;
			Domain: number;
		};

		ParticleGroup: EParticleGroup;
		AuraGroup: EAuraGroup;

		ActivationTime: number;
		Damage: number;
		HoldTime: number;
		Cooldown: number;
	};
};

export const SkillConfigurations: TSkillConfiguration = {
	// Basic Skills
	["BasicMelee"]: {
		DisplayName: "Basic Melee",
		ImageId: ESkillImage.BasicMelee,
		Animation: {
			Activation: EAnimations.SKILL_BasicMelee,
			Completion: EAnimations.SKILL_BasicMelee,
		},
		Audio: {
			Activation: ESoundId.BasicMelee,
			Completion: ESoundId.BasicMelee,
		},
		ResourceCost: {
			Mana: 5,
			Stamina: 5,
			Domain: 5,
		},

		ParticleGroup: EParticleGroup.BasicMelee,
		AuraGroup: EAuraGroup.BasicMelee,

		ActivationTime: 1,
		Damage: 10,
		HoldTime: 0,
		Cooldown: 0.5,
	},
	["BasicRanged"]: {
		DisplayName: "Basic Ranged",
		ImageId: ESkillImage.BasicRanged,
		Animation: {
			Activation: EAnimations.SKILL_BasicRanged,
			Completion: EAnimations.SKILL_BasicRanged,
		},
		Audio: {
			Activation: ESoundId.BasicRanged,
			Completion: ESoundId.BasicRanged,
		},
		ResourceCost: {
			Mana: 5,
			Stamina: 5,
			Domain: 5,
		},

		ParticleGroup: EParticleGroup.BasicRanged,
		AuraGroup: EAuraGroup.BasicRanged,

		ActivationTime: 1,
		Damage: 10,
		HoldTime: 0,
		Cooldown: 0.5,
	},
	["BasicHold"]: {
		DisplayName: "Basic Hold",
		ImageId: ESkillImage.BasicHold,
		Animation: {
			Activation: EAnimations.SKILL_BasicHold,
			Completion: EAnimations.SKILL_BasicHold,
		},
		Audio: {
			Activation: ESoundId.BasicHold,
			Completion: ESoundId.BasicHold,
		},
		ResourceCost: {
			Mana: 5,
			Stamina: 5,
			Domain: 5,
		},

		ParticleGroup: EParticleGroup.BasicHold,
		AuraGroup: EAuraGroup.BasicHold,

		ActivationTime: 1,
		Damage: 10,
		HoldTime: 0,
		Cooldown: 0.5,
	},
};
