import { Players, DataStoreService, HttpService } from "@rbxts/services";
import { PlayerData, DataTemplate, StatsData } from "shared/TS_Types";
import { PlayerAttributes } from "./PlayerAttributes";

const DATASTORE_NAME = "SoulSteel_TS";

export class DataService {
	private dataStore = DataStoreService.GetDataStore(DATASTORE_NAME);
	private playerDataCache = new Map<string, PlayerData>();

	constructor() {
		Players.PlayerAdded.Connect((player) => this.onPlayerAdded(player));
		Players.PlayerRemoving.Connect((player) => this.onPlayerRemoving(player));
	}

	// Player Added - Load Data
	private async onPlayerAdded(player: Player) {
		// 00. Convert player.UserId to string
		const userId: string = tostring(player.UserId);

		// 00. Call loadPlayerData with userId
		let data = await this.loadPlayerData(userId);

		// 00. If data is not defined or data.version is not equal to DataTemplate.version
		if (!data || data.version !== DataTemplate.version) {
			data = { ...DataTemplate, version: DataTemplate.version };
		}

		// 01. Set playerDataCache with userId and data
		this.playerDataCache.set(userId, data);

		// 02. Create player attributes
		if (data) {
			const JSONData = HttpService.JSONEncode(data);
			warn(`Loaded data for user ${userId}: ${JSONData}`);
			PlayerAttributes.createAttributes(player, data);
		}
	}

	// Player Removing - Save Data
	private async onPlayerRemoving(player: Player) {
		// 00. Convert player.UserId to string
		const userId: string = tostring(player.UserId);

		// 01. Call savePlayerData with userId and this.playerDataCache.get(userId)
		const data = this.playerDataCache.get(userId);

		// 02. Save player data if data is not undefined
		if (data) {
			await this.savePlayerData(userId, data);
			this.playerDataCache.delete(userId);
		}
	}

	// Load Player Data
	private async loadPlayerData(userId: string): Promise<PlayerData | undefined> {
		// 00. Try to load data for user
		try {
			// 00. Call this.dataStore.GetAsync with userId
			const stored = await this.dataStore.GetAsync(`${userId}`);
			if (stored[0]) {
				// Cast stored data to unknown first to resolve TS2352 error
				const rawData = stored as unknown;

				// Return rawData as PlayerData
				return rawData as PlayerData;
			}
		} catch (e) {
			warn(`Failed to load data for user ${userId}: ${e}`);
		}
		return undefined;
	}

	// Save Player Data
	private async savePlayerData(userId: string, data: PlayerData): Promise<void> {
		try {
			await this.dataStore.SetAsync(`${userId}`, data);
		} catch (e) {
			warn(`Failed to save data for user ${userId}: ${e}`);
		}
	}
}
