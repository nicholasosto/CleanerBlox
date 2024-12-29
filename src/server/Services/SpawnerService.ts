// Note: Spawner Service
import { Logger } from "shared/Utility/Logger";
import { GameStorage } from "shared/Utility/GameStorage";
import { DataManager } from "../Data/DataManager";
import { NotificationManager } from "server/Notification/NotificationManager";
import { TEventSuccessResponse, InventoryReference } from "shared/SharedReference";

// Requests
const eventSpawnRequest = GameStorage.getEvent(InventoryReference.EInventoryEvent.EquipRequest);

// Responses
const eventSpawnResponse = GameStorage.getEvent(InventoryReference.EInventoryEvent.EquipResponse);

export class SpawnerService {
	private static _instance: SpawnerService;
	private static spawnRequestConnection: RBXScriptConnection;

	private constructor() {
		SpawnerService.ClearConnections();

		SpawnerService.spawnRequestConnection = eventSpawnRequest.OnServerEvent.Connect(
			(player: Player, ...args: Array<unknown>) => {
				print("Getting player data", args);
				const response = SpawnerService._handleSpawnRequest(player);
				eventSpawnResponse.FireClient(player, response);
				NotificationManager.Notify(player, response);
			},
		);
	}

	private static _handleSpawnRequest(player: Player): TEventSuccessResponse {
		const spawnResponse = {
			success: false,
			message: "Failed to spawn",
		};

		return spawnResponse;
	}

	public static Start() {
		if (this._instance === undefined) {
			this._instance = new SpawnerService();
		}
	}

	private static ClearConnections() {
		SpawnerService.spawnRequestConnection?.Disconnect();
	}
}
