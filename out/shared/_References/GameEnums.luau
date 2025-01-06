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
local EquipmentSlots = {
	Weapon = "Weapon",
	Helmet = "Helmet",
	Body = "Body",
	Boots = "Boots",
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
local EntityStates = {
	Idle = "Idle",
	Walking = "Walking",
	Running = "Running",
	Jumping = "Jumping",
	Falling = "Falling",
	Attacking = "Attacking",
	Casting = "Casting",
	Dead = "Dead",
	Interacting = "Interacting",
}
local EntityTypes = {
	Player = "Player",
	Mob = "Mob",
	Boss = "Boss",
	Wildlife = "Wildlife",
	Pet = "Pet",
	Shopkeeper = "Shopkeeper",
	QuestGiver = "QuestGiver",
}
return {
	SkillName = SkillName,
	EquipmentSlots = EquipmentSlots,
	AnimationGroups = AnimationGroups,
	CombatEffects = CombatEffects,
	EntityStates = EntityStates,
	EntityTypes = EntityTypes,
}
