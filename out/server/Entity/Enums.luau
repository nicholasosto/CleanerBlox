-- Compiled with roblox-ts v3.0.0
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
	EntityStates = EntityStates,
	EntityTypes = EntityTypes,
}
