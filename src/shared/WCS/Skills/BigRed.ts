import { HoldableSkill, SkillDecorator, Message, Character } from "@rbxts/wcs";
import { Workspace } from "@rbxts/services";
import { Spotlight } from "shared/Creations/Spotlight";
import { CFrameGenerator } from "shared/Utility/CFrameGenerator";
import { AnimationManager } from "shared/Utility/AnimationManager";
import { EffectList } from "shared/Effects/TEffect";


const cFrameGenerator = new CFrameGenerator();

@SkillDecorator
export class BigRed extends HoldableSkill {
	// Properties
	private BigRed: Spotlight[] = [];

	protected ToadDance() {
		const toadies = Workspace.WaitForChild("ToadArmy")
			.GetChildren()
			.filter((child): child is Model => child.IsA("Model"));

		toadies.forEach((toadie) => {
			const wcsToadie = Character.GetCharacterFromInstance(toadie) as Character;

			AnimationManager.PlayAnimationFor(wcsToadie, "DanteBackflip");
		});
	}

	// Move Constructor
	public OnConstructServer() {
		// Set the Max Hold Time for the skill
		this.SetMaxHoldTime(5);
		// Connect to the HoldTimer's secondReached event
		this.HoldTimer.secondReached.Connect((seconds) => this.stageActivated(seconds));

		AnimationManager.RegisterAnimationsFor(this.Character);

		const effect = EffectList.BlackHole_01;
	}

	// MOVE START
	public OnStartServer() {
		this.ToadDance();
		task.wait(0.1);

		AnimationManager.PlayAnimationFor(this.Character, "Godlike");
	}

	// Stages
	private stageActivated(stage: number) {
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
		const spotlight = new Spotlight(
			cFrameGenerator.createTargetFrame(userCFrame, 10),
			this.Character.Instance as Model,
		);
		const PrimaryPart = spotlight.instance.PrimaryPart as BasePart;

		if (!PrimaryPart) {
			error("PrimaryPart not found");
		}
		PrimaryPart.Anchored = true;
		this.BigRed.push(spotlight);
		print("Stage 1 User CFrame: ", userCFrame);
	}

	// STAGE 2
	private Stage2() {
		const userCFrame = (this.Character.Instance as Model).GetPivot();
		const spotlightCFrames = cFrameGenerator.createRing(userCFrame, 10, 8);

		spotlightCFrames.forEach((cFrame) => {
			const spotlight = new Spotlight(cFrame, this.Character.Instance as Model);
			const PrimaryPart = spotlight.instance.PrimaryPart as BasePart;

			if (!PrimaryPart) {
				error("PrimaryPart not found");
			}
			PrimaryPart.Anchored = true;
			this.BigRed.push(spotlight);
		});
	}

	// STAGE 3
	private Stage3() {
		const userCFrame = (this.Character.Instance as Model).GetPivot();
		const spotlightCFrames = cFrameGenerator.createRing(userCFrame, 50, 18);

		spotlightCFrames.forEach((cFrame) => {
			const spotlight = new Spotlight(cFrame, this.Character.Instance as Model);
			const PrimaryPart = spotlight.instance.PrimaryPart as BasePart;

			if (!PrimaryPart) {
				error("PrimaryPart not found");
			}
			PrimaryPart.Anchored = true;
			this.BigRed.push(spotlight);
		});
	}

	// END SERVER
	public OnEndServer() {
		warn("BigRed Ended");
		this.Character.Humanoid.WalkSpeed = 16;
		this.BigRed.forEach((spotlight) => {
			spotlight.Destroy();
		});
	}
}
