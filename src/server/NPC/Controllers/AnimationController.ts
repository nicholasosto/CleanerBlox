// Purpose: Animation controller.
// Enums
import { EAnimationName } from "shared/Refrences/AnimationReference";


// Animation Controller
export class AnimationController {
	// Private members
	private _humanoid: Humanoid;
	private _animator: Animator;

	// Animation tracks
	public animationTracks: Map<string, AnimationTrack> = new Map<string, AnimationTrack>();

	// Constructor
	constructor(humanoid: Humanoid) {
		this._humanoid = humanoid;
		this._animator = humanoid.WaitForChild("Animator") as Animator;

		// Create animation tracks
		this.createAnimationTracks();
	}

	// Create animation tracks
	private createAnimationTracks(): void {
		// Idle
		this.addAnimationTrack(EAnimationName.NPC_Idle);
		// Chase
		this.addAnimationTrack(EAnimationName.NPC_Chase);
		// Attack
		this.addAnimationTrack(EAnimationName.NPC_Attack);
	}

	// Play animation
	public playAnimation(animationEnum: EAnimationName): void {
		const track = this.animationTracks.get(animationEnum);
		if (track) {
			track.Play();
		}
	}

	// Stop animation
	public stopAnimation(animationEnum: EAnimationName): void {
		const track = this.animationTracks.get(animationEnum);
		if (track) {
			track.Stop();
		}
	}

	// Add animation track
	private addAnimationTrack(animationEnum: EAnimationName): void {
		const animation = new Instance("Animation");
		animation.AnimationId = animationEnum;
		animation.Name = animationEnum;
		const track = this._animator.LoadAnimation(animation);
		this.animationTracks.set(animationEnum, track);
	}
}
