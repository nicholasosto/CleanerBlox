import { Logger } from "shared/Utility/Logger";
import { IState } from "../Types/StateInterface";
import { StateName } from "../Types/StateName";

export class AttackState implements IState {
	onEnter(previousState: IState | undefined): void {
		Logger.NPCLog("Entering Attack state");
		// Play idle animation, reset timers, etc.
	}

	onUpdate(dt: number): void {
		// Check conditions to transition out of Idle
		// For example: if a player is detected, we might transition to Attack
		// If we have a waypoint set, we move to Walking
	}

	onExit(nextState: IState): void {
		// Cleanup if necessary (e.g., stop idle animation)
	}

	getName(): string {
		return StateName.Idle;
	}
}
