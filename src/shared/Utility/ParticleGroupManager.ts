export class ParticleGroupManager {
	private constructor() {}

	public static disableParticleGroup(particleGroup?: Attachment) {
		if (particleGroup === undefined) {
			return;
		}
		const particleEffects = particleGroup
			.GetDescendants()
			.filter((child) => child.IsA("ParticleEmitter")) as ParticleEmitter[];

		particleEffects.forEach((particle) => {
			particle.Enabled = false;
		});
	}

	public static enableParticleGroup(particleGroup?: Attachment) {
		if (particleGroup === undefined) {
			return;
		}
		const particleEffects = particleGroup
			.GetDescendants()
			.filter((child) => child.IsA("ParticleEmitter")) as ParticleEmitter[];

		particleEffects.forEach((particle) => {
			particle.Enabled = true;
		});
	}

	public static adjustParticleGroupTransparency(particleGroup?: Attachment, transparency?: number) {
		if (transparency === undefined || particleGroup === undefined) {
			return;
		}

		const particleEffects = particleGroup
			.GetDescendants()
			.filter((child) => child.IsA("ParticleEmitter")) as ParticleEmitter[];

		particleEffects.forEach((particle) => {
			const currentTransparency = particle.Transparency;

			const adjustedTransparency = currentTransparency.Keypoints.map((keypoint) => {
				return new NumberSequenceKeypoint(keypoint.Time, keypoint.Value * transparency);
			});

			particle.Transparency = new NumberSequence(adjustedTransparency);
		});
	}

	public static adjustParticleGroupSize(particleGroup?: Attachment, size?: number) {
		if (particleGroup === undefined || size === undefined) {
			return;
		}
		const particleEffects = particleGroup
			.GetDescendants()
			.filter((child) => child.IsA("ParticleEmitter")) as ParticleEmitter[];

		particleEffects.forEach((particle) => {
			particle.Size = new NumberSequence(size);
		});
	}
}
