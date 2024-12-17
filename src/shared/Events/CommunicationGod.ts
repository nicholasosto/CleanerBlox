
import { RunService } from "@rbxts/services";


export class CommunicationGod {
	public static _god: CommunicationGod;

	public static ServerSignals: Map<string, RemoteEvent> = new Map<string, RemoteEvent>();

	private constructor() {
		CommunicationGod._registerSignal("TestSignal");
		CommunicationGod._registerSignal("TestSignalA");
		CommunicationGod._registerSignal("TestSignalB");
		return this;
	}

	public static Summon(): CommunicationGod {

		if (this._god === undefined ) {
			this._god = new CommunicationGod();
		}
		return this._god;
	}

	public static _registerSignal(eventName: string): void {
		if (this.ServerSignals.has(eventName)) {
			warn("Signal already exists: ", eventName);
			return;
		}
		const remoteEvent = new Instance("RemoteEvent", game.GetService("ReplicatedStorage"));
		remoteEvent.Name = eventName;

		if (RunService.IsServer()) {
			remoteEvent.OnServerEvent.Connect((player) => {
				warn("Server Event: ", player, eventName, " Args: ");
			});
		}else {
			remoteEvent.OnClientEvent.Connect(() => {
				warn("Client Event: " + eventName + " Args: ");
			});
		}
		
		warn("Signal Registered: ", eventName);
		CommunicationGod.ServerSignals.set(eventName, remoteEvent);
	}

	private static getSignals(): Map<string, RemoteEvent> {
		return this.ServerSignals;
	}
}
