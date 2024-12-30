import { EAnimationName } from "shared/Refrences/AnimationReference";
import { NPCController } from "../NPCController";
import { Logger } from "shared/Utility/Logger";
import { IState } from "../Types/StateInterface";

export class AttackState implements IState {
	public name: string = "Attack";
	private _npcController: NPCController;

	constructor(npc: NPCController) {
		Logger.NPCLog("Creating: " + this.name);
		this._npcController = npc;

		return this;
	}

	onEnter(previousState: IState | undefined): void {
		// Play idle animation, reset timers, etc.
		Logger.NPCLog("Previous: " + previousState?.name + " new: " + this.name);
		this._npcController.animationController.playAnimation(EAnimationName.NPC_Attack);
	}

	onUpdate(dt: number): void {
		// Scan for players
		Logger.NPCLog(this.name + " - Update");
		this._npcController.animationController.playAnimation(EAnimationName.NPC_Attack);
		task.wait(1);
	}

	onExit(nextState: IState): void {
		// Cleanup if necessary (e.g., stop idle animation)
		this._npcController.animationController.stopAnimation(EAnimationName.NPC_Attack);
		Logger.NPCLog(this.name + " - Exit to " + nextState.name);
	}
}
