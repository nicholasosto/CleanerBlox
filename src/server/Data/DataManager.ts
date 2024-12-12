import { DataStoreService, HttpService } from "@rbxts/services";
import { EquipmentManager } from "./EquipmentManager";
import { SkillsManager } from "./SkillsManager";
import { Logger } from "../../shared/Utility/Logger";
import * as IData from "../../shared/Interfaces/IData";

// Data Types
export type IPlayerData = IData.PlayerData;
export type ICharacterClassData = IData.CharacterClassData;
export type IStatsData = IData.StatsData;
export type ISkillsData = IData.SkillsData;
export type IEquipmentData = IData.EquipmentData;
export type IPlayerDataTemplate = IData.PlayerData;
export type IPlayerCache = IData.PlayerCache;

// Data Template
export const DataTemplate = IData.DataTemplate;

// Data Cache Class for use in the DataManager
export class DataCache {
	public _userId: string;
	public _playerData: IPlayerData;
	private _lastSaveTimestamp: number = 0;
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
			Logger.Log("DataManager(DataCache)", "DataCache loaded from DataStore:", this._playerData.Level);
		}
	}

	// Save
	public Save(): string {
		// Save the player data to the DataStore
		const success = this._dataStore.SetAsync(this._userId, this._playerData);

		// Update the last save timestamp
		this._lastSaveTimestamp = os.time();

		// Return the success message
		Logger.Log("PlayerData", "DataSaved", HttpService.JSONEncode(this._playerData));
		return success;
	}

	// Updates the DataCache with the provided player data
	public SetDataCache(dataCache: IPlayerData) {
		this._playerData = dataCache;
		const timeSinceLastSave = os.time() - this._lastSaveTimestamp;
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
	private constructor() {}

	private static DataStoreService = DataStoreService;
	private static DatastoreId = "SOULSTEEL_12_2024";
	private static GameDataStore = DataManager.DataStoreService.GetDataStore(DataManager.DatastoreId);
	private static PlayerCache: Array<DataCache> = new Array<DataCache>();
	private static AutoSaveInterval = 15;

	// Called from the Server OnPlayerAdded event
	public static RegisterPlayer(player: Player): void {
		// 01 - Get the player data from the DataStore or Cache
		const userId = tostring(player.UserId);
		const storedData = DataManager.GameDataStore.GetAsync(userId)[0] as IPlayerData;
		const dataCache = new DataCache(userId, DataManager.GameDataStore);
		const skillSlotManager = new SkillsManager(dataCache);
		const equipmentManager = new EquipmentManager(dataCache);
		const inventoryManager = new InventoryManager(dataCache);

		// Manager TESTS
		skillSlotManager.SetSkillSlot(5, "StunXXX");
		equipmentManager.SetEquipmentSlot("Weapon", "Sword");
		inventoryManager.AddToInventory(IData.InventoryTypeKeys.SkillInventory, "Stun");
		this.PlayerCache.push(dataCache);
	}

	// Called from the Server OnPlayerLeaving event
	public static OnPlayerLeaving(player: Player): void {
		// 01 - Get the data cache for the player
		const userId = tostring(player.UserId);
		const dataCache = DataManager.PlayerCache.find((cache) => cache._userId === userId) as DataCache;
		dataCache.Save();
		print(dataCache);
	}

	// On Respawn
	public static OnCharacterSpawn(player: Player): void {
		// 01 - Get the data cache for the player
		const userId = tostring(player.UserId);
		const dataCache = DataManager.PlayerCache.find((cache) => cache._userId === userId) as DataCache;
		// 02 - Update the player data
		dataCache.Save();
	}
}

// Inventory Manager
export class InventoryManager {
	private _dataCache: DataCache;
	constructor(dataCache: DataCache) {
		this._dataCache = dataCache;
	}

	public AddToInventory(inventoryType: IData.InventoryTypeKeys, itemId: string) {
		const playersInventory = this._dataCache._playerData[inventoryType] as string[];
		playersInventory.push(itemId);
		this._dataCache._playerData[inventoryType] = playersInventory;
		this._dataCache.Save();
	}

	public RemoveFromInventory(inventoryType: IData.InventoryTypeKeys, itemId: string) {
		const itemIndex = this._dataCache._playerData[inventoryType].indexOf(itemId);
		if (itemIndex > -1) {
			this._dataCache._playerData[inventoryType][itemIndex] = "";
			Logger.Log("InventoryManager", "Item Removed", itemId);
		}
		this._dataCache.Save();
	}

	public GetInventory(inventoryType: IData.InventoryTypeKeys): Array<string> {
		return this._dataCache._playerData[inventoryType];
	}
}
