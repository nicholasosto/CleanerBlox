import { Debris } from "@rbxts/services";
import { GameStorage } from "shared/Utility/GameStorage";
import { Logger } from "shared/Utility/Logger";

const scriptTag = "TEffect";

export class TEffect {
	public Name: string;
	private _particleGroupingPart: Part | undefined; // Particle Effects are grouped under an attachment in the part
    private _attachment: Attachment | undefined; // Attachment for the particle effects
	private _particleEffects: ParticleEmitter[] = [];
    private _soundEffect: Sound | undefined;

	constructor(effectName: string, particleGroupingPart: Part, soundEffect: Sound, duration: number) {
        // Set the effect name
		this.Name = `Effect_${effectName}`;

        // Set the particle grouping part
		this._particleGroupingPart = particleGroupingPart.Clone();
        
		this._soundEffect = soundEffect.Clone();
		this._particleEffects = this._particleGroupingPart
			.GetDescendants()
			.filter((child) => child.IsA("ParticleEmitter")) as ParticleEmitter[];
		this._particleEffects.forEach((particle) => {
			Logger.Log(scriptTag, particleGroupingPart, particleGroupingPart.CFrame);
		});


	}

	public playEffect(parent: Instance) {
		if (this._particleGroupingPart) {
			print("Playing Effect: " + this.Name);
			this._particleGroupingPart.Parent = parent;
			//Debris.AddItem(this._particleGroupingPart, 5);
		}

		if (this._soundEffect) {
			print("Playing Sound: " + this._soundEffect.Name);
			this._soundEffect.Play();
		}
	}
}

export const EffectList = {
	// eslint-disable-next-line prettier/prettier
    BlackHole_01: new TEffect("BlackHole", GameStorage.getParticleGroupPart("03 - BLACK HOLE [A]"), GameStorage.getAudio("Creepy Night"), 5),
	// eslint-disable-next-line prettier/prettier
    BlackHole_02: new TEffect("BlackHoleSun", GameStorage.getParticleGroupPart("04 - BLACK HOLE [B]"), GameStorage.getAudio("Null Ending"), 5),
};
