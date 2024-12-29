import { IState } from "../Types/StateInterface";
import { Logger } from "shared/Utility/Logger";

export class StateMachine {
	private currentState?: IState;

	constructor(initialState: IState) {
		Logger.NPCLog("Creating StateMachine");
		this.currentState = initialState;
		this.currentState.onEnter(undefined);
	}

	public changeState(newState: IState): void {
		Logger.NPCLog(`Changing state to ${newState.getName()}`);
		if (this.currentState !== newState) {
			const previousState = this.currentState;
			if (previousState) {
				previousState.onExit(newState);
			}
			this.currentState = newState;
			this.currentState.onEnter(previousState);
		}
	}

	public update(dt: number): void {
		Logger.NPCLog("StateMachine update");
		if (this.currentState) {
			this.currentState.onUpdate(dt);
		}
	}

	public getCurrentStateName(): string | undefined {
		Logger.NPCLog("Getting current state name");
		return this.currentState?.getName();
	}
}
