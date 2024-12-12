import { HoldableSkill, SkillDecorator, Message, Character } from "@rbxts/wcs";
import { GameStorage } from "shared/Utility/GameStorage";
import { ReplicatedStorage, Workspace } from "@rbxts/services";
import { Spotlight } from "shared/Skill Parts/Spotlight";
import { CFrameGenerator } from "shared/Utility/CFrameGenerator";
import { AnimationManager } from "shared/Utility/AnimationManager";
import { Logger } from "shared/Utility/Logger";


const cFrameGenerator = new CFrameGenerator();

@SkillDecorator
export class Spotlights extends HoldableSkill {
	
	// Configuration Properties
	private readonly Cooldown = 10; // Cooldown in seconds
	private readonly HoldTime = 5; // Hold Time in seconds
	private readonly SkillId = "Spotlights"; // Skill Id

	// Properties
	private Spotlights: Array<Spotlight> = new Array<Spotlight>();

	private createSpotlight(cFrame: CFrame) {
		const spotlightModel = GameStorage.getModel("Spotlight").Clone();
		spotlightModel.Parent = Workspace;
		spotlightModel.PivotTo(cFrame);
		const spotlight = new Spotlight(spotlightModel);
	}

	// Move Constructor
	public OnConstructServer() {
		// Set the Max Hold Time for the skill
		this.SetMaxHoldTime(5);

		// Connect to the HoldTimer's secondReached event
		this.HoldTimer.secondReached.Connect((seconds) => this.stageActivated(seconds));
		AnimationManager.RegisterAnimationsFor(this.Character);
	}

	// MOVE START
	public OnStartServer() {
		this.ApplyCooldown(10);
	}

	// Stages
	private stageActivated(stage: number) {
		print("Stage Activated: ", stage, this.CooldownTimer.getTimeLeft());
		switch (stage) {
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
		const userCFrame = (this.Character.Instance as Model).GetPivot();
		const spotlightCFrame = cFrameGenerator.createTargetFrame(userCFrame, 10);
		this.createSpotlight(spotlightCFrame);
		Logger.Log("Spotlights", "Stage 1", spotlightCFrame);
	}

	// STAGE 2
	private Stage2() {
		Logger.Log("Spotlights", "Stage 2");
	}

	// STAGE 3
	private Stage3() {
		Logger.Log("Spotlights", "Stage 3");
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log("Spotlights", "End");
	}
}
