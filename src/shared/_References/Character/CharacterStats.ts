export type CharacterStatId = "Strength" | "Speed" | "Dexterity" | "Intelligence" | "Constitution";
export type CharacterStatValue = number;

export interface CharacterStatDefinition {
	displayName: string;
	description: string;
	icon: string; // rbxassetid:// etc.
}

export const StatDefinitions: Record<CharacterStatId, CharacterStatDefinition> = {
	Strength: {
		displayName: "Strength",
		description: "Physical Damage, Health, Armor",
		icon: "rbxassetid://12345",
	},
	Speed: {
		displayName: "Speed",
		description: "Attack Speed, Movement Speed",
		icon: "rbxassetid://12346",
	},
	Dexterity: {
		displayName: "Dexterity",
		description: "Critical Hit Chance, Dodge Chance, Stamina Regen",
		icon: "rbxassetid://12347",
	},
	Intelligence: {
		displayName: "Intelligence",
		description: "Magic Damage, Mana Regen, Spell Crit Chance",
		icon: "rbxassetid://12348",
	},
	Constitution: {
		displayName: "Constitution",
		description: "Health, Health Regen",
		icon: "rbxassetid://12349",
	},
};

export interface CharacterStats {
	Strength: CharacterStatValue;
	Speed: CharacterStatValue;
	Dexterity: CharacterStatValue;
	Intelligence: CharacterStatValue;
	Constitution: CharacterStatValue;
}

export function getDefaultCharacterStats(): CharacterStats {
	return {
		Strength: 10,
		Speed: 10,
		Dexterity: 10,
		Intelligence: 10,
		Constitution: 200,
	};
}
