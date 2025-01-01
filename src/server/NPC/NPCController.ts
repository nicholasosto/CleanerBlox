// Roblox Services
import { RunService } from "@rbxts/services";

// Custom Services
import { CharacterUtility } from "shared/Utility/CharacterUtility";

// Factories
import { HumanoidDescriptionFactory, EHumanoidDescription } from "shared/Refrences/Humanoids";

// Plugin Services
import { Character } from "@rbxts/wcs";

// Controllers
import { AnimationController } from "./Controllers/AnimationController";
// States
import { IState } from "./Types/StateInterface";
import { IdleState } from "./States/IdleState";
import { PatrolState } from "./States/PatrolState";
import { Logger } from "shared/Utility/Logger";
import { AttackState } from "./States/AttackState";

export class NPCController {
	// Controller
	public animationController: AnimationController;

	// Initial States
	public startingPosition: Vector3Value;
	private _currentState: IState | undefined;

	// Update loop
	private _lastUpdate: number = 0;
	private _timeSinceLastUpdate: number = 0;
	private _cycleTime: number = 1;

	// Rig and WCS Character
	public rigModel: Model;
	public wcsCharacter: Character;

	// NPC Target
	public target?: Model;

	// Heartbeat connection for State changes
	private _connectionHeartbeat: RBXScriptConnection | undefined;

	// NPC States
	private _idleState: IdleState = new IdleState(this);
	private _patrolState: PatrolState = new PatrolState(this);
	private _attackState: AttackState = new AttackState(this);

	constructor(character: Model) {
		// Get the model instance and humanoid
		this.rigModel = character;
		this.wcsCharacter = Character.GetCharacterFromInstance(character) as Character;
		this.startingPosition = character.WaitForChild("StartingPos") as Vector3Value;
		this.startingPosition.Value = character.PrimaryPart?.Position || new Vector3(0, 0, 0);

		// Get the animator and humanoid
		const animator = character.FindFirstChild("Animator", true) as Animator;
		const humanoid = character.FindFirstChildOfClass("Humanoid");
		if (humanoid === undefined) {
			throw `No humanoid in NPC character: ${character.Name}`;
		}

		//START TEST HUMANOID DESCRIPTION

		const hdFactory = HumanoidDescriptionFactory.getInstance();
		const hd = HumanoidDescriptionFactory.ApplyHumanoidDescription(humanoid, EHumanoidDescription.RobotBase);

		//END TEST

		// Create the animation controller
		this.animationController = new AnimationController(humanoid);

		// Get the primary part and unanchor
		const PrimaryPart = character.PrimaryPart as Part;
		PrimaryPart.Anchored = false;

		// Set initial state
		this.setState(this._patrolState);

		// Connect to heartbeat
		this._connectHeartbeat();
	}

	// Connect to heartbeat
	private _connectHeartbeat(): void {

		// Connect to heartbeat: Runs update once per cycle time this._cycleTime (in seconds)
		this._connectionHeartbeat = RunService.Heartbeat.Connect((dt: number) => {

			// Calculate time since last update
			this._timeSinceLastUpdate += dt;

			// Update loop
			if (this._timeSinceLastUpdate >= this._cycleTime) {
				// reset time since last update
				this._lastUpdate = tick(); // might not be necessary
				this._timeSinceLastUpdate = 0;

				// Update the NPC
				this.update(dt);
			}
		});
	}

	// Update loop
	public update(dt: number): void {
		this._currentState?.onUpdate(dt);
	}

	// Method to change state
	public setState(newState: IState): void {
		this._currentState?.onExit(newState);
		this._currentState = newState;
		this._currentState.onEnter(this._currentState);
	}

	// Optionally methods to get current state, handle damage, etc.
}
