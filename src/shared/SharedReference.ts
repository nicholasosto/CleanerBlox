import * as InventoryReference from "./Refrences/InventoryReference";
import { TCoreStats } from "./_References/Data/PlayerDataV2";
import { IPlayerDataV2 } from "./_References/Data/PlayerDataV2";

export { InventoryReference, TCoreStats, IPlayerDataV2 };

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
