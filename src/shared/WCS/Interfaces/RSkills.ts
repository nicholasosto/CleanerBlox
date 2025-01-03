export enum ESkillNames {
	DevilBeam = "DevilBeam",
	BigRed = "BigRed",
	Spotlights = "Spotlights",
	BasicMelee = "BasicMelee",
	BasicRanged = "BasicRanged",
	BasicHold = "BasicHold",
}

type TSkillConfiguration = {
	[key: string]: {
		imageId: string;
		cooldownTime: number;
		manaCost: number;
		staminaCost: number;
		maxHoldTime: number;
	};
};

export function GetSkillConfiguration(skillName: ESkillNames): TSkillConfiguration[ESkillNames] {
	return SkillConfigurations[skillName];
}

export const SkillConfigurations: TSkillConfiguration = {
	["DevilBeam"]: {
		imageId: "rbxassetid://0",
		cooldownTime: 3,
		manaCost: 10,
		staminaCost: 10,
		maxHoldTime: 3,
	},
	["BigRed"]: {
		imageId: "rbxassetid://0",
		cooldownTime: 3,
		manaCost: 10,
		staminaCost: 10,
		maxHoldTime: 3,
	},
	["Spotlights"]: {
		imageId: "rbxassetid://0",
		cooldownTime: 3,
		manaCost: 10,
		staminaCost: 10,
		maxHoldTime: 3,
	},
	["DefaultMoveset"]: {
		imageId: "rbxassetid://0",
		cooldownTime: 3,
		manaCost: 10,
		staminaCost: 10,
		maxHoldTime: 3,
	},
};
