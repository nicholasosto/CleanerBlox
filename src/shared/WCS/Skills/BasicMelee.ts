import { Skill, SkillDecorator } from "@rbxts/wcs";
import { SkillConfigurations } from "shared/_References/Skills/Skills";
import { Logger } from "shared/Utility/Logger";

@SkillDecorator
export class BasicMelee extends Skill {
	public static SkillConfiguration = SkillConfigurations.BasicMelee;

	// 00. CONSTRUCT
	public OnConstruct() {
		Logger.Log(script, "BasicMelee Construct");
	}

	public OnConstructServer(): void {
		Logger.Log(script, "BasicMelee Server");
		//this.DamageContainer = new DamageContainer(this, "Melee", 10);
	}

	// 01. CONSTRUCT CLIENT
	public OnConstructClient(): void {
		Logger.Log(script, "BasicMelee Client");
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
