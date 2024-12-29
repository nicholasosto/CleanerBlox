// Roblox Services
import { RunService } from "@rbxts/services";
import * as Anim from "@rbxts/animation";
import { EAnimationName } from "shared/Refrences/AnimationReference";
// Plugin Services
import { Character } from "@rbxts/wcs";

// Controllers
import { AnimationController } from "./Controllers/AnimationController";
import { StateMachine } from "./Controllers/StateMachine";

// States
import { IState } from "./Types/StateInterface";
import { IdleState } from "./States/IdleState";
import { PatrolState } from "./States/PatrolState";
import { Logger } from "shared/Utility/Logger";

export class NPCController {
	private stateMachine: StateMachine;
	private animationController: AnimationController;
	public rigModel: Model;
	public wcsCharacter: Character;
	private _connectionHeartbeat: RBXScriptConnection | undefined;

	constructor(character: Model) {
		Logger.NPCLog("Creating NPCController");
		// Get the model instance and humanoid
		this.rigModel = character;
		const animator = character.FindFirstChild("Animator", true) as Animator;
		const humanoid = character.FindFirstChildOfClass("Humanoid");
		this.wcsCharacter = Character.GetCharacterFromInstance(character) as Character;

		const Bundle = Anim.Animation.createAnimations({
			Melee: EAnimationName.SKILL_BasicMeleeAttack,
			Idle: EAnimationName.FLIGHT_Up,
		});


		Anim.Animation.loadAnimator(animator, Bundle).Idle.Play();
		if (!humanoid) throw `No humanoid in NPC character: ${character.Name}`;

		this.animationController = new AnimationController(humanoid);

		// Create initial states
		const idleState = new IdleState(this);
		this.stateMachine = new StateMachine(idleState);

		// Additional initialization like event connections
		this._connectHeartbeat();
	}

	public _connectHeartbeat(): RBXScriptConnection {
		Logger.NPCLog("Connecting Heartbeat");
		return RunService.Heartbeat.Connect((dt) => this.update(dt));
	}

	public update(dt: number): void {
		Logger.NPCLog("NPCController update");
		this.stateMachine.update(dt);
	}

	public setState(newState: IState): void {
		Logger.NPCLog("Setting new state");
		this.stateMachine.changeState(newState);
	}

	// Optionally methods to get current state, handle damage, etc.
}
