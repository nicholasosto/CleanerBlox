
export enum EAnimations {
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

export type TAnimation = {
	[key: string]: Animation;
};

export function CreateAnimation(animationId: EAnimations): Animation {
	const animation = new Instance("Animation");
	animation.AnimationId = animationId;
	return animation;
}

export const CharacterAnimations: TAnimation = {
	// Basic Skills
	[EAnimations.COMBAT_Damage]: CreateAnimation(EAnimations.COMBAT_Damage),

	// Melee Animations
	[EAnimations.MELEE_Backflip]: CreateAnimation(EAnimations.MELEE_Backflip),
	[EAnimations.MELEE_FastKick]: CreateAnimation(EAnimations.MELEE_FastKick),
	[EAnimations.MELEE_Dodge]: CreateAnimation(EAnimations.MELEE_Dodge),

	// Character Animations
	[EAnimations.CHARACTER_Charging]: CreateAnimation(EAnimations.CHARACTER_Charging),

	// Flight Animations
	[EAnimations.FLIGHT_Up]: CreateAnimation(EAnimations.FLIGHT_Up),
	[EAnimations.FLIGHT_Left]: CreateAnimation(EAnimations.FLIGHT_Left),
	[EAnimations.FLIGHT_Right]: CreateAnimation(EAnimations.FLIGHT_Right),
	[EAnimations.FLIGHT_Backward]: CreateAnimation(EAnimations.FLIGHT_Backward),
};


