import { EAnimations, CharacterAnimations, TAnimation, CreateAnimation } from "../Animations";

export class AnimationHelper {
	public static CharacterAnimations: TAnimation = CharacterAnimations;
	public static CreateAnimationTrack(characterModel: Model, animationId: EAnimations): AnimationTrack {
		const animator = characterModel.FindFirstChild("Animator", true) as Animator;
		const animation = new Instance("Animation");

		const animationTrack = animator.LoadAnimation(animation);
		return animationTrack;
	}

	public static PlayAnimation(animationTrack: AnimationTrack): void {
		animationTrack.Play();
	}
}
