import { Logger } from "shared/Utility/Logger";
import { IState } from "../Types/StateInterface";
import { NPCStateMachine } from "../Controllers/NPCStateMachine";

export class AttackState implements IState {
	private _stateMachine: NPCStateMachine;

	public name: string = "Attack";

	constructor(stateMachine: NPCStateMachine) {
		Logger.NPCLog("Creating Attack State");

		this._stateMachine = stateMachine;
		return this;
	}

	onEnter(previousState: IState | undefined): void {
		// Play idle animation, reset timers, etc.
		Logger.NPCLog("-- Enter Attack State");
		this._stateMachine.highlight.Enabled = true;
		this._stateMachine.highlight.FillColor = Color3.fromRGB(255, 0, 0);
		this._stateMachine.highlight.OutlineColor = Color3.fromRGB(255, 0, 0);
	}

	onUpdate(dt: number): void {
		// Scan for players
		Logger.NPCLog("Attack - Scanning for players");
		task.wait(1);
		this._stateMachine.changeState(this._stateMachine._states.get("Idle") as IState);
	}

	onExit(nextState: IState): void {
		// Cleanup if necessary (e.g., stop idle animation)
		Logger.NPCLog("-- Exit Attack State");
	}

	getName(): string {
		return "Attack";
	}
}
