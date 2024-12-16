import { Character } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";

export interface IAbilityModel {
	// Model and Reference
	Model: Model;
	HitPart: BasePart;
	WCSCharacterReference: Character;
	_AlignOrientation: AlignOrientation;
	_UniversalConstraint: UniversalConstraint;

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
	_CharacterAttachment: Attachment;
	_AlignOrientation: AlignOrientation;
	_UniversalConstraint: UniversalConstraint;

	AnimationTracks: Map<string, AnimationTrack> = new Map();
	AudioTracks: Map<string, Sound> = new Map();

	HitConnection: RBXScriptConnection;

	constructor(wcsCharacter: Character, templateModel: Model) {
		//Logger.Log("AbilityModel", " - Ability Model Constructed\n");
		this.Model = templateModel.Clone();
		this.HitPart = this.Model.FindFirstChild("HitPart") as BasePart;
		this.WCSCharacterReference = wcsCharacter;
		this._CharacterAttachment = new Instance("Attachment");
		this._CharacterAttachment.Parent = this.WCSCharacterReference.Instance.FindFirstChild("RightHand") as BasePart;
		this.Model.Parent = this.WCSCharacterReference.Instance;
		this.HitPart.Anchored = true;


		// Attach to AlignOrientation and UniversalConstraint
		this._AlignOrientation = this.Model.FindFirstChild("AlignOrientation",true) as AlignOrientation;
		this._UniversalConstraint = this.Model.FindFirstChild("UniversalConstraint",true) as UniversalConstraint;
		
		
	

		this.HitConnection = this.HitPart.Touched.Connect((hit) => {
			if (hit.Parent === this.WCSCharacterReference.Instance) {
				Logger.Log("AbilityModel", " - Hit Self\n");
				return;
			}
			this.OnHit();
		});

		return this;
	}

	private _attachModelToCharacter() {
		this._AlignOrientation.Attachment1 = this._CharacterAttachment;
		this._UniversalConstraint.Attachment1 = this._CharacterAttachment;
	}

	private _detachModelFromCharacter() {
		this._AlignOrientation.Attachment1 = undefined;
		this._UniversalConstraint.Attachment1 = undefined;
	}

	public Activate(phase: number) {
		switch (phase) {
			case 1:
				this.Model.Parent = this.WCSCharacterReference.Instance;
				this._attachModelToCharacter();
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
		this._detachModelFromCharacter();

	}

	public OnHit() {
		Logger.Log("AbilityModel", " - Ability Hit\n");
		// Do something when the ability hits
	}
}
