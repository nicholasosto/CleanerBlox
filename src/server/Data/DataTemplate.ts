export const DataTemplate = {
	key: "Datatemplate",
	version: 12,

	// Player Level and Experience
	Level: 11,
	Experience: 0,
	ExperienceToNextLevel: 100,

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
		Strength: 10,
		Speed: 10,
		Dexterity: 10,
		Intelligence: 10,
		Constitution: 200,
	},

	// Character Skills
	Skills: {
		Slot_1: "DevilBeam",
		Slot_2: "BigRed",
		Slot_3: "Spotlights",
		Slot_4: "Empty",
		Slot_5: "Empty",
	},

	// Character Equipment
	Equipment: {
		Weapon: "Fists",
		Armor: "Cloth",
		Helmet: "None",
		Boots: "None",
		Familiar: "None",
		Accessory: "None",
	},

	// Character Inventory
	SkillInventory: { 0: "Attack", 1: "Block", 2: "Spotlights" },
	WeaponInventory: { 0: "Fists", 1: "Dagger", 2: "Sword", 3: "Axe", 4: "Bow", 5: "Staff" },
	ArmorInventory: { 0: "Cloth", 1: "Leather", 2: "Chainmail", 3: "Plate" },
	HelmetInventory: { 0: "None", 1: "Hood", 2: "Helmet", 3: "Crown" },
	BootsInventory: { 0: "None", 1: "Shoes", 2: "Boots", 3: "Greaves" },
	FamiliarInventory: { 0: "None", 1: "Bat", 2: "Cat", 3: "Dog", 4: "Owl" },
	AccessoryInventory: { 0: "None", 1: "Ring", 2: "Amulet", 3: "Bracelet", 4: "Belt" },
};
