-- Compiled with roblox-ts v3.0.0
-- Temp Types for now
--TODO: Move to shared
--Move to shared END
-- INVENTORY Events
local EInventoryEvent = {
	EquipRequest = "INVENTORY_EquipRequest",
	UnequipRequest = "INVENTORY_UnequipRequest",
	EquipResponse = "INVENTORY_EquipResponse",
	UnequipResponse = "INVENTORY_UnequipResponse",
	UnlockRequest = "INVENTORY_UnlockRequest",
	UnlockResponse = "INVENTORY_UnlockResponse",
}
-- Attachment Names
local EInventorySlot = {
	LeftHand = "LeftGripAttachment",
	RightHand = "RightGripAttachment",
	Helmet = "HatAttachment",
	Body = "BodyFrontAttachment",
	Familiar = "RightAnkleRigAttachment",
	Accessory = "BodyBackAttachment",
}
-- Inventory Mappping
local EInventoryNames = {
	Skills = "SkillInventory",
	Weapon = "WeaponInventory",
	Armor = "ArmorInventory",
	Helmet = "HelmetInventory",
	Familiar = "FamiliarInventory",
	Accessory = "AccessoryInventory",
}
-- Item Types
-- Item Definition
return {
	EInventoryEvent = EInventoryEvent,
	EInventorySlot = EInventorySlot,
	EInventoryNames = EInventoryNames,
}
