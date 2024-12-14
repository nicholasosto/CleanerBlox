import { HoldableSkill, SkillDecorator } from "@rbxts/wcs";
import { CFrameGenerator } from "shared/Utility/CFrameGenerator";
import { Logger } from "shared/Utility/Logger";
import { GameStorage } from "shared/Utility/GameStorage";
import { ParticleGroupManager } from "shared/Utility/ParticleGroupManager";

@SkillDecorator
export class BigRed extends HoldableSkill {
	// Properties
	private AbilityPart: Model | undefined;
	private ChargingEffectAttachment: Attachment = GameStorage.cloneParticleGroupAttachment("RedCasting");

	// Skill Settings
	private _defaultHoldTime: number = 5;
	private _defaultCooldownTime: number = 3;

	// 00. CONSTRUCT SERVER
	public OnConstructServer() {
		// Set Max Hold Time
		
		Logger.Log(this.GetName(), " - Constructed\n");
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
		const particleParent = this.Character.Instance?.FindFirstChild("Head") as BasePart;

		this.ChargingEffectAttachment.Parent = particleParent;
		Logger.Log("BigRed", "Stage Activated: ", tostring(seconds), tostring(this.CooldownTimer.getTimeLeft()));
		
	
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
		
		this.ChargingEffectAttachment.GetChildren()
			.filter((child) => child.IsA("ParticleEmitter"))
			.forEach((emitter) => {
				(emitter as ParticleEmitter).Enabled = true;
			});
	}

	// STAGE 2
	private Stage2() {
		Logger.Log(this.GetName(), " - Stage 02 called\n");
		this.ChargingEffectAttachment.GetChildren()
			.filter((child) => child.IsA("ParticleEmitter"))
			.forEach((emitter) => {
				(emitter as ParticleEmitter).TimeScale = (emitter as ParticleEmitter).TimeScale * 2;
			});
	}

	// STAGE 3
	private Stage3() {
		Logger.Log(this.GetName(), " - Stage 03 called\n");

		Logger.Log(this.GetName(), " - Stage 02 called\n");
		this.ChargingEffectAttachment.GetChildren()
			.filter((child) => child.IsA("ParticleEmitter"))
			.forEach((emitter) => {
				(emitter as ParticleEmitter).TimeScale =  (emitter as ParticleEmitter).TimeScale * 2;
			});
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log(this.GetName(), "\n--------  Stage Activated Server  --------\n");
		this.ChargingEffectAttachment?.GetChildren()
			.filter((child) => child.IsA("ParticleEmitter"))
			.forEach((emitter) => {
				(emitter as ParticleEmitter).Enabled = false;
			});
	}
}
