import { GameStorage } from "./GameStorage";
import { Logger } from "./Logger";



export class ParticleGroupManager {
	private constructor() {}


	// Helper function to get all particle effects in a particle group
	private static getParticleDecendants(particleParent: Instance): ParticleEmitter[] {
		const particleEffects = particleParent.GetChildren().filter((child) => child.IsA("ParticleEmitter")) as ParticleEmitter[];
		return particleEffects;
	}

	// Print all particle effects in a particle group
	public static PrintParticleGroup(particleGroup: Instance) {
		const particleEffects = ParticleGroupManager.getParticleDecendants(particleGroup);
		particleEffects.forEach((particle) => {
			Logger.Log("Particle", particle.Name);
		});
	}

	// Get a particle group by name
	public static GetParticleGroup(name: string): Instance {
		const particleGroup = GameStorage.getModel(name);
		if (particleGroup === undefined) {
			Logger.Log("ParticleGroupManager", "Particle Group not found", name);
		}
		return particleGroup;
	}

	// Enable all particle effects in a particle group
	public static EnableParticleGroup(particleGroup: Instance) {
		const particleEffects = ParticleGroupManager.getParticleDecendants(particleGroup);
		particleEffects.forEach((particle) => {
			particle.Enabled = true;
		});
	}

	// Adjust the size of all particle effects in a particle group
	public static AdjustParticleGroupSize(particleGroup: Instance, scale: number) {
		const particleEffects = ParticleGroupManager.getParticleDecendants(particleGroup);
		particleEffects.forEach((particle) => {
			particle.Size = new NumberSequence([new NumberSequenceKeypoint(0, 0), new NumberSequenceKeypoint(1, scale)]);
		});
	}
}
