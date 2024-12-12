import { Logger } from "shared/Utility/Logger";
import { DataCache } from "./DataManager";
import { EquipmentData } from "shared/Interfaces/IData";
// Equipment Manager
export class EquipmentManager {
	private _dataCache: DataCache;
	constructor(dataCache: DataCache) {
		this._dataCache = dataCache;
		const EquipmentSlots = this.GetEquipmentSlots();
		Logger.Log(
			"EquipmentManager",
			"Constructor: \n\n",
			EquipmentSlots.Helmet,
			EquipmentSlots.Armor,
			EquipmentSlots.Boots,
			EquipmentSlots.Weapon,
			EquipmentSlots.Familiar,
			EquipmentSlots.Accessory,
			"\n\n",
		);
	}

	private ValidateEquipment(equipmentId: string, inventory: Array<string>): boolean {
		return inventory.find((equipment) => equipment === equipmentId) !== undefined;
	}

	public SetEquipmentSlot(slot: string, equipmentId: string) {
		const playersEquipment = this._dataCache._playerData.Equipment;
		const weaponInventory = this._dataCache._playerData.WeaponInventory;
		const ArmorInventory = this._dataCache._playerData.ArmorInventory;
		const HelmetInventory = this._dataCache._playerData.HelmetInventory;
		const BootsInventory = this._dataCache._playerData.BootsInventory;
		const FamiliarInventory = this._dataCache._playerData.FamiliarInventory;
		const AccessoryInventory = this._dataCache._playerData.AccessoryInventory;

		switch (slot) {
			case "Weapon":
				if (this.ValidateEquipment(equipmentId, weaponInventory) === true) {
					playersEquipment.Weapon = equipmentId;
				}
				break;
			case "Armor":
				if (this.ValidateEquipment(equipmentId, ArmorInventory) === true) {
					playersEquipment.Armor = equipmentId;
				}
				break;
			case "Helmet":
				if (this.ValidateEquipment(equipmentId, HelmetInventory) === true) {
					playersEquipment.Helmet = equipmentId;
				}
				break;
			case "Boots":
				if (this.ValidateEquipment(equipmentId, BootsInventory) === true) {
					playersEquipment.Boots = equipmentId;
				}
				break;
			case "Familiar":
				if (this.ValidateEquipment(equipmentId, FamiliarInventory) === true) {
					playersEquipment.Familiar = equipmentId;
				}
				break;
			case "Accessory":
				if (this.ValidateEquipment(equipmentId, AccessoryInventory) === true) {
					playersEquipment.Accessory = equipmentId;
				}
				break;
			default:
				break;
		}
	}

	public GetEquipmentSlots(): EquipmentData {
		return this._dataCache._playerData.Equipment;
	}
}
