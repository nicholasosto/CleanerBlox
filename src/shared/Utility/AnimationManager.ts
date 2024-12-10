import { GameStorage } from "shared/GameStorage";
import { Character } from "@rbxts/wcs";

export class AnimationManager {
	private static __instance: AnimationManager;
	private static __registry: Map<Character, AnimationTrack[]> = new Map<Character, AnimationTrack[]>();

	private static _combatAnimations: {
		[key: string]: Animation;
	} = {
		// Combat Animations
		DanteBackflip: GameStorage.getAnimation("DanteBackflip"),
		Godlike: GameStorage.getAnimation("Godlike"),
	};

	private constructor() {
		// Private Constructor
	}

	public static Start(): AnimationManager {
		if (!this.__instance) {
			this.__instance = new AnimationManager();
		}

		return this.__instance;
	}

	// Get Animation
	public static RegisterAnimationsFor(character: Character): void {
		const animator: Animator = character.Humanoid.WaitForChild("Animator") as Animator;
		const animationTracks: AnimationTrack[] = AnimationManager.__registry.get(character) || [];

		if (!animator) {
			warn("Animator or AnimationTracks not found for character: ", character);
			return;
		}

		if (animationTracks.size() > 0) {
			animationTracks.forEach((track) => track.Destroy());
			AnimationManager.__registry.delete(character);
		}

		animationTracks.push(animator.LoadAnimation(AnimationManager._combatAnimations.DanteBackflip));
		animationTracks.push(animator.LoadAnimation(AnimationManager._combatAnimations.Godlike));

		AnimationManager.__registry.set(character, animationTracks);
	}

	public static PlayAnimationFor(character: Character, animationName: string): void {
		const animationTrack = AnimationManager.__registry
			.get(character)
			?.filter((track) => track.Animation?.Name === animationName)[0];
		if (!animationTrack) {
			warn("Animation not found: ", animationName);
			return;
		}

		animationTrack.Play();
	}
}
