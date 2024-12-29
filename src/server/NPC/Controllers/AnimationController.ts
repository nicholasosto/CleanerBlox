export class AnimationController {
	private humanoid: Humanoid;

	constructor(humanoid: Humanoid) {
		this.humanoid = humanoid;
	}

	public playAnimation(animationId: string): void {
		// Load and play the AnimationTrack on the humanoid’s Animator
	}

	public stopAnimation(animationId: string): void {
		// Stop the given animation
	}

	// Additional methods for blending, layering, etc.
}
