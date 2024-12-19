import { GameStorage } from "shared/Utility/GameStorage";

// Events

const eventEquipRequest = GameStorage.getEvent("INVENTORY_EquipRequest");
const eventUnequipRequest = GameStorage.getEvent("INVENTORY_UnequipRequest");
const eventEquipResponse = GameStorage.getEvent("INVENTORY_EquipResponse");
const eventUnequipResponse = GameStorage.getEvent("INVENTORY_UnequipResponse");

export class ClientInventoryService {
	private static _instance: ClientInventoryService;
	private static _connectionEquipResponse: RBXScriptConnection | undefined;
	private static _connectionUnequipResponse: RBXScriptConnection | undefined;

	private constructor() {
		// Equip Response
		ClientInventoryService._connectionEquipResponse = eventEquipResponse.OnClientEvent.Connect(
			(response: string) => {
				print("Equip Response", response);
			},
		);

		// Unequip Response
		ClientInventoryService._connectionUnequipResponse = eventUnequipResponse.OnClientEvent.Connect(
			(response: string) => {
				print("Unequip Response", response);
			},
		);
	}

	// Start
	public static Start() {
		if (ClientInventoryService._instance === undefined) {
			ClientInventoryService._instance = new ClientInventoryService();
		} else {
			print("ClientInventoryService Already Started");
		}
	}

	// Send Equip Request
	public static SendEquipRequest(category: string, equipmentId: string) {
		eventEquipRequest.FireServer(category, equipmentId);
	}

	// Send Unequip Request
	public static SendUnequipRequest(category: string) {
		eventUnequipRequest.FireServer(category);
	}
}
