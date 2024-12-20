import * as InventoryReference from "./Refrences/InventoryReferences";

export { InventoryReference };

/* [[[[[[  Notifications ]]]]]] */
export type TEventSuccessResponse = {
	success: boolean;
	message: string;
};

/* [[[[[[  Event Names ]]]]]] */

// SKILL Events
export enum ESkillEvent {
	SkillSlotRequest = "SKILL_SkillSlotRequest",
	ClearSlotRequest = "SKILL_ClearSlotRequest",
	AssignSlotRequest = "SKILL_AssignSlotRequest",
	SkillSlotResponse = "SKILL_SkillSlotResponse",
	ClearSlotResponse = "SKILL_ClearSlotResponse",
	AssignSlotResponse = "SKILL_AssignSlotResponse",
}


export enum EStatEvent {
	IncreaseStatRequest = "STAT_IncreaseStatRequest",
	IncreaseStatResponse = "STAT_IncreaseStatResponse",
}


/* [[[[[[  Player Data ]]]]]] */

// Skill Slot
export type TSkillSlot = {
	SlotId: string;
	SkillId: string;
};

// Equipment Slot
export type TEquipmentSlot = {
	SlotId: string;
	EquipmentId: string;
};

// Currency Type
export type TCurrency = {
	CurrencyId: string;
	CurrencyAmount: number;
};

// Character Class
export type TCharacterClass = {
	ClassId: string;
	ClassLevel: number;
	ClassPoints: number;
	ClassExperience: number;
	ClassExperienceToNextLevel: number;
};

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
export interface IPlayerData {
	[str: string]: unknown;

	// Datastore Info
	key: string;
	version: number;

	// Character Info
	CharacterName: string;
	CharacterClass: TCharacterClass;

	// Core Stats
	Stats: TCoreStats;

	// Currency, Skill, Equipment Slots
	Currencies: Array<TCurrency>;
	SkillSlots: Array<TSkillSlot>;
	EquipmentSlots: Array<TEquipmentSlot>;

	// Inventory
	SkillInventory: string[];
	WeaponInventory: string[];
	ArmorInventory: string[];
	HelmetInventory: string[];
	FamiliarInventory: string[];
	AccessoryInventory: string[];
}
