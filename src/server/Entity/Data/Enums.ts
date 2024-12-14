export enum EntityStates {
	Idle = "Idle",
	Walking = "Walking",
	Running = "Running",
	Jumping = "Jumping",
	Falling = "Falling",
	Attacking = "Attacking", // Attacking with a weapon
	Casting = "Casting", // Casting a spell
	Dead = "Dead", // Dead
	Interacting = "Interacting", // Talking to NPC
}

export enum EntityTypes {
	Player = "Player",
	Mob = "Mob",
	Boss = "Boss",
	Wildlife = "Wildlife",
	Pet = "Pet",
	Shopkeeper = "Shopkeeper",
	QuestGiver = "QuestGiver",
}
