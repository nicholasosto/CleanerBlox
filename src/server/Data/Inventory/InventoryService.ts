import { Logger } from "shared/Utility/Logger";
import { GameStorage } from "shared/Utility/GameStorage";
import { DataManager } from "../DataManager";
import { EquipmentSlots } from "shared/Enums/GameEnums";

// Events
const eventEquipRequest = GameStorage.getEvent("INVENTORY_EquipRequest");
const eventUnequipRequest = GameStorage.getEvent("INVENTORY_UnequipRequest");
const eventEquipResponse = GameStorage.getEvent("INVENTORY_EquipResponse");
const eventUnequipResponse = GameStorage.getEvent("INVENTORY_UnequipResponse");

// Equipment Manager
export class InventoryService {
	private static _instance: InventoryService;
	private static _connectionInventroyEquip: RBXScriptConnection | undefined;
	private static _connectionInventoryUnequip: RBXScriptConnection | undefined;

	private constructor() {
		InventoryService.ClearConnections();
		// Equip Request Listener
		InventoryService._connectionInventroyEquip = eventEquipRequest.OnServerEvent.Connect(
			(player: Player, ...args: Array<unknown>) => {
				print("Getting player data", args);

				// Get Category and Equipment Id
				const category = args[0] as EquipmentSlots;
				const equipmentId = args[1] as string;

				// Equip Item
				const success = InventoryService.EquipPlayer(player, category, equipmentId);

				// Fire Client Response
				eventEquipResponse.FireClient(player, success ? "Success" : "Failed");
			},
		);

		// Unequip Request Listener
		InventoryService._connectionInventoryUnequip = eventUnequipRequest.OnServerEvent.Connect(
			(player: Player, ...args: Array<unknown>) => {
				print("Unequip Item", args);

				// Get Slot
				const equipmentSlot = args[0] as EquipmentSlots;

				// Unequip Item
				const success = InventoryService.UnequipPlayer(player, equipmentSlot);

				// Fire Client Response
				eventUnequipResponse.FireClient(player, success ? "Success" : "Failed");
			},
		);
	}

	// Start
	public static Start() {
		if (InventoryService._instance === undefined) {
			InventoryService._instance = new InventoryService();
		} else {
			Logger.Log("InventoryService", "Already started");
		}
	}

	public static EquipPlayer(player: Player, category: EquipmentSlots, equipmentId: string): boolean {
		if (InventoryService.ValidateEquipment(player, category, equipmentId)) {
			const equipment = GameStorage.cloneAccessory(equipmentId);
			if(equipment === undefined) {
				print("Equipment is undefined");
				return false;
			}
			equipment.Parent = player.Character as Model;
			return true;
		} else {
			print("Equipment is invalid");
			return false;
		}
	}
	// Unequip Player
	public static UnequipPlayer(player: Player, equipmentSlot: EquipmentSlots): boolean {
		print(player.Name, "  Unequip Item: ", equipmentSlot);
		return true;
	}

	private static ValidateEquipment(player: Player, equipmentCategory: EquipmentSlots, equipmentId: string): boolean {

		// Get the Player Data
		const userId = tostring(player.UserId);
		const playerData = DataManager.GetDataCache(userId)._playerData;

		// Map the Inventory to the Equipment Category
		const inventoryMap: Map<EquipmentSlots, Array<string>> = new Map<EquipmentSlots, Array<string>>();
		inventoryMap.set(EquipmentSlots.Helmet, playerData.HelmetInventory);
		inventoryMap.set(EquipmentSlots.Weapon, playerData.WeaponInventory);
		inventoryMap.set(EquipmentSlots.Boots, playerData.BootsInventory);
		inventoryMap.set(EquipmentSlots.Familiar, playerData.FamiliarInventory);
		inventoryMap.set(EquipmentSlots.Accessory, playerData.AccessoryInventory);

		// Set the Inventory
		const inventory = inventoryMap.get(equipmentCategory);

		// Invalid Category Check
		if (inventory === undefined) {
			print("Invalid Equipment Category", equipmentCategory);
			return false;
		}

		// Inventory Check
		if (inventory.find((item) => item === equipmentId) === undefined) {
			print("Item not found in inventory", equipmentId);
			return false;
		}

		return true;
	}
	public static ClearConnections() {
		InventoryService._connectionInventroyEquip?.Disconnect();
		InventoryService._connectionInventoryUnequip?.Disconnect();
	}
}
