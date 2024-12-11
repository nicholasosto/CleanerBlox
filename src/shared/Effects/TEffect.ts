import { ReplicatedStorage, Debris } from "@rbxts/services";
import { GameStorage } from "shared/Utility/GameStorage";


export class TEffect {
	public effectName: string;
	private _particleGroupingPart: Part | undefined;
	private _soundEffect: Sound | undefined;

	constructor(effectName: string, particleGroupingPart: Part, soundEffect: Sound, duration: number) {
		this.effectName = effectName;
		this._particleGroupingPart = particleGroupingPart;
		this._soundEffect = soundEffect;


	}

	private onEffect(...args: unknown[]): void {
		// Override this method in your subclass
	}
}

export const EffectList = {
	// eslint-disable-next-line prettier/prettier
    BlackHole_01: new TEffect("BlackHole", GameStorage.getParticleGroupPart("03 - BLACK HOLE [A]"), GameStorage.getAudio("Creepy Night"), 5),
    // eslint-disable-next-line prettier/prettier
    BlackHole_02: new TEffect("BlackHole", GameStorage.getParticleGroupPart("03 - BLACK HOLE [B]"), GameStorage.getAudio("Null Ending"), 5),

};
