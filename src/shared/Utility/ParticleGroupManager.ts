import { GameStorage } from "./GameStorage";
import { Logger } from "./Logger";

export class ParticleGroupManager {
	private constructor() {}

	// Helper function to get all particle effects in a particle group
	private static getParticleDecendants(particleParent: Instance): ParticleEmitter[] {
		const particleEffects = particleParent.GetChildren().filter((child) => child.IsA("ParticleEmitter")) as ParticleEmitter[];
		return particleEffects;
	}

	// Get a cloned array of particle effects in a particle group
	public static GetParticleGroup(name: string): ParticleEmitter[] {
		const particleGroup = GameStorage.cloneParticleGroupAttachment(name).GetDescendants().filter((child) => child.IsA("ParticleEmitter")) as ParticleEmitter[];
		if (particleGroup === undefined) {
			Logger.Log("ParticleGroupManager", "Particle Group not found", name);
		}
		return particleGroup;
	}

	// Parent all particle effects in a particle group to a parent
	public static ParentParticleEmtters(particleGroup: ParticleEmitter[], parent: Instance): void {
		particleGroup.forEach((particle) => {
			particle.Parent = parent;
		});
	}

	// Get a particle group by name
	public static SpawnParticleGroup(name: string, parent: Instance): void {
		const particleGroup = GameStorage.cloneParticleGroupAttachment(name).GetDescendants().filter((child) => child.IsA("ParticleEmitter")) as ParticleEmitter[];
		if (particleGroup === undefined) {
			Logger.Log("ParticleGroupManager", "Particle Group not found", name);
		}
		particleGroup.forEach((particle) => {
			particle.Parent = parent;
		});

	}

	// Enable all particle effects in a particle group
	public static EnableParticleEmitters(particleEmitter: [ParticleEmitter]): void {
		particleEmitter.forEach((particle) => {
			particle.Enabled = true;
			Logger.Log("BasicMelee", "Enabling Particle Emitter", particle.Name);
		});
	}

	// Disable all particle effects in a particle group
	public static DisableParticleEmitters(particleEmitter: [ParticleEmitter]): void {
		particleEmitter.forEach((particle) => {
			particle.Enabled = false;
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
