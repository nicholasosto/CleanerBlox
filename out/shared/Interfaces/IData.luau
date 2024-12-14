-- Compiled with roblox-ts v3.0.0
local InventoryTypeKeys = {
	SkillInventory = "SkillInventory",
	WeaponInventory = "WeaponInventory",
	ArmorInventory = "ArmorInventory",
	HelmetInventory = "HelmetInventory",
	BootsInventory = "BootsInventory",
	FamiliarInventory = "FamiliarInventory",
	AccessoryInventory = "AccessoryInventory",
}
local DataTemplate = {
	key = "Datatemplate",
	version = 1,
	Level = 1,
	Experience = 0,
	ExperienceToNextLevel = 100,
	CharacterName = "Default Name",
	CharacterClass = {
		ClassId = "Vampire",
		ClassLevel = 1,
		ClassPoints = 0,
		ClassExperience = 0,
		ClassExperienceToNextLevel = 100,
	},
	Stats = {
		Level = 1,
		Strength = 10,
		Speed = 10,
		Dexterity = 10,
		Intelligence = 10,
		Constitution = 200,
	},
	Skills = {
		Slot_1 = "Spotlights",
		Slot_2 = "BigRed",
		Slot_3 = "Empty",
		Slot_4 = "Empty",
		Slot_5 = "Empty",
	},
	Equipment = {
		Weapon = "Fists",
		Armor = "Cloth",
		Helmet = "None",
		Boots = "None",
		Familiar = "None",
		Accessory = "None",
	},
	SkillInventory = { "Attack", "Block", "Spotlights", "Heal", "Buff", "Debuff", "Stun" },
	WeaponInventory = { "Fists", "Dagger", "Sword", "Axe", "Bow", "Staff" },
	ArmorInventory = { "Cloth", "Leather", "Chainmail", "Plate" },
	HelmetInventory = { "None", "Hood", "Helmet", "Crown" },
	BootsInventory = { "None", "Shoes", "Boots", "Greaves" },
	FamiliarInventory = { "None", "Bat", "Cat", "Dog", "Owl" },
	AccessoryInventory = { "None", "Ring", "Amulet", "Bracelet", "Belt" },
}
return {
	InventoryTypeKeys = InventoryTypeKeys,
	DataTemplate = DataTemplate,
}
