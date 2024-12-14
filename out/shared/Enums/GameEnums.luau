-- Compiled with roblox-ts v3.0.0
--[[
	
	    This file contains all the enums used in the game.
	
]]
--[[
	 SkillNames
	    This enum contains all the skill names used in the game.
	
]]
local SkillName = {
	BigRed = "BigRed",
	SpotLights = "SpotLights",
	DefualtAttack = "DefualtAttack",
	DragonSoul = "DragonSoul",
	SkyCrusher = "SkyCrusher",
	BloodArmor = "BloodArmor",
	FallenSpears = "FallenSpears",
	NotOver = "NotOver",
	DemonRise = "DemonRise",
	BoneBarage = "BoneBarage",
	BloodSpears = "BloodSpears",
	DevilBeam = "DevilBeam",
	FeignDeath = "FeignDeath",
}
local EventNames = {
	MoveAction = "MoveAction",
	TargetModel = "TargetModel",
	SkillInventory_Unlock = "SkillInventory_Unlock",
	Equipment_ToggleEquip = "Equipment_Equip",
	Equipment_Unlock = "Equipment_Unlock",
	Equipment_Lock = "Equipment_Lock",
}
local EquipmentSlots = {
	Weapon = "Weapon",
	Helmet = "Helmet",
	Body = "Body",
	Accessory = "Accessory",
	Familiar = "Familiar",
}
local AnimationGroups = {
	Combat = "Combat",
	Skill = "Skill",
	Movement = "Movement",
	Idle = "Idle",
	Special = "Special",
}
local CombatEffects = {
	Stun = "Stun",
	Slow = "Slow",
	Bleed = "Bleed",
	Burn = "Burn",
	Poison = "Poison",
	Freeze = "Freeze",
	Shock = "Shock",
}
return {
	SkillName = SkillName,
	EventNames = EventNames,
	EquipmentSlots = EquipmentSlots,
	AnimationGroups = AnimationGroups,
	CombatEffects = CombatEffects,
}
