/*
    This file contains all the enums used in the game.
*/

/* SkillNames
    This enum contains all the skill names used in the game.
*/
export enum SkillName {
	BigRed = "BigRed", // Testing move to try new ideas for the game
	SpotLights = "SpotLights", // Generates a spellcircle in front of the player with a detector light...
	DefualtAttack = "DefualtAttack", // The default attack skill melee for some classes spirit bolt for others
	DragonSoul = "DragonSoul", // Spawns a dragon that attacks enemies within a radius
	SkyCrusher = "SkyCrusher", // Spawns a giant robotic fist that crushes enemies from above
	BloodArmor = "BloodArmor", // Spawns a blood armor that protects the player from damage and absorbs health from nearby enemies
	FallenSpears = "FallenSpears", // Spawns spears that fall from the sky and impale enemies (if they are impaled they take damage over time and are slowed)
	NotOver = "NotOver", // Leaves the character with one health point but makes them invincible for a short period of time
	DemonRise = "DemonRise", // Spawns a random assortment of demons that attack enemies (there are a total number of demon points that can be used to spawn demons of three different types (1 point, 2 points, 3 points))
	BoneBarage = "BoneBarage", // Spawns a bone cage around the player that breaks apart on command and shoots homing bone projectiles at enemies
	BloodSpears = "BloodSpears", // Spawns floating blood spears that attack enemies within a radius for a short period of time
	DevilBeam = "DevilBeam", // Spawns a giant evil laser beam that fires in front of the player
	FeignDeath = "FeignDeath", // Spawns a fake rig that runs around and attacks enemies another clone ragdolls and the player becomes invisible for 3 seconds
}

export enum EventNames {
	// Character Events
	MoveAction = "MoveAction", // Possible actions: "Jump", "Crouch", "Sprint", "Walk", "Idle", "Fly", "Land"
    TargetModel = "TargetModel", // Target a model in the game world (used for combat and skill targeting and other interactions)

	// Skill Events
	SkillInventory_Unlock = "SkillInventory_Unlock", // Unlocks a skill in the skill inventory

	// Equipment Events
	Equipment_ToggleEquip = "Equipment_Equip", // Equips or unequips an equipment in the equipment inventory
	Equipment_Unlock = "Equipment_Unlock", // Unlocks an equipment in the equipment inventory through drops or purchases
	Equipment_Lock = "Equipment_Lock", // Locks an equipment in the equipment inventory if sold or traded

}

export enum EquipmentSlots {
	Weapon = "Weapon",
	Helmet = "Helmet",
	Body = "Body",
	Accessory = "Accessory",
	Familiar = "Familiar",
}

export enum AnimationGroups {
	Combat = "Combat",
	Skill = "Skill",
	Movement = "Movement",
	Idle = "Idle",
	Special = "Special",
}

export enum CombatEffects {
	Stun = "Stun",
	Slow = "Slow",
	Bleed = "Bleed",
	Burn = "Burn",
	Poison = "Poison",
	Freeze = "Freeze",
	Shock = "Shock",
}
