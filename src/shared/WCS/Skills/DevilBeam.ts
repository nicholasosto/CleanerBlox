import { HoldableSkill, SkillDecorator } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";
import { GameStorage } from "shared/Utility/GameStorage";
import { ParticleGroupManager } from "shared/Utility/ParticleGroupManager";

@SkillDecorator
export class DevilBeam extends HoldableSkill {
	// Properties
	private AbilityPart: Model | undefined;

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
		Logger.Log("DevilBeam", " - Constructed\n");
	}

	// MOVE START
	public OnStartServer() {
		this.ApplyCooldown(this._defaultCooldownTime);
		this.SetMaxHoldTime(this._defaultHoldTime);
		Logger.Log(this.GetName(), " - Skill Started\n");
		this.HoldTimer.secondReached.Connect((seconds) => this.stageActivated(seconds));
	}

	// Stages
	private stageActivated(seconds: number) {
		Logger.Log(this.GetName(), "\n--------  Stage Activated Server  --------\n");
		switch (seconds) {
			case 1:
				this.Stage3();
				break;
			case 2:
				this.Stage2();
				break;
			case 3:
				this.Stage1();
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
	}
}
