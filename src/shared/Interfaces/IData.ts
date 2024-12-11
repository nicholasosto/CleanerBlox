export interface CharacterClassData {
	ClassId: string;
	ClassLevel: number;
	ClassPoints: number;
	ClassExperience: number;
	ClassExperienceToNextLevel: number;
}

export interface StatsData {
	Strength: number;
	Speed: number;
	Dexterity: number;
	Intelligence: number;
	Constitution: number;
}

export interface SkillsData {
	Slot_1: string;
	Slot_2: string;
	Slot_3: string;
	Slot_4: string;
	Slot_5: string;
}

export interface EquipmentData {
	Weapon: string;
	Armor: string;
	Helmet: string;
	Boots: string;
	Familiar: string;
	Accessory: string;
}

export interface PlayerData {
	key: string;
	version: number;

	Level: number;
	Experience: number;
	ExperienceToNextLevel: number;

	CharacterName: string;
	CharacterClass: CharacterClassData;
	Stats: StatsData;
	Skills: SkillsData;
	Equipment: EquipmentData;

	SkillInventory: string[];
	WeaponInventory: string[];
	ArmorInventory: string[];
	HelmetInventory: string[];
	BootsInventory: string[];
	FamiliarInventory: string[];
	AccessoryInventory: string[];
}

export const DataTemplate: PlayerData = {
	key: "Datatemplate",
	version: 1,

	Level: 1,
	Experience: 0,
	ExperienceToNextLevel: 100,

	CharacterName: "Default Name",

	CharacterClass: {
		ClassId: "Vampire",
		ClassLevel: 1,
		ClassPoints: 0,
		ClassExperience: 0,
		ClassExperienceToNextLevel: 100,
	},

	Stats: {
		Strength: 10,
		Speed: 10,
		Dexterity: 10,
		Intelligence: 10,
		Constitution: 200,
	},

	Skills: {
		Slot_1: "Attack",
		Slot_2: "Block",
		Slot_3: "Spotlights",
		Slot_4: "Empty",
		Slot_5: "Empty",
	},

	Equipment: {
		Weapon: "Fists",
		Armor: "Cloth",
		Helmet: "None",
		Boots: "None",
		Familiar: "None",
		Accessory: "None",
	},

	SkillInventory: ["Attack", "Block", "Spotlights", "Heal", "Buff", "Debuff", "Stun"],
	WeaponInventory: ["Fists", "Dagger", "Sword", "Axe", "Bow", "Staff"],
	ArmorInventory: ["Cloth", "Leather", "Chainmail", "Plate"],
	HelmetInventory: ["None", "Hood", "Helmet", "Crown"],
	BootsInventory: ["None", "Shoes", "Boots", "Greaves"],
	FamiliarInventory: ["None", "Bat", "Cat", "Dog", "Owl"],
	AccessoryInventory: ["None", "Ring", "Amulet", "Bracelet", "Belt"],
};
