import { Character } from "@rbxts/wcs";
import { GameStorage } from "shared/Utility/GameStorage";
import { AbilityButton } from "shared/UI/AbilityButton";
import { Logger } from "shared/Utility/Logger";
import { HttpService, ReplicatedStorage } from "@rbxts/services";

export class ActionBar {
	// Private Variables
	private static _instance: ActionBar;

	private _eventEntityCreated: RemoteEvent = ReplicatedStorage.WaitForChild("Remotes").WaitForChild(
			"ENTITY_Created",
		) as RemoteEvent;
	private _connectionEntityLoaded: RBXScriptConnection | undefined;

	// Constructor
	private constructor() {
		this._connectionEntityLoaded = this._eventEntityCreated.OnClientEvent.Connect((entity: Character) => {
			Logger.Log("ActionBar", "Entity Loaded: ", entity);
		});
		return this;
	}

    // Start
	public static Start() {
		if (!this._instance) {
			this._instance = new ActionBar();
		}
		return this._instance;
	}
}
