// Roblox Services
import { RunService } from "@rbxts/services";
import * as Anim from "@rbxts/animation";
import { EAnimationName } from "shared/Refrences/AnimationReference";
// Plugin Services
import { Character } from "@rbxts/wcs";

// Controllers
import { AnimationController } from "./Controllers/AnimationController";
import { NPCStateMachine } from "./Controllers/NPCStateMachine";
import { NPCConfig } from "./NPCConfig";

// States
import { IState } from "./Types/StateInterface";
import { IdleState } from "./States/IdleState";
import { PatrolState } from "./States/PatrolState";
import { Logger } from "shared/Utility/Logger";
import { AttackState } from "./States/AttackState";

export class NPCController {
	private stateMachine: NPCStateMachine;
	private animationController: AnimationController;
	public rigModel: Model;
	public wcsCharacter: Character;
	public target?: Model;
	public startingPosition: Vector3Value;
	private _connectionHeartbeat: RBXScriptConnection | undefined;

	// NPC States

	private _idleState: IdleState;
	private _patrolState: PatrolState;
	private _attackState: IState;

	constructor(character: Model) {
		Logger.NPCLog("Creating NPCController");
		if (character === undefined) {
			throw "Character is undefined";
		}
		// Get the model instance and humanoid
		this.rigModel = character;
		this.startingPosition = character.WaitForChild("StartingPos") as Vector3Value;
		this.startingPosition.Value = character.PrimaryPart?.Position || new Vector3(0, 0, 0);
		const animator = character.FindFirstChild("Animator", true) as Animator;
		const humanoid = character.FindFirstChildOfClass("Humanoid");
		const PrimaryPart = character.PrimaryPart as Part;

		PrimaryPart.Anchored = false;
		this.stateMachine = new NPCStateMachine(character);

		if (this.stateMachine === undefined) {
			throw "StateMachine is undefined";
		};

		this._attackState = new AttackState(this.stateMachine);
		this._idleState = new IdleState(this.stateMachine);
		this._patrolState = new PatrolState(this.stateMachine);

		// Set initial state
		this.setState(this._patrolState);

		this.wcsCharacter = Character.GetCharacterFromInstance(character) as Character;

		const Bundle = Anim.Animation.createAnimations({
			Melee: EAnimationName.SKILL_BasicMeleeAttack,
			Idle: EAnimationName.FLIGHT_Up,
		});

		Anim.Animation.loadAnimator(animator, Bundle).Idle.Play();
		if (!humanoid) throw `No humanoid in NPC character: ${character.Name}`;

		this.animationController = new AnimationController(humanoid);

		// Create initial states
		//const idleState = new IdleState(this);
		//this.stateMachine = new StateMachine(idleState);

		// Additional initialization like event connections
		this._connectHeartbeat();
	}

	// Connect to heartbeat
	public _connectHeartbeat(): void {
		Logger.NPCLog("00 - Init - Connecting Heartbeat");
		this._connectionHeartbeat = RunService.Heartbeat.Connect((dt: number) => {
			this.update(dt);
		});
	}

	// Update loop
	public update(dt: number): void {
		Logger.NPCLog("INF - NPCController update");
		this.stateMachine.update(dt);
	}

	// Method to change state
	public setState(newState: IState): void {
		Logger.NPCLog("INF - State Change:  " + newState?.name);
		this.stateMachine.changeState(newState);
	}

	// Optionally methods to get current state, handle damage, etc.
}
