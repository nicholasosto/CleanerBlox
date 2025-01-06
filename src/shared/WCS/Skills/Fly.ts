import { Skill, SkillDecorator } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";

@SkillDecorator
export class Fly extends Skill {
	// 00. CONSTRUCT
	public OnConstruct() {
		Logger.Log(script, "- Construct");
	}

	public OnConstructServer(): void {
		Logger.Log(script, " - Server");
		//this.DamageContainer = new DamageContainer(this, "Melee", 10);
	}

	// 01. CONSTRUCT CLIENT
	public OnConstructClient(): void {
		Logger.Log(script, "- Client");
	}

	// MOVE START
	public OnStartServer() {
		Logger.Log(script, "Start Server");
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log(script, "End Server");
	}
}
