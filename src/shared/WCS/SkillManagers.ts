import { Character } from "@rbxts/wcs";
import { Logger } from "../Utility/Logger";

export class AudioManager {
    // eslint-disable-next-line prettier/prettier
    public static LoadWCSSound(character: Character, soundName: string, soundId: string): Sound | undefined {
		// create the sound
		const sound = new Instance("Sound");
		sound.Name = soundName;
		sound.SoundId = soundId;
		
		sound.Parent = character.Instance;

		return sound as Sound;
	}
}

export class AnimationManager {
	// eslint-disable-next-line prettier/prettier
	public static LoadWCSCharacterAnimation(character: Character, animationName: string, animationId: string, animationDuration: number): AnimationTrack | undefined {
		// Get the animator
		const animator = AnimationManager.getAnimator(character.Instance);
		if (animator === undefined) {
			Logger.Log(script,"AnimationManager", "Animator not found");
			return undefined;
		}
        // Create the animation
		const animation = new Instance("Animation");
		animation.Name = animationName;
        animation.AnimationId = animationId;
        // Load the animation
        return animator.LoadAnimation(animation);
	}

	public static PlayAnimation(animationTrack: AnimationTrack, duration: number) {
		const animationLength = animationTrack.Length;
		const animationSpeed = animationLength / duration;
		animationTrack.Play();
		animationTrack.AdjustSpeed(animationSpeed);
	}


	private static getAnimator(instance: Instance): Animator | undefined {
		return instance.FindFirstChild("Animator", true) as Animator;
	}
}
