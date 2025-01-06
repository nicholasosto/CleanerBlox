import { AnimationIds } from "./Indexes/AssetIndex";

export type TAnimation = {
	[key: string]: Animation;
};

export function CreateAnimation(animationId: AnimationIds): Animation {
	const animation = new Instance("Animation");
	animation.AnimationId = animationId;
	return animation;
}

export const CharacterAnimations: TAnimation = {
	// Basic Skills
	[AnimationIds.COMBAT_Damage]: CreateAnimation(AnimationIds.COMBAT_Damage),

	// Melee Animations
	[AnimationIds.MELEE_Backflip]: CreateAnimation(AnimationIds.MELEE_Backflip),
	[AnimationIds.MELEE_FastKick]: CreateAnimation(AnimationIds.MELEE_FastKick),
	[AnimationIds.MELEE_Dodge]: CreateAnimation(AnimationIds.MELEE_Dodge),

	// Character Animations
	[AnimationIds.CHARACTER_Charging]: CreateAnimation(AnimationIds.CHARACTER_Charging),

	// Flight Animations
	[AnimationIds.FLIGHT_Up]: CreateAnimation(AnimationIds.FLIGHT_Up),
	[AnimationIds.FLIGHT_Left]: CreateAnimation(AnimationIds.FLIGHT_Left),
	[AnimationIds.FLIGHT_Right]: CreateAnimation(AnimationIds.FLIGHT_Right),
	[AnimationIds.FLIGHT_Backward]: CreateAnimation(AnimationIds.FLIGHT_Backward),
};
