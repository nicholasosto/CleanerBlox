import { Skill, SkillDecorator } from "@rbxts/wcs";
import { SkillDefinitions } from "shared/_References/Character/Skills";
import { Logger } from "shared/Utility/Logger";

@SkillDecorator
export class BasicMelee extends Skill {
	// 00. CONSTRUCT
	private animationTrack?: AnimationTrack;

	public OnConstruct() {
		Logger.Log(script, "- Construct");
		Logger.Log(script, SkillDefinitions.BasicMelee as unknown as string);
	}

	public OnConstructServer(): void {
		Logger.Log(script, " - Server");
		//this.DamageContainer = new DamageContainer(this, "Melee", 10);
	}

	// 01. CONSTRUCT CLIENT
	public OnConstructClient(): void {
		Logger.Log(script, "- Client");
		const animator: Animator = this.Character.Instance?.FindFirstChild("Animator", true) as Animator;

		if (animator === undefined) {
			Logger.Log(script, "Animator not found");
			return;
		}
		const animation = new Instance("Animation");
		animation.Name = "BasicMelee";
		animation.AnimationId = SkillDefinitions.BasicMelee.animation;

		this.animationTrack = animator.LoadAnimation(animation);



	}

	// MOVE START
	public OnStartServer() {
		Logger.Log(script, "Start Server");
		this.animationTrack?.Play();
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log(script, "End Server");
	}
}
