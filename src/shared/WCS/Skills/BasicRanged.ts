import { Skill, SkillDecorator } from "@rbxts/wcs";
import { SkillConfigurations } from "shared/_References/Skills/Skills";
import { Logger } from "shared/Utility/Logger";

@SkillDecorator
export class BasicRanged extends Skill {
	public static SkillConfiguration = SkillConfigurations.BasicRanged;

	// 00. CONSTRUCT
	public OnConstruct() {
		Logger.Log(script, "BasicRanged Construct");
	}

	public OnConstructServer(): void {
		Logger.Log(script, "BasicRanged Server");
		//this.DamageContainer = new DamageContainer(this, "Melee", 10);
	}

	// 01. CONSTRUCT CLIENT
	public OnConstructClient(): void {
		Logger.Log(script, "BasicRanged Client");
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
