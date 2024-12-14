import { Character } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";

export interface IAbilityModel {
	// Model and Reference
	Model: Model;
	HitPart: BasePart;
	WCSCharacterReference: Character;

	// Audio and Animation Tracks
	AnimationTracks: Map<string, AnimationTrack>;
	AudioTracks: Map<string, Sound>;

	// Connection
	HitConnection: RBXScriptConnection;

	// Methods
	Activate(phase: number): void;

	Cancel(): void; // Called when the ability is cancelled/interrupted
	OnEnded(): void; // Called when the ability ends from a WCSSkill
	OnHit(): void; // Called when the ability hits;
}

export class AbilityModel implements IAbilityModel {
	Model: Model;
	HitPart: BasePart;
	WCSCharacterReference: Character;

	AnimationTracks: Map<string, AnimationTrack> = new Map();
	AudioTracks: Map<string, Sound> = new Map();

	HitConnection: RBXScriptConnection;

	constructor(wcsCharacter: Character, templateModel: Model) {
		Logger.Log("AbilityModel", " - Ability Model Constructed\n");
		this.Model = templateModel.Clone();
		this.HitPart = this.Model.FindFirstChild("HitPart") as BasePart;
		this.WCSCharacterReference = wcsCharacter;

		this.HitConnection = this.HitPart.Touched.Connect((hit) => {
			if (hit.Parent === this.WCSCharacterReference.Instance) {
				Logger.Log("AbilityModel", " - Hit Self\n");
				return;
			}
			this.OnHit();
		});

		return this;
	}

	public Activate(phase: number) {
		switch (phase) {
			case 1:
				Logger.Log("AbilityModel", "\t Phase 1 \n");
				break;
			case 2:
				Logger.Log("AbilityModel", "\t Phase 2 \n");
				break;
			case 3:
				Logger.Log("AbilityModel", "\t Phase 3 \n");
				break;
			default:
				break;
		}
	}

	public Cancel() {
		Logger.Log("AbilityModel", " - Ability Cancelled\n");
	}

	public OnEnded() {
		// Do something when the ability ends
		Logger.Log("AbilityModel", " - Ability Ended\n");
	}

	public OnHit() {
		Logger.Log("AbilityModel", " - Ability Hit\n");
		// Do something when the ability hits
	}
}
