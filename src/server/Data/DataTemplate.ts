import { PlayerData } from "shared/_References/PlayerData";
import { getDefaultPlayerSkillsData } from "shared/_References/Character/Skills";
import { getDefaultCharacterStats } from "shared/_References/Character/CharacterStats";
import { getDefaultProgressionStatsData } from "shared/_References/ProgressionStats";
import { getDefaultResourceStats } from "shared/_References/Character/ResourceStats";

// Equipment Slot
export type TEquipmentSlot = {
	SlotId: string;
	EquipmentId: string;
};

export const DataTemplate: PlayerData = {
	key: "Datatemplate",
	version: 5,

	// Character Name
	CharacterName: "Default Name",

	// Character Class
	CharacterClass: {
		ClassId: "Vampire",
		ClassLevel: 1,
		ClassPoints: 0,
		ClassExperience: 0,
		ClassExperienceToNextLevel: 100,
	},

	// Character Stats
	CharacterStats: getDefaultCharacterStats(),
	// Progression Stats
	ProgressionStats: getDefaultProgressionStatsData(),
	// Resource Stats
	ResourceStats: getDefaultResourceStats(),
	// Skills Data
	Skills: getDefaultPlayerSkillsData(),
};
