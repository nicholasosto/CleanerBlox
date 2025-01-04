import { IPlayerDataV2, TEquipmentSlot, TSkillSlot, TCurrency } from "shared/SharedReference";
import { getDefaultPlayerSkillsData, PlayerSkillsData } from "shared/_References/Skills/SkillsV2";
import { ESkillNames } from "shared/WCS/Interfaces/RSkills";

export const DataTemplate: IPlayerDataV2 = {
	key: "Datatemplate",
	version: 2,

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
	Stats: {
		Level: 1,
		Experience: 0,
		ExperienceToNextLevel: 100,
		Strength: 10, // Physical Damage, Health, Armor
		Speed: 10, // Attack Speed, Movement Speed
		Dexterity: 10, // Critical Hit Chance, Dodge Chance, Stamina Regen
		Intelligence: 10, // Magic Damage, Mana Regen, Spell Crit Chance
		Constitution: 200, // Health, Health Regen
		AttributePoints: 0,
	},

	Skills: getDefaultPlayerSkillsData(),

	// Currencies
	Currencies: [
		{ CurrencyId: "Souls", CurrencyAmount: 140 },
		{ CurrencyId: "GodShard", CurrencyAmount: 14 },
		{ CurrencyId: "SSZeno", CurrencyAmount: 1 },
	] as TCurrency[],

	// Skill Slots
	//SkillData: PlayerSkillsData,

	// Equipment Slots
	EquipmentSlots: [
		{ SlotId: "Weapon", EquipmentId: "Fists" },
		{ SlotId: "Armor", EquipmentId: "Cloth" },
		{ SlotId: "Helmet", EquipmentId: "None" },
		{ SlotId: "Boots", EquipmentId: "None" },
		{ SlotId: "Familiar", EquipmentId: "None" },
		{ SlotId: "Accessory", EquipmentId: "None" },
	] as TEquipmentSlot[],

	// Character Inventory
	WeaponInventory: ["Fists", "Dagger", "Sword", "Axe", "Bow", "Staff"],
	ArmorInventory: ["Cloth", "Leather", "Chainmail", "Plate"],
	HelmetInventory: ["None", "Hood", "Helmet", "Crown"],
	FamiliarInventory: ["None", "Bat", "Cat", "Dog", "Owl"],
	AccessoryInventory: ["None", "Ring", "Amulet", "Bracelet", "Belt"],
};
