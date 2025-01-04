import { PlayerSkillsData, SkillId } from "../Skills/SkillsV2";

// Core Stats
export type TCoreStats = {
	Level: number;
	Experience: number;
	ExperienceToNextLevel: number;
	Strength: number;
	Speed: number;
	Dexterity: number;
	Intelligence: number;
	Constitution: number;
	AttributePoints: number;
};

// Player Data Interface
export interface IPlayerDataV2 {
	[str: string]: unknown;

	// Datastore Info
	key: string;
	version: number;

	// Character Info
	CharacterName: string;

	// Core Stats
	Stats: TCoreStats;

	// Skills Data
	Skills: PlayerSkillsData;

	// Inventory
	WeaponInventory: string[];
	ArmorInventory: string[];
	HelmetInventory: string[];
	FamiliarInventory: string[];
	AccessoryInventory: string[];
}
