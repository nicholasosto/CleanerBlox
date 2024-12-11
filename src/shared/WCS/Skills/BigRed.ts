import { HoldableSkill, SkillDecorator} from "@rbxts/wcs";
import { CFrameGenerator } from "shared/Utility/CFrameGenerator";
import { Logger } from "shared/Utility/Logger";

const cFrameGenerator = new CFrameGenerator();

@SkillDecorator
export class BigRed extends HoldableSkill {
	// Properties
	// Move Constructor
	public OnConstructServer() {
		Logger.Log("BigRed", "Construct");
	}

	// MOVE START
	public OnStartServer() {
		Logger.Log("BigRed", "Start");
	}

	// Stages
	private stageActivated(stage: number) {
		Logger.Log("BigRed", "Stage Activated: ", tostring(stage), tostring(this.CooldownTimer.getTimeLeft()));
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
		Logger.Log("BigRed", "Stage 1");
	}

	// STAGE 2
	private Stage2() {
		Logger.Log("BigRed", "Stage 2");
	}

	// STAGE 3
	private Stage3() {
		Logger.Log("BigRed", "Stage 3");
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log("BigRed", "End");
	}
}
