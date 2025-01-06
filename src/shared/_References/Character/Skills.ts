// SkillId could be a string union or just 'string'
// if you have many dynamically loaded skill IDs
export type SkillId =
	| "BasicMelee"
	| "BasicRanged"
	| "BasicHold"
	| "Teleport"
	| "Dash"
	| "MultiJump"
	| "Fly"
	| "Meditate"
	| "Charge";


export type SkillType = "Melee" | "Ranged" | "Hold" | "Utility" | "Movement";

export interface SkillDefinition {
	displayName: string;
	wcsSkillId: string;
	description: string;
	icon: string; // rbxassetid:// etc.
	cooldown: number; // example field
	animation: string; // example field
	audio: string; // example field
	skillType: SkillType; // example field
	baseDamage?: number; // example field
}
// TODO: MAP Asset IDs for Icons, Animations, and Audio
export const SkillDefinitions: Record<SkillId, SkillDefinition> = {
	BasicMelee: {
		displayName: "Strike with fury",
		skillType: "Melee",
		wcsSkillId: "BasicMelee",
		description: "Its like boxing but with swords and more ouch .",
		icon: "rbxassetid://93299862544122",
		animation: "rbxassetid://137879818226309",
		audio: "rbxassetid://113379107293734",
		cooldown: 5,
	},
	BasicRanged: {
		displayName: "Spirit Bolt",
		skillType: "Ranged",
		wcsSkillId: "BasicRanged",
		description: "Strike a single target with spirit ball.",
		icon: "rbxassetid://87692961632175",
		animation: "rbxassetid://83501648864535",
		audio: "rbxassetid://113379107293734",
		cooldown: 8,
	},
	BasicHold: {
		displayName: "Heal",
		wcsSkillId: "BasicHold",
		skillType: "Hold",
		description: "Restore your health or an ally’s.",
		icon: "rbxassetid://123557536413272",
		animation: "rbxassetid://105644658587176",
		audio: "rbxassetid://113379107293734",
		cooldown: 10,
	},
	Teleport: {
		displayName: "Teleport",
		wcsSkillId: "Teleport",
		skillType: "Utility",
		description: "Teleport to a short distance.",
		icon: "rbxassetid://76927840703129",
		animation: "rbxassetid://105644658587176",
		audio: "rbxassetid://113379107293734",
		cooldown: 15,
	},
	Dash: {
		displayName: "Dash",
		wcsSkillId: "Dash",
		skillType: "Movement",
		description: "Dash forward quickly.",
		icon: "rbxassetid://119649862368547",
		animation: "rbxassetid://87124434257649",
		audio: "rbxassetid://113379107293734",
		cooldown: 12,
	},
	MultiJump: {
		displayName: "Double Jump",
		wcsSkillId: "MultiJump",
		skillType: "Movement",
		description: "Jump in mid-air a second time.",
		icon: "rbxassetid://139595831174835",
		animation: "rbxassetid://110159074520244",
		audio: "rbxassetid://113379107293734",
		cooldown: 0,
	},
	Fly: {
		displayName: "Fly",
		wcsSkillId: "Fly",
		skillType: "Movement",
		description: "Gain the ability to fly.",
		icon: "rbxassetid://128172931372943",
		animation: "rbxassetid://12351",
		audio: "rbxassetid://113379107293734",
		cooldown: 30,
	},
	Meditate: {
		displayName: "Meditate",
		wcsSkillId: "Meditate",
		skillType: "Utility",
		description: "Regenerate health and mana.",
		icon: "rbxassetid://12352",
		animation: "rbxassetid://140479956568725",
		audio: "rbxassetid://113379107293734",
		cooldown: 20,
	},
	Charge: {
		displayName: "Charge",
		wcsSkillId: "Charge",
		skillType: "Utility",
		description: "Charge your mana reserves.",
		icon: "rbxassetid://12353",
		animation: "rbxassetid://98363948502311",
		audio: "rbxassetid://113379107293734",
		cooldown: 18,
	},
	// ... add additional skills here
};

export interface PlayerSkillsData {
	/**
	 * All the skill IDs that this player has unlocked.
	 * Could be an array or a Set-like structure.
	 */
	unlockedSkills: SkillId[];

	/**
	 * Which skill is assigned to each of the 5 slots in the action bar.
	 * If a slot isn’t assigned, store `undefined`.
	 */
	assignedSlots: Array<SkillId | undefined>;
};

export function getDefaultPlayerSkillsData(): PlayerSkillsData {
	return {
		unlockedSkills: ["BasicMelee", "BasicRanged", "BasicHold", "Teleport", "Dash"],
		assignedSlots: ["BasicMelee", "BasicRanged", undefined, undefined, undefined],
	};
};

export function unlockSkill(skillData: PlayerSkillsData, skillId: SkillId): void {
	if (!skillData.unlockedSkills.includes(skillId)) {
		skillData.unlockedSkills.push(skillId);
	}
};

export function assignSkillToSlot(skillData: PlayerSkillsData, skillId: SkillId, slotIndex: number): void {
	// Validate slot index
	if (slotIndex < 0 || slotIndex > 4) {
		throw `Slot index must be between 0 and 4 (got ${slotIndex}).`;
	}
	// Ensure the skill is unlocked before assigning
	if (!skillData.unlockedSkills.includes(skillId)) {
		throw `Player has not unlocked the skill: ${skillId}.`;
	}
	// Assign
	skillData.assignedSlots[slotIndex] = skillId;
};

export function unassignSlot(skillData: PlayerSkillsData, slotIndex: number): void {
	if (slotIndex < 0 || slotIndex > 4) {
		throw `Slot index must be between 0 and 4 (got ${slotIndex}).`;
	}
	skillData.assignedSlots[slotIndex] = undefined;
};

export function getAssignedSkillDefinitions(skillData: PlayerSkillsData): Array<SkillDefinition> {
	const returnArray: Array<SkillDefinition> = [];

	skillData.unlockedSkills.forEach((skillId, index) => {
		const assignedSkillId = skillData.assignedSlots[index];
		if (assignedSkillId) {
			const skillDef = SkillDefinitions[assignedSkillId];
			returnArray.push(skillDef);
		}
	});

	return returnArray;
};
