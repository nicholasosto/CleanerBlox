import { Logger } from "shared/Utility/Logger";
import { DataCache } from "./DataManager";
import { SkillsData } from "shared/Interfaces/IData";

// Skills Manager
export class SkillsManager {
	private _dataCache: DataCache;

	constructor(dataCache: DataCache) {
		this._dataCache = dataCache;

		Logger.Log(
			"SkillSlotManager",
			"Skills\n\n",
			this._dataCache._playerData.Skills.Slot_1,
			this._dataCache._playerData.Skills.Slot_2,
			this._dataCache._playerData.Skills.Slot_3,
			this._dataCache._playerData.Skills.Slot_4,
			"\n\n",
		);
		this._dataCache.Save();
	}

	public SetSkillSlot(slot: number, skillId: string) {
		const playersSkills = this._dataCache._playerData.SkillInventory;
		const matchingSkill = playersSkills.find((skill) => skill === skillId);
		if (matchingSkill === undefined) {
			Logger.Log("SkillSlotManager", "Skill not found in player's inventory", skillId);
			return;
		}
		switch (slot) {
			case 1:
				this._dataCache._playerData.Skills.Slot_1 = skillId;
				break;
			case 2:
				this._dataCache._playerData.Skills.Slot_2 = skillId;
				break;
			case 3:
				this._dataCache._playerData.Skills.Slot_3 = skillId;
				break;
			case 4:
				this._dataCache._playerData.Skills.Slot_4 = skillId;
				break;
			case 5:
				this._dataCache._playerData.Skills.Slot_5 = skillId;
				break;
			default:
				break;
		}
	}

	public GetSkillSlots(): SkillsData {
		return this._dataCache._playerData.Skills;
	}
}
