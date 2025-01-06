import { Skill, SkillDecorator } from "@rbxts/wcs";
//import { SkillDefinitions } from "shared/_References/Skills";
import { Logger } from "shared/Utility/Logger";

@SkillDecorator
export class BasicHold extends Skill {
	//public static SkillConfiguration = SkillDefinitions["BasicHold"];

	// 00. CONSTRUCT
	public OnConstruct() {
		Logger.Log(script, "BasicHold Construct");
	}

	public OnConstructServer(): void {
		Logger.Log(script, "BasicHold Server");
		//this.DamageContainer = new DamageContainer(this, "Melee", 10);
		Logger.Log(script, "BasicHold Construct");
	}

	public OnConstructServer(): void {
		Logger.Log(script, "BasicHold Server");
		//this.DamageContainer = new DamageContainer(this, "Melee", 10);
	}

	// 01. CONSTRUCT CLIENT
	public OnConstructClient(): void {
		Logger.Log(script, "BasicHold Client");
		Logger.Log(script, "BasicHold Client");
	}

	// MOVE START
	public OnStartServer() {
		Logger.Log(script, "Start Server");
		Logger.Log(script, "Start Server");
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log(script, "End Server");
		Logger.Log(script, "End Server");
	}
}
