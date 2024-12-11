import { Skill } from "@rbxts/wcs";
import { Logger } from "../Utility/Logger";
import { TweenService } from "@rbxts/services";

export enum SkillPartState {
	Spawning = "Spawning",
	Active = "Active",
	Triggered = "Triggered",
	Ending = "Ending",
}

export interface SkillPart {
	State: SkillPartState;
	transitionTo(newState: SkillPartState): void;
	onSpawn(): void;
	onActivate(): void;
	onTrigger(): void;
	onEnd(): void;
}

export class SkillPartClass implements SkillPart {
	public instance: Model;
	public State: SkillPartState = SkillPartState.Spawning;
	private _hitPart: BasePart;
	private _primaryPart: BasePart;

	// Dummy VectorForce
	private _vectorForce = new Instance("VectorForce");

	private _hitConnection: RBXScriptConnection | undefined;

	constructor(model: Model) {
		// Dummy VectorForce
		this._vectorForce.Force = new Vector3(0, 2990, 0);
		this._vectorForce.RelativeTo = Enum.ActuatorRelativeTo.Attachment0;
		this._vectorForce.ApplyAtCenterOfMass = true;
		this._vectorForce.Name = "DummyVectorForce";
		// Set the instance
		this.instance = model;
		this._primaryPart = model.PrimaryPart as BasePart;
		this._hitPart = model.FindFirstChild("HitPart") as BasePart;

		if (!this._hitPart || !this._primaryPart) {
			Logger.Log("SkillPart", "HitPart not found", model.Name);

			error("HitPart not found in SkillPart");
		}

		// Set the Initial State
		this.transitionTo(SkillPartState.Spawning);

		// Hit Connection
		this._hitConnection = this._hitPart.Touched.Connect((hit) => {
			const attachment = hit.FindFirstChildOfClass("Attachment") as Attachment;

			if (!attachment) {
				return;
			}

			this._vectorForce.Attachment0 = attachment;
			this._vectorForce.Parent = hit;
			this._vectorForce.Enabled = true;

			this.transitionTo(SkillPartState.Triggered);
		});

		return this;
	}

	public transitionTo(newState: SkillPartState): void {
		// Example: simple state transition with a switch for any specific logic
		this.State = newState;
		switch (newState) {
			case "Spawning":
				this.onSpawn();
				break;
			case "Active":
				this.onActivate();
				break;
			case "Triggered":
				this.onTrigger();
				break;
			case "Ending":
				this.onEnd();
				break;
		}
	}

	public onSpawn(): void {
		this._hitPart.Color = Color3.fromRGB(255, 222, 220);
		Logger.Log("SkillPart", "Spawn!", this.State);
		// Add any initialization or setup logic here
		task.wait(2);
		this.transitionTo(SkillPartState.Active);
	}

	public onActivate(): void {
		this._hitPart.Color = Color3.fromRGB(255, 22, 220);

		task.spawn(() => {
			while (this.State === SkillPartState.Active) {
				print("Active");

				const randomX = math.random(-10, 10);
				const randomZ = math.random(-10, 10);
				const goalCFrame = this._primaryPart.CFrame.add(new Vector3(randomX, 0, randomZ));
				const goal = {
					CFrame: goalCFrame,
					//Size: new Vector3(100, 100, 100),
				};
				const tween = TweenService.Create(
					this._primaryPart,
					new TweenInfo(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
					goal,
				);

				tween.Play();

				tween.Completed.Connect(() => {
					tween.Destroy();
				});
				task.wait(2);
			}
		});

		const randomX = math.random(-10, 10);
		const randomZ = math.random(-10, 10);
		const goalCFrame = this._primaryPart.CFrame.add(new Vector3(randomX, 0, randomZ));
		const goal = {
			CFrame: goalCFrame,
			//Size: new Vector3(100, 100, 100),
		};
		const tween = TweenService.Create(
			this._primaryPart,
			new TweenInfo(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
			goal,
		);

		tween.Play();

		Logger.Log("SkillPart", "onEnd", this.State);
		// Add logic for when the skill becomes active
	}

	public onTrigger(): void {
		Logger.Log("SkillPart", "onEnd", this.State);
		this._hitPart.Color = Color3.fromRGB(255, 0, 0);
		task.wait(2);
		this.transitionTo(SkillPartState.Active);
		// Add logic for triggered behavior (like firing a projectile or applying an effect)
	}

	public onEnd(): void {
		Logger.Log("SkillPart", "onEnd", this.State);
		// Add cleanup logic here
	}
}
