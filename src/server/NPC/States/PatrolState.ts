import { Players } from "@rbxts/services";
import { IState } from "../Types/StateInterface";
import { NPCStateMachine } from "../Controllers/NPCStateMachine";
import { CharacterUtility } from "shared/Utility/CharacterUtility";
import { Logger } from "shared/Utility/Logger";

export class PatrolState implements IState {
	private _stateMachine: NPCStateMachine;
	public name: string = "Patrol";
	private _lastUpdate: number = 0;
	private _startingPosition: Vector3;


	constructor(stateMachine: NPCStateMachine) {
		Logger.NPCLog("Creating Patrol State");
		const model = stateMachine.modelInstance;
		const VectorValueObject = model.WaitForChild("StartingPos") as Vector3Value;
		this._startingPosition = VectorValueObject.Value as Vector3;
		this._stateMachine = stateMachine;
		return this;
	}

	onEnter(previousState: IState | undefined): void {
		// Play idle animation, reset timers, etc.
		Logger.NPCLog("-- Enter Patrol State");

		this._stateMachine.highlight.Enabled = true;
		this._stateMachine.highlight.FillColor = Color3.fromRGB(0, 255, 0);
		this._stateMachine.highlight.OutlineColor = Color3.fromRGB(0, 255, 0);
	}

	onUpdate(dt: number): void {
		const humanoid = this._stateMachine.humanoidInstance;
		const model = this._stateMachine.modelInstance;
		const now = tick();
		const delta = now - this._lastUpdate;

		if (humanoid.GetMoveVelocity().Magnitude < 0.1 || delta > 5) {
			const closestCharacter = CharacterUtility.getClosestCharacterFrom(model, 30);
			const characterInstance = closestCharacter?.Instance as Model;

			if (characterInstance === undefined) {
				return;
			}

			const characterPosition = characterInstance.GetPivot().Position;
			humanoid.MoveTo(characterPosition);
			
			task.wait(1);
			const distance = (model.GetPivot().Position.sub(characterPosition)).Magnitude;
			if (distance < 30) {
				this._stateMachine.changeState(this._stateMachine._states.get("Attack") as IState);
			}

			if (this._startingPosition.sub(model.GetPivot().Position).Magnitude > 30) {
				humanoid.MoveTo(this._startingPosition);
			}
		}
	}

	onExit(nextState: IState): void {
		// Cleanup if necessary (e.g., stop idle animation)
		Logger.NPCLog("-- Exit Patrol State");
		this._stateMachine.highlight.Enabled = false;
	}
}
