import { Players, DataStoreService, HttpService } from "@rbxts/services";
import { Logger } from "../../shared/Utility/Logger";
import { EquipmentSlots } from "shared/Enums/GameEnums";
import * as IData from "../../shared/Interfaces/IData";

// Data Types
export type IPlayerData = IData.PlayerData;
export type IPlayerDataTemplate = IData.PlayerData;
export type IPlayerCache = IData.PlayerCache;

// Data Template
export const DataTemplate = IData.DataTemplate;

// Data Cache Class for use in the DataManager
export class DataCache {
	public _userId: string;
	public _playerData: IPlayerData;
	private _lastSaveTimestamp: number = 0;
	private _minSaveInterval: number = 2;
	private _dataStore: DataStore;

	constructor(userId: string, dataStore: DataStore) {
		// Set the properties
		this._userId = userId;
		this._dataStore = dataStore;

		// Attempt to load the player data from the DataStore
		this._playerData = dataStore.GetAsync(userId)[0] as IPlayerData;

		// If the player data is not found, create a new player data based on the DataTemplate
		if (this._playerData === undefined) {
			this._playerData = DataTemplate;
			this.Save();
		} else {
			Logger.Log("DM", "\n Data Loaded");
		}
	}

	// Save
	public Save(): string {
		// Save the player data to the DataStore

		const timeSinceLastSave = os.time() - this._lastSaveTimestamp;
		if (timeSinceLastSave <= this._minSaveInterval) {
			// Do not save if the last save was less than 2 seconds ago
			Logger.Log("SaveSkipped", timeSinceLastSave);
			return "Save Skipped";
		}
		const success = this._dataStore.SetAsync(this._userId, this._playerData);

		// Update the last save timestamp
		this._lastSaveTimestamp = os.time();

		return success;
	}

	// Updates the DataCache with the provided player data
	public SetDataCache(dataCache: IPlayerData) {
		this._playerData = dataCache;
		const timeSinceLastSave = os.time() - this._lastSaveTimestamp;
		if (timeSinceLastSave <= 2) {
			// Do not save if the last save was less than 2 seconds ago
			return;
		}
		if (timeSinceLastSave >= 60) {
			this.Save();
		}
	}

	public GetDataCache(): IPlayerData {
		return this._playerData;
	}

	// Saves the DataCache to the Roblox DataStore
}

export class DataManager {
	private static _instance: DataManager;
	private static DataStoreService = DataStoreService;
	private static DatastoreId = "SOULSTEEL_12_2024";
	private static GameDataStore = DataManager.DataStoreService.GetDataStore(DataManager.DatastoreId);
	private static PlayerCache: Array<DataCache> = new Array<DataCache>();
	private static AutoSaveInterval = 15;
	private static playerAddedConnection: RBXScriptConnection;

	private constructor() {
		DataManager.playerAddedConnection?.Disconnect();
		DataManager.playerAddedConnection = Players.PlayerAdded.Connect((player) => {
			DataManager.RegisterPlayer(player);
		});
	}

	public static Start(): void {
		if (this._instance === undefined) {
			this._instance = new DataManager();
		}
	}

	// Called from the Server OnPlayerAdded event
	public static RegisterPlayer(player: Player): void {
		// 01 - Get the player data from the DataStore or Cache
		const userId = tostring(player.UserId);
		const storedData = DataManager.GameDataStore.GetAsync(userId)[0] as IPlayerData;
		const dataCache = new DataCache(userId, DataManager.GameDataStore);
		this.PlayerCache.push(dataCache);
	}

	public static GetDataCache(userId: string): DataCache {
		return DataManager.PlayerCache.find((cache) => cache._userId === userId) as DataCache;
	}

	// Called from the Server OnPlayerLeaving event
	public static OnPlayerLeaving(player: Player): void {
		// 01 - Get the data cache for the player
		const userId = tostring(player.UserId);
		const dataCache = DataManager.PlayerCache.find((cache) => cache._userId === userId) as DataCache;
		dataCache.Save();
	}
}
