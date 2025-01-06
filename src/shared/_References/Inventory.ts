import { SkillId } from "shared/_References/Character/Skills";

// Temp Types for now
//TODO: Move to shared
export type EquipmentId = string;
export type FamiliarId = string;
export type AccessoryId = string;
export type WeaponId = string;
//Move to shared END

// INVENTORY Events
export enum EInventoryEvent {
	EquipRequest = "INVENTORY_EquipRequest",
	UnequipRequest = "INVENTORY_UnequipRequest",
	EquipResponse = "INVENTORY_EquipResponse",
	UnequipResponse = "INVENTORY_UnequipResponse",
	UnlockRequest = "INVENTORY_UnlockRequest",
	UnlockResponse = "INVENTORY_UnlockResponse",
}

// Attachment Names
export enum EInventorySlot {
	LeftHand = "LeftGripAttachment",
	RightHand = "RightGripAttachment",
	Helmet = "HatAttachment",
	Body = "BodyFrontAttachment",
	Familiar = "RightAnkleRigAttachment",
	Accessory = "BodyBackAttachment",
}

// Inventory Mappping
export enum EInventoryNames {
	Skills = "SkillInventory",
	Weapon = "WeaponInventory",
	Armor = "ArmorInventory",
	Helmet = "HelmetInventory",
	Familiar = "FamiliarInventory",
	Accessory = "AccessoryInventory",
}

// Item Types
export type ItemType = "Weapon" | "Armor" | "Helmet" | "Familiar" | "Accessory" | "Skill";

// Item Definition
export interface ItemDefinition {
	itemID: SkillId | EquipmentId | FamiliarId | AccessoryId | WeaponId;
	itemType: ItemType;
	displayName: string;
	description: string;
	icon: string;
}
