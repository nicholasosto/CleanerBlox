-- Compiled with roblox-ts v3.0.0
local EAnimations = {
	MoonPartAnimation = "rbxassetid://82713683056632",
	SKILL_WCS_Slash = "rbxassetid://77799116860007",
	SKILL_BasicMelee = "rbxassetid://137879818226309",
	SKILL_BasicRanged = "rbxassetid://110265290978403",
	SKILL_BasicHold = "rbxassetid://93554304810930",
	MELEE_Backflip = "rbxassetid://96927531461522",
	MELEE_FastKick = "rbxassetid://126544239907410",
	MELEE_Dodge = "rbxassetid://15547507943",
	COMBAT_Damage = "rbxassetid://16158676664",
	FLIGHT_Backward = "rbxassetid://16467432682",
	FLIGHT_Left = "rbxassetid://16467350572",
	FLIGHT_Right = "rbxassetid://16467400519",
	FLIGHT_Up = "rbxassetid://16466802431",
	CHARACTER_Charging = "rbxassetid://16425019906",
	NPC_Idle = "rbxassetid://16579917477",
	NPC_Patrol = "rbxassetid://16579917495",
	NPC_Chase = "rbxassetid://94119052222051",
	NPC_Attack = "rbxassetid://16579917486",
}
local function CreateAnimation(animationId)
	local animation = Instance.new("Animation")
	animation.AnimationId = animationId
	return animation
end
local CharacterAnimations = {
	[EAnimations.COMBAT_Damage] = CreateAnimation(EAnimations.COMBAT_Damage),
	[EAnimations.MELEE_Backflip] = CreateAnimation(EAnimations.MELEE_Backflip),
	[EAnimations.MELEE_FastKick] = CreateAnimation(EAnimations.MELEE_FastKick),
	[EAnimations.MELEE_Dodge] = CreateAnimation(EAnimations.MELEE_Dodge),
	[EAnimations.CHARACTER_Charging] = CreateAnimation(EAnimations.CHARACTER_Charging),
	[EAnimations.FLIGHT_Up] = CreateAnimation(EAnimations.FLIGHT_Up),
	[EAnimations.FLIGHT_Left] = CreateAnimation(EAnimations.FLIGHT_Left),
	[EAnimations.FLIGHT_Right] = CreateAnimation(EAnimations.FLIGHT_Right),
	[EAnimations.FLIGHT_Backward] = CreateAnimation(EAnimations.FLIGHT_Backward),
}
return {
	CreateAnimation = CreateAnimation,
	EAnimations = EAnimations,
	CharacterAnimations = CharacterAnimations,
}
