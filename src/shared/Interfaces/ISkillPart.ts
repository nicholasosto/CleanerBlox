import { GameStorage } from "shared/Utility/GameStorage";
import { Logger } from "shared/Utility/Logger";

// Interfaces
export interface ISkillPart {
	// Properties
	_primaryPart: BasePart;
	_hitPart: BasePart;

	// Consruction Properties
	SpawnCFrame: CFrame;
	TargetCFrame: CFrame;

	// Public Properties
	SkillPartModel: Model;
	Owner: Model;
	PartState: string;
	HealthChangeAmount: number;

	// Methods
	OnStart(): void;
	WhileActive(): void;
	OnEnd(): void;
}

// Skill Part States
export enum ESkillPartState {
	Spawning = "Spawning",
	Active = "Active",
	Triggered = "Triggered",
	Ending = "Ending",
}

// Example Skill Part Class (Template)
export class TestPart implements ISkillPart {
	// Consruction Properties
	SpawnCFrame: CFrame;
	TargetCFrame: CFrame;

	// Public Properties
	SkillPartModel: Model = GameStorage.cloneModel("TestPart");
	Owner: Model;
	PartState: string = "Spawning";
	HealthChangeAmount: number = 0;

	// Properties
	_primaryPart: BasePart = this.SkillPartModel.PrimaryPart as BasePart;
	_hitPart: BasePart = this.SkillPartModel.FindFirstChild("HitPart") as BasePart;

	constructor(spawnCFrame: CFrame, targetCFrame: CFrame, owner?: Model) {
		// Check if the primary part, hit part, and skill part model exist
		if (!this._primaryPart || !this._hitPart || !this.SkillPartModel) {
			throw "PrimaryPart, HitPart, or SkillPartModel not found";
		}

		// Set the CFrames
		this.SpawnCFrame = spawnCFrame;
		this.TargetCFrame = targetCFrame;

		// Set the Owner
		if (owner) {
			this.Owner = owner;
		} else {
			this.Owner = GameStorage.cloneModel("TestOwner");
		}

		// Log the creation of the skill part instance
		Logger.Log("SkillPart", this.SkillPartModel.Name, "Created");
		return this;
	}

	// Started
	OnStart(): void {
		Logger.Log("SkillPart", this.SkillPartModel.Name, "OnStart");
	}

	// Active
	WhileActive(): void {
		Logger.Log("SkillPart", this.SkillPartModel.Name, "WhileActive");
	}

	// Ended
	OnEnd(): void {
		Logger.Log("SkillPart", this.SkillPartModel.Name, "OnEnd");
	}
}
