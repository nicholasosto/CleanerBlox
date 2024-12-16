//import { DevilBeam } from "../Skills/DevilBeam";
type TSkillConfiguration = {
    [key: string]: {
        imageId: string;
        cooldownTime: number;
        manaCost: number;
        staminaCost: number;
        maxHoldTime: number;
    };
};

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
