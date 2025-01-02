// Note: Inventory Service
import { Logger } from "shared/Utility/Logger";
import { GameStorage } from "shared/Utility/GameStorage";
import { DataManager } from "../Data/DataManager";
//import { EquipmentSlots } from "shared/Enums/GameEnums";
import { NotificationManager } from "server/Notification/NotificationManager";
import { TEventSuccessResponse, InventoryReference } from "shared/SharedReference";

// Events

// Requests
const eventEquipRequest = GameStorage.getEvent(InventoryReference.EInventoryEvent.EquipRequest);
const eventUnequipRequest = GameStorage.getEvent(InventoryReference.EInventoryEvent.UnequipRequest);
const eventUnlockRequest = GameStorage.getEvent(InventoryReference.EInventoryEvent.UnlockRequest);
// Responses
const eventEquipResponse = GameStorage.getEvent(InventoryReference.EInventoryEvent.EquipResponse);
const eventUnequipResponse = GameStorage.getEvent(InventoryReference.EInventoryEvent.UnequipResponse);
const eventUnlockResponse = GameStorage.getEvent(InventoryReference.EInventoryEvent.UnlockResponse);

// Equipment Manager
export class InventoryService {
	// Static Instance
	private static _instance: InventoryService;

	// Event Listener Connections
	private static _connectionInventroyEquip: RBXScriptConnection | undefined;
	private static _connectionInventoryUnequip: RBXScriptConnection | undefined;
	private static _connectionInventoryUnlock: RBXScriptConnection | undefined;

	// Constructor
	private constructor() {
		InventoryService.ClearConnections();
		// Equip Request Listener
		InventoryService._connectionInventroyEquip = eventEquipRequest.OnServerEvent.Connect(
			(player: Player, ...args: Array<unknown>) => {
				print("Getting player data", args);

				// Get Category and Equipment Id
				const category = args[0] as InventoryReference.EInventorySlot;
				const equipmentId = args[1] as string;

				const response = InventoryService._handleEquipRequest(player, category, equipmentId);

				// Fire Client Response
				eventEquipResponse.FireClient(player, response);
				NotificationManager.Notify(player, response);
			},
		);

		// Unequip Request Listener
		InventoryService._connectionInventoryUnequip = eventUnequipRequest.OnServerEvent.Connect(
			(player: Player, ...args: Array<unknown>) => {
				print("Unequip Item", args);

				// Get Slot
				const equipmentSlot = args[0] as InventoryReference.EInventorySlot;

				// Unequip Item
				const response = InventoryService._handleUnequipRequest(player, equipmentSlot);

				// Fire Client Response
				eventUnequipResponse.FireClient(player, response);
			},
		);
	}

	// Start
	public static Start() {
		if (InventoryService._instance === undefined) {
			InventoryService._instance = new InventoryService();
		} else {
			Logger.Log(script,"InventoryService", "Already started");
		}
	}

	// Equip: Handler
	// eslint-disable-next-line prettier/prettier
	private static _handleEquipRequest(player: Player, category: InventoryReference.EInventorySlot, equipmentId: string): TEventSuccessResponse {
		// Validate Equipment
		let response = InventoryService.ValidatePlayerInventory(player, category, equipmentId);
		if (!response.success) {
			return response;
		}

		// Equip Item
		response = InventoryService.EquipCharacterModel(player.Character as Model, category, equipmentId);

		return response;
	}

