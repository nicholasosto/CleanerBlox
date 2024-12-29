import { IState } from "../Types/StateInterface";
import { Logger } from "shared/Utility/Logger";
import { NPCStateMachine } from "../Controllers/NPCStateMachine";

export class IdleState implements IState {
	private _stateMachine: NPCStateMachine;
	public name: string = "Idle";

	constructor(stateMachine: NPCStateMachine) {
		Logger.NPCLog("Creating Idle State");
		this._stateMachine = stateMachine;
		return this;
	}

	onEnter(previousState: IState | undefined): void {
		// Play idle animation, reset timers, etc.
		Logger.NPCLog("-- Enter Idle State");
		this._stateMachine.highlight.Enabled = true;
		this._stateMachine.highlight.FillColor = Color3.fromRGB(0, 0, 255);
		this._stateMachine.highlight.OutlineColor = Color3.fromRGB(0, 0, 255);

		task.wait(1);
	}

	onUpdate(dt: number): void {
		// Scan for players
		Logger.NPCLog("Idle - Scanning for players");
		task.wait(2);
		this._stateMachine.changeState(this._stateMachine._states.get("Patrol") as IState);
	}

	onExit(nextState: IState): void {
		// Cleanup if necessary (e.g., stop idle animation)
		Logger.NPCLog("-- Exit Idle State");
	}

	getName(): string {
		return "Idle";
	}
}
