import { HoldableSkill, SkillDecorator } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";
import { AbilityModel } from "shared/Experimental/AbilityModel";
import { GameStorage } from "shared/Utility/GameStorage";
import { ParticleGroupManager } from "shared/Utility/ParticleGroupManager";
import { SkillConfigurations } from "../Interfaces/RSkills";
import { HttpService, TweenService } from "@rbxts/services";
import { logError } from "@rbxts/wcs/out/source/utility";

// AnimationID = 132928610589952 DevilBeam Fired

@SkillDecorator
export class DevilBeam extends HoldableSkill {
	// Properties
	//public AbilityModelInstance: AbilityModel = new AbilityModel(this.Character, GameStorage.getModel("DevilBeam"));
	private _animationInstance: Animation = GameStorage.cloneAnimation("DevilBeam Fired");
	private _animationTrack: AnimationTrack | undefined;
	private SkillConfiguration = SkillConfigurations["DevilBeam"];

	// Starting Effects
	//private ChargingEffectAttachment: Attachment = GameStorage.cloneParticleGroupAttachment("DevilBeamActivation");
	//private StartingAnimation: Animation = GameStorage.getAnimation("DevilBeamActivation");

	// Skill Settings
	public DisplayName = "Devil Beam";
	private ActivationTime: number = 1;
	private _defaultHoldTime: number = 5;
	private _defaultCooldownTime: number = 3;
	private _defaultManaCost: number = 10; //TODO: Implement Mana Cost
	private _defaultStaminaCost: number = 10; // TODO: Implement Stamina Cost

	// 00. CONSTRUCT SERVER
	public OnConstructServer() {
		// Load Animations and Particles
		//Logger.Log(script,"DevilBeam", " - Constructed\n");

		const humanoid = this.Character.Humanoid;
		const animator = humanoid?.FindFirstChildOfClass("Animator");
		const animation = GameStorage.cloneAnimation("DevilBeam Fired");
		this._animationTrack = animator?.LoadAnimation(animation);

		warn(animation.AnimationId, " loaded");
		if (animation) {
			Logger.Log(script,"DevilBeam", "Animation Found\n");
			return;
		} else {
			Logger.Log(script,"DevilBeam", "Animation Not Found\n");
		}
	}

	public OnConstructClient(): void {
		//Logger.Log(script,"DevilBeam", " - Constructed\n");
		Logger.Log(HttpService.JSONEncode(this.Name));
	}

	// MOVE START
	public OnStartServer() {
		const characterModel = this.Character.Instance as Model;
		const primartyPart = characterModel.PrimaryPart as BasePart;

		if (this._animationTrack) {
			primartyPart.Anchored = true;
			const animationSpeed = this._animationTrack.Length / this.ActivationTime;
			this._animationTrack.Play();
			this._animationTrack.AdjustSpeed(animationSpeed);
		}
		task.delay(this.ActivationTime, () => {
			primartyPart.Anchored = false;
		});
		const hitPart: BasePart | undefined = this.Character.Instance.FindFirstChild("HitPart", true) as BasePart;
		const tweenInfo = new TweenInfo(
			this.ActivationTime,
			Enum.EasingStyle.Cubic,
			Enum.EasingDirection.Out,
			0,
			false,
			0,
		);
		const tween = TweenService.Create(hitPart, tweenInfo, {
			Size: new Vector3(3, 30, 3),
			CFrame: new CFrame(hitPart.Position, hitPart.Position.add(new Vector3(0, 30, 0))),
		}) as Tween;

		tween.Play();
		this.ApplyCooldown(this._defaultCooldownTime);
		this.SetMaxHoldTime(this._defaultHoldTime);

		// Cooldown Timer
		this.CooldownTimer.secondReached.Connect((seconds) => {
			Logger.Log(this.GetName(), `Cooldown: ${seconds}\n`);
		});

		// Hold Timer
		this.HoldTimer.secondReached.Connect((seconds) => this.stageActivated(seconds));
	}

	// Stages
	private stageActivated(seconds: number) {
		Logger.Log(this.GetName(), "\n--------  Stage Activated Server  --------\n");

		//const devilBeamTool = GameStorage.cloneTool("DevilBeam");
		switch (seconds) {
			case 1:
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
		const animation = GameStorage.cloneAnimation("DevilBeam Fired");
		if (animation) {
			Logger.Log(script,"DevilBeam", "Animation Found\n");
			return;
		} else {
			Logger.Log(script,"DevilBeam", "Animation Not Found\n");
		}
	}
}
