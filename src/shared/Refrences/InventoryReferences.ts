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

