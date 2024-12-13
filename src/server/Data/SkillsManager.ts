import { ReplicatedStorage, Players } from "@rbxts/services";
import { Logger } from "shared/Utility/Logger";
import { DataCache } from "./DataManager";
import { SkillsData } from "shared/Interfaces/IData";

const SKILL_GetSlots: RemoteEvent = ReplicatedStorage.FindFirstChild("SKILL_GetSlots", true) as RemoteEvent;
const SKILL_GetInventory: RemoteEvent = ReplicatedStorage.FindFirstChild("SKILL_GetInventory", true) as RemoteEvent;
const SKILL_AssignSlot: RemoteEvent = ReplicatedStorage.FindFirstChild("SKILL_AssignSlot", true) as RemoteEvent;

// Skills Manager
export class SkillsManager {
	private _dataCache: DataCache;

	// GetSkillSlots Event Connection
	private _connectionGetSkillSlots = SKILL_GetSlots.OnServerEvent.Connect((player: Player) => {
		const playerId = tostring(player.UserId);
		if (playerId !== this._dataCache._userId) return;
		Logger.Log("SkillsManagerX", "GetSkillSlots", this.GetSkillSlots());
		SKILL_GetSlots.FireClient(player, this.GetSkillSlots() as SkillsData);
	});

	// GetSkillInventory Event Connection
	private _connectionGetSkillInventory = SKILL_GetInventory.OnServerEvent.Connect((player: Player) => {
		const playerId = tostring(player.UserId);
		if (playerId !== this._dataCache._userId) return;

        SKILL_GetInventory.FireClient(player, this._dataCache._playerData.SkillInventory as Array<string>);
		Logger.Log("SkillsManagerX", "GetSkillInventory", this._dataCache._playerData.SkillInventory);
	});

	// AssignSlot Event Connection
	private _connectionAssignSlot = SKILL_AssignSlot.OnServerEvent.Connect((player: Player, ...args) => {
		const playerId = tostring(player.UserId);
		if (playerId !== this._dataCache._userId) return;

		const slotNumber = args[0] as number;
		const skillId = args[1] as string;

		if (slotNumber === undefined || skillId === undefined) return;

		if (slotNumber < 1 || slotNumber > 5) return;

		if (!this.ValidateSkill(skillId)) return;

		Logger.Log("SkillsManagerX", "AssignSlot", slotNumber, skillId);
		this.SetSkillSlot(args[0] as number, args[1] as string);
	});

	//Constructor
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

	public ValidateSkill(skillId: string): boolean {
		const playersSkills = this._dataCache._playerData.SkillInventory;
		return playersSkills.find((skill) => skill === skillId) !== undefined;
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
		this._dataCache.Save();
	}

	public GetSkillSlots(): SkillsData {
		return this._dataCache._playerData.Skills;
	}
}
