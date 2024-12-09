import { HoldableSkill, SkillDecorator, Message } from "@rbxts/wcs";
import { ReplicatedStorage, Workspace } from "@rbxts/services";
import { rotateModel, rotatePart, randomSearch } from "shared/Utility/PartEffects";
import { Spotlight } from "shared/Creations/Spotlight";
import { FormationFrames, TCFrame } from "shared/Utility/TCFrame";

const SkillConfiguration: Configuration = ReplicatedStorage.FindFirstChild("Config_Spotlights", true) as Configuration;
@SkillDecorator
export class Spotlights extends HoldableSkill {
	// Properties
	private Attachments: Attachment[] = [];

	// Move Constructor
	public OnConstructServer() {
		// Set the Max Hold Time for the skill
		this.SetMaxHoldTime(5);
	}

	// MOVE START
	public OnStartServer() {
		task.wait(0.3);

		// Generate the attachments
		const character = this.Character.Instance as Model;
		const sourceAttachment = character.FindFirstChild("CastingFloor", true) as Attachment;
		this.Attachments = TCFrame.generateAttachments(sourceAttachment, FormationFrames.Line, false);

		// Connect to the HoldTimer's secondReached event
		this.HoldTimer.secondReached.Connect((seconds) => this.stageActivated(seconds));
	}

	// Stages
	private stageActivated(stage: number) {
		switch (stage) {
			case 1:
				this.Stage1();
				break;
			case 2:
				this.Stage2();
				break;
			case 3:
				this.Stage3();
				break;
			default:
				break;
		}
	}

	// STAGE 1
	private Stage1() {
		for (let i = 1; i < this.Attachments.size(); i++) {
			const attachment = this.Attachments[i];
			const spotlight = new Spotlight(this.Character.Instance as Model, attachment);
			spotlight.SpawnSpotlight();
		}
	}

	// STAGE 2
	private Stage2() {
		print("Stage 2");
	}

	// STAGE 3
	private Stage3() {
		print("Stage 3");
	}

	// END SERVER
	public OnEndServer() {
		warn("Spotlights Ended");
		this.Character.Humanoid.WalkSpeed = 16;
		this.Attachments.forEach((attachment) => attachment.Destroy());
	}
}
