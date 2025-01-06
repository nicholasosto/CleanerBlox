import { Skill, SkillDecorator } from "@rbxts/wcs";
//import { SkillDefinitions } from "shared/_References/Skills";
import { Logger } from "shared/Utility/Logger";
import { SkillDefinitions } from "shared/_References/Character/Skills";

@SkillDecorator
export class BasicRanged extends Skill {
	private _skillInfo = SkillDefinitions.BasicRanged;
	private animationTrack?: AnimationTrack;
	// 00. CONSTRUCT
	public OnConstruct() {
		Logger.Log(script, "BasicRanged Construct");
		Logger.Log(script, "BasicRanged Construct");
	}

	public OnConstructServer(): void {
		Logger.Log(script, "BasicRanged Server");
		Logger.Log(script, "BasicRanged Client", this._skillInfo as unknown as string);
		//this.DamageContainer = new DamageContainer(this, "Melee", 10);
		Logger.Log(script, "BasicRanged Server");
		//this.DamageContainer = new DamageContainer(this, "Melee", 10);
	}

	// 01. CONSTRUCT CLIENT
	public OnConstructClient(): void {
		const characterModel = this.Character.Instance as Model;
		const animator = characterModel.FindFirstChild("Animator", true) as Animator;
		const animation = new Instance("Animation");
		animation.Name = "BasicRanged";
		animation.AnimationId = SkillDefinitions.BasicRanged.animation;
		this.animationTrack = animator.LoadAnimation(animation);
	}

	public OnStartClient(): void {
		Logger.Log(script, "BasicRanged Start Client");
		this.playAnimation();
	}

	// MOVE START
	public OnStartServer() {
		Logger.Log(script, "Start Server", SkillDefinitions.BasicRanged as unknown as string);
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log(script, "End Server");
	}

	private playAnimation() {
		this.animationTrack?.Play();
	}
}