	// Equip: Function
	// eslint-disable-next-line prettier/prettier
	public static EquipCharacterModel(characterRig: Model, category: InventoryReference.EInventorySlot, equipmentId: string): TEventSuccessResponse {
		// Get Response Ready
		const response: TEventSuccessResponse = {
			success: true,
			message: "Successfully Equipped: " + equipmentId,
		};

		// Clone Equipment
		const equipmentAccessory = GameStorage.cloneAccessory(equipmentId);
		const handle: BasePart | undefined = equipmentAccessory?.FindFirstChild("Handle") as BasePart;
		if (handle === undefined) {
			response.message = "Handle not found";
			response.success = false;
			return response;
		}

		const attachment: Attachment | undefined = handle?.FindFirstChildWhichIsA("Attachment") as Attachment;

		if (attachment === undefined) {
			response.message = "Attachment not found";
			response.success = false;
			return response;
		}

		attachment.Name = category;

		// Check if Clone Accessory Exists
		if (equipmentAccessory === undefined) {
			response.message = "Equipment is undefined";
			response.success = false;
			return response;
		}

		// Equip the Character
		equipmentAccessory.Parent = characterRig;
		return response;
	}

	// Handle Unequip Request
	// eslint-disable-next-line prettier/prettier
	private static _handleUnequipRequest(player: Player, equipmentSlot: InventoryReference.EInventorySlot): TEventSuccessResponse {
		// Get the Response Ready
		const eventResponse: TEventSuccessResponse = {
			success: true,
			message: "Removed Inventory Item: " + equipmentSlot,
		};
		// Unequip Item
		const character = player.Character as Model;
		if (character === undefined) {
			eventResponse.message = "Character not found";
			eventResponse.success = false;
			return eventResponse;
		}

		const response = InventoryService.UnequipCharacterModel(character, equipmentSlot);
		return response;
	}

	// Unequip Player
	// eslint-disable-next-line prettier/prettier
	public static UnequipCharacterModel(characterRig: Model, equipmentSlot: InventoryReference.EInventorySlot): TEventSuccessResponse {
		// Get the Response Ready
		const eventResponse: TEventSuccessResponse = {
			success: true,
			message: "Removed Inventory Item: " + equipmentSlot,
		};

		const accessories = characterRig.GetChildren().filter((child) => child.IsA("Accessory"));
		accessories.forEach((accessory) => {
			print("Accessory", accessory.Name);
		});

		const accessory = accessories.filter((child) => child.FindFirstChild(equipmentSlot, true) !== undefined)[0];

		if (accessory === undefined) {
			eventResponse.message = "Accessory not found";
			eventResponse.success = false;
			return eventResponse;
		}

		accessory.Destroy();

		return eventResponse;
	}

	// eslint-disable-next-line prettier/prettier
	private static ValidatePlayerInventory(player: Player, equipmentCategory: InventoryReference.EInventorySlot, equipmentId: string): TEventSuccessResponse {
		// Get the Player Data
		const userId = tostring(player.UserId);
		const playerData = DataManager.GetDataCache(userId)._playerData;

		const InventorySlot = InventoryReference.EInventorySlot;

		// Map the Inventory to the Equipment Category
		const inventoryMap = new Map<InventoryReference.EInventorySlot, Array<string>>();
		inventoryMap.set(InventorySlot.Helmet, playerData.HelmetInventory);
		inventoryMap.set(InventorySlot.LeftHand, playerData.WeaponInventory);
		inventoryMap.set(InventorySlot.RightHand, playerData.WeaponInventory);
		inventoryMap.set(InventorySlot.Body, playerData.ArmorInventory);
		inventoryMap.set(InventorySlot.Familiar, playerData.FamiliarInventory);
		inventoryMap.set(InventorySlot.Accessory, playerData.AccessoryInventory);

		// Set the Inventory
		const inventory = inventoryMap.get(equipmentCategory);

		// Get the Response Ready
		const response: TEventSuccessResponse = {
			success: false,
			message: "Failed",
		};

		// Invalid Category Check
		if (inventory === undefined) {
			response.message = "Invalid Equipment Category";
			return response;
		}

		// Inventory Check
		if (inventory.find((item) => item === equipmentId) === undefined) {
			response.message = "Item not found in inventory";
			return response;
		}

		// Success
		response.success = true;

		return response;
	}

	// Clear Connections
	public static ClearConnections() {
		InventoryService._connectionInventroyEquip?.Disconnect();
		InventoryService._connectionInventoryUnequip?.Disconnect();
	}
}
