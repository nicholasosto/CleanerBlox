-- Compiled with roblox-ts v3.0.0
local DataTemplate = {
	key = "Datatemplate",
	version = 2,
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
		Experience = 0,
		ExperienceToNextLevel = 100,
		Strength = 10,
		Speed = 10,
		Dexterity = 10,
		Intelligence = 10,
		Constitution = 200,
		AttributePoints = 0,
	},
	Currencies = { {
		CurrencyId = "Souls",
		CurrencyAmount = 140,
	}, {
		CurrencyId = "GodShard",
		CurrencyAmount = 14,
	}, {
		CurrencyId = "SSZeno",
		CurrencyAmount = 1,
	} },
	SkillSlots = { {
		SlotId = "Slot_1",
		SkillId = "Spotlights",
	}, {
		SlotId = "Slot_2",
		SkillId = "BigRed",
	}, {
		SlotId = "Slot_3",
		SkillId = "Empty",
	}, {
		SlotId = "Slot_4",
		SkillId = "Empty",
	}, {
		SlotId = "Slot_5",
		SkillId = "Empty",
	} },
	EquipmentSlots = { {
		SlotId = "Weapon",
		EquipmentId = "Fists",
	}, {
		SlotId = "Armor",
		EquipmentId = "Cloth",
	}, {
		SlotId = "Helmet",
		EquipmentId = "None",
	}, {
		SlotId = "Boots",
		EquipmentId = "None",
	}, {
		SlotId = "Familiar",
		EquipmentId = "None",
	}, {
		SlotId = "Accessory",
		EquipmentId = "None",
	} },
	SkillInventory = { "Attack", "Block", "Spotlights", "Heal", "Buff", "Debuff", "Stun" },
	WeaponInventory = { "Fists", "Dagger", "Sword", "Axe", "Bow", "Staff" },
	ArmorInventory = { "Cloth", "Leather", "Chainmail", "Plate" },
	HelmetInventory = { "None", "Hood", "Helmet", "Crown" },
	FamiliarInventory = { "None", "Bat", "Cat", "Dog", "Owl" },
	AccessoryInventory = { "None", "Ring", "Amulet", "Bracelet", "Belt" },
}
return {
	DataTemplate = DataTemplate,
}
