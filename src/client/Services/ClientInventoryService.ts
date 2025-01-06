import { EInventoryEvent, EInventorySlot } from "shared/_References/Inventory";
import { GameStorage } from "shared/Utility/GameStorage";

// Events

const eventEquipRequest = GameStorage.getEvent(EInventoryEvent.EquipRequest);
const eventUnequipRequest = GameStorage.getEvent(EInventoryEvent.UnequipRequest);
const eventEquipResponse = GameStorage.getEvent(EInventoryEvent.EquipResponse);
const eventUnequipResponse = GameStorage.getEvent(EInventoryEvent.UnequipResponse);

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
	public static SendEquipRequest(category: EInventorySlot, equipmentId: string) {
		eventEquipRequest.FireServer(category, equipmentId);
	}

	// Send Unequip Request
	public static SendUnequipRequest(category: EInventorySlot) {
		eventUnequipRequest.FireServer(category);
	}
}
