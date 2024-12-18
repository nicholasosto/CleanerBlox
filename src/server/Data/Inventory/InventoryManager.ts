import { DataCache } from "../DataManager";
import { Logger } from "shared/Utility/Logger";
import { InventoryTypeKeys } from "shared/Interfaces/IData";

export enum InventoryType {
	SkillInventory = "SkillInventory",
	WeaponInventory = "WeaponInventory",
	ArmorInventory = "ArmorInventory",
	HelmetInventory = "HelmetInventory",
	BootsInventory = "BootsInventory",
	FamiliarInventory = "FamiliarInventory",
	AccessoryInventory = "AccessoryInventory",
}

// Inventory Manager
export class InventoryManager {
	private _dataCache: DataCache;
	constructor(dataCache: DataCache) {
		this._dataCache = dataCache;
	}

	public AddToInventory(inventoryType: InventoryTypeKeys, itemId: string) {
		const playersInventory = this._dataCache._playerData[inventoryType] as string[];

		if (playersInventory.find((item) => item === itemId) !== undefined) {
			//Logger.Log("InventoryManager", "Item already Exista", itemId);
			return;
		}
		playersInventory.push(itemId);

		this._dataCache._playerData[inventoryType] = playersInventory;
		this._dataCache.Save();
	}

	public RemoveFromInventory(inventoryType: InventoryTypeKeys, itemId: string) {
		const itemIndex = this._dataCache._playerData[inventoryType].indexOf(itemId);
		if (itemIndex > -1) {
			this._dataCache._playerData[inventoryType][itemIndex] = "";
			//Logger.Log("InventoryManager", "Item Removed", itemId);
		}
		this._dataCache.Save();
	}

	public GetInventory(inventoryType: InventoryTypeKeys): Array<string> {
		return this._dataCache._playerData[inventoryType];
	}
}
