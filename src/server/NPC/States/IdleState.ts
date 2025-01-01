
import { EAnimationName } from "shared/Refrences/AnimationReference";
import { NPCController } from "../NPCController";
import { IState } from "../Types/StateInterface";
import { Logger } from "shared/Utility/Logger";

export class IdleState implements IState {
	public name: string = "Idle";
	private _npcController: NPCController;


	constructor(npc: NPCController) {

		this._npcController = npc;

		return this;
	}

	onEnter(previousState: IState | undefined): void {
		// Play idle animation, reset timers, etc.
		this._npcController.animationController.playAnimation(EAnimationName.NPC_Idle);
	}

	onUpdate(dt: number): void {
		// Scan for players

		this._npcController.animationController.playAnimation(EAnimationName.NPC_Idle);
		task.wait(2);
	}

	onExit(nextState: IState): void {
		// Cleanup if necessary (e.g., stop idle animation)
		this._npcController.animationController.stopAnimation(EAnimationName.NPC_Idle);

	}
}
