import { RunService } from "@rbxts/services";
import { Logger } from "shared/Utility/Logger";

export class CommunicationGod {
	public static _god: CommunicationGod;

	public static ServerSignals: Map<string, RemoteEvent> = new Map<string, RemoteEvent>();

	private constructor() {
		CommunicationGod._registerSignal("TestSignal");
		CommunicationGod._registerSignal("Entity_Created");
		CommunicationGod._registerSignal("Entity_Destroyed");
		CommunicationGod._registerSignal("Spawn_Request");
		// Equipment Signals
		CommunicationGod._registerSignal("Equipment_Request");
		CommunicationGod._registerSignal("Equipment_Response");
		// Player Signals
		CommunicationGod._registerSignal("Player_LevelUp");
		CommunicationGod._registerSignal("Player_SetTarget");
		// Movement Signals
		CommunicationGod._registerSignal("Movement_DashRequest");
		CommunicationGod._registerSignal("Movement_DashResponse");
		CommunicationGod._registerSignal("Movement_FlightRequest");
		CommunicationGod._registerSignal("Movement_FlightResponse");
		// Notification Signals
		CommunicationGod._registerSignal("Notify_Player");
		CommunicationGod._registerSignal("Notify_All");
		// AI Signals
		CommunicationGod._registerSignal("AI_Request");
		CommunicationGod._registerSignal("AI_Response");
		return this;
	}

	public static Summon(): CommunicationGod {
		if (this._god === undefined) {
			this._god = new CommunicationGod();
		}
		return this._god;
	}

	public static _registerSignal(eventName: string): void {
		if (this.ServerSignals.has(eventName)) {
			//Logger.Log(script,"CommunicationGod", "Signal already registered: ", eventName);
			return;
		}
		const remoteEvent = new Instance("RemoteEvent", game.GetService("ReplicatedStorage"));
		remoteEvent.Name = eventName;

		//Logger.Log(script,"CommunicationGod", "Signal registered: ", eventName);
		CommunicationGod.ServerSignals.set(eventName, remoteEvent);
	}

	public static getSignals(): Map<string, RemoteEvent> {
		return this.ServerSignals;
	}
}
