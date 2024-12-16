import { HoldableSkill, SkillDecorator } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";
import { AbilityModel } from "shared/WCS/Interfaces/IAbilityModel";
import { GameStorage } from "shared/Utility/GameStorage";
import { ParticleGroupManager } from "shared/Utility/ParticleGroupManager";
import { SkillConfigurations } from "../Interfaces/SkillConfigurations";
import { HttpService } from "@rbxts/services";

// AnimationID = 132928610589952 DevilBeam Fired

@SkillDecorator
export class DevilBeam extends HoldableSkill {
	// Properties
	//public AbilityModelInstance: AbilityModel = new AbilityModel(this.Character, GameStorage.getModel("DevilBeam"));
	private _animationInstance: Animation = GameStorage.getAnimation("DevilBeam Fired");
	private _animationTrack: AnimationTrack = this.Character.Humanoid.LoadAnimation(this._animationInstance);
	private SkillConfiguration = SkillConfigurations["DevilBeam"];

	// Starting Effects
	//private ChargingEffectAttachment: Attachment = GameStorage.cloneParticleGroupAttachment("DevilBeamActivation");
	//private StartingAnimation: Animation = GameStorage.getAnimation("DevilBeamActivation");

	// Skill Settings
	public DisplayName = "Devil Beam";
	private _defaultHoldTime: number = 5;
	private _defaultCooldownTime: number = 3;
	private _defaultManaCost: number = 10; //TODO: Implement Mana Cost
	private _defaultStaminaCost: number = 10; // TODO: Implement Stamina Cost

	// 00. CONSTRUCT SERVER
	public OnConstructServer() {
		// Load Animations and Particles
		//Logger.Log("DevilBeam", " - Constructed\n");

		const humanoid = this.Character.Humanoid;

		if (humanoid === undefined) {
			Logger.Log("DevilBeam", " - Humanoid Not Found\n");
			return;
		}

		// Load Animation
		const animator = humanoid.FindFirstChildOfClass("Animator");
		if (animator) {
			Logger.Log("DevilBeam", "Animator Found\n");
			return;
		}

		const animation: Animation = GameStorage.getAnimation("DevilBeam Fired");
		warn(animation.AnimationId, " loaded");
		if (animation) {
			Logger.Log("DevilBeam", "Animation Found\n");
			return;
		} else {
			Logger.Log("DevilBeam", "Animation Not Found\n");
		}
	}

	public OnConstructClient(): void {
		//Logger.Log("DevilBeam", " - Constructed\n");
		Logger.Log(HttpService.JSONEncode(this.Name));

	}

	// MOVE START
	public OnStartServer() {
		// Apply Cooldown and Hold Time
		//this.AbilityModelInstance = new AbilityModel(this.Character, GameStorage.getModel("DevilBeam"));
		this.ApplyCooldown(this._defaultCooldownTime);
		this.SetMaxHoldTime(this._defaultHoldTime);

		// Cooldown Timer
		this.CooldownTimer.secondReached.Connect((seconds) => {
			Logger.Log(this.GetName(), `Cooldown: ${seconds}\n`);
		});

		// Hold Timer
		this.HoldTimer.secondReached.Connect((seconds) => this.stageActivated(seconds));


	
		const characterModel = this.Character.Instance as Model;
		const humnoidRootPart = characterModel.FindFirstChild("HumanoidRootPart") as BasePart;
		const _rightHand = this.Character.Instance.FindFirstChild("RightHand") as BasePart;
		humnoidRootPart.Anchored = true;


		task.delay(10, () => {
			humnoidRootPart.Anchored = false;
		});

	}

	// Stages
	private stageActivated(seconds: number) {
		Logger.Log(this.GetName(), "\n--------  Stage Activated Server  --------\n");
		const devilBeamTool = GameStorage.cloneTool("DevilBeam");
		switch (seconds) {
			case 1:
				//this.AbilityModelInstance.Activate(3);
				devilBeamTool.Parent = this.Character.Instance;
				break;
			case 2:
				this.Stage2();
				//this.AbilityModelInstance.Activate(2);
				break;
			case 3:
				this.Stage1();
				//this.AbilityModelInstance.Activate(1);
				break;
			default:
				break;
		}
	}

	// STAGE 1
	private Stage1() {
		Logger.Log(this.GetName(), " - Stage 01 called\n");
	}

	// STAGE 2
	private Stage2() {
		Logger.Log(this.GetName(), " - Stage 02 called\n");
	}

	// STAGE 3
	private Stage3() {
		Logger.Log(this.GetName(), " - Stage 03 called\n");
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log(this.GetName(), "\n--------  Stage Activated Server  --------\n");
		//this.AbilityModelInstance.OnEnded();
	}

	private _loadAnimation() {
		const animation = GameStorage.getAnimation("DevilBeam Fired");
		if (animation) {
			Logger.Log("DevilBeam", "Animation Found\n");
			return;
		} else {
			Logger.Log("DevilBeam", "Animation Not Found\n");
		}
	}
}
