import { HoldableSkill, SkillDecorator } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";

@SkillDecorator
export class BasicHold extends HoldableSkill {
	public static SkillConfiguration = {
		DisplayName: "Clean Skill",
		ImageId: "rbxassetid://132928610589952",
		ActivationTime: 1,
		DefaultHealthChange: 0,
		DefaultHoldTime: 5,
		DefaultCooldownTime: 3,
		DefaultManaCost: 10,
		DefaultStaminaCost: 10,
	};

	// 00. CONSTRUCT
	public OnConstruct() {
		this.SetMaxHoldTime(BasicHold.SkillConfiguration.DefaultHoldTime);
	}

	// 01. CONSTRUCT CLIENT
	public OnConstructClient(): void {
		//Logger.Log(script,"BasicHold-Client");
	}

	// MOVE START
	public OnStartServer() {
		this.ApplyCooldown(BasicHold.SkillConfiguration.DefaultCooldownTime);

		// Cooldown Timer
		this.CooldownTimer.secondReached.Connect((seconds) => {
			//Logger.Log(this.GetName(), `Cooldown: ${seconds}\n`);
		});

		// Hold Timer
		this.HoldTimer.secondReached.Connect((seconds) => this._holdTimerReached(seconds));
	}

	// Stages
	private _holdTimerReached(seconds: number) {
		//Logger.Log(script,"BasicHold", `Hold: ${seconds}\n`);

		//const devilBeamTool = GameStorage.cloneTool("DevilBeam");
		switch (seconds) {
			case 1:
				this.Stage1();
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

	// Skill Stages
	private ActivationStage() {
		Logger.Log(script, "BasicHold", "Activation Stage\n");
	}

	private Stage1() {
		Logger.Log(this.GetName(), "Stage 01 called\n");
	}

	// STAGE 2
	private Stage2() {
		Logger.Log(this.GetName(), "Stage 02 called\n");
	}

	// STAGE 3
	private Stage3() {
		Logger.Log(this.GetName(), "Stage 03 called\n");
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log(this.GetName(), "OnEndServer\n");
	}
}
