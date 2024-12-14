import { ReplicatedStorage, Players } from "@rbxts/services";
import { Logger } from "shared/Utility/Logger";
import { DataCache } from "../DataManager";
import { SkillsData } from "shared/Interfaces/IData";

// Remote Events
const SKILL_GetSlots: RemoteEvent = ReplicatedStorage.FindFirstChild("SKILL_GetSlots", true) as RemoteEvent;
const SKILL_GetInventory: RemoteEvent = ReplicatedStorage.FindFirstChild("SKILL_GetInventory", true) as RemoteEvent;
const SKILL_AssignSlot: RemoteEvent = ReplicatedStorage.FindFirstChild("SKILL_AssignSlot", true) as RemoteEvent;

// Skills Manager
export class SkillsManager {
	// Data Cache
	private _dataCache: DataCache;

	// GetSkillSlots Event Connection
	private _connectionGetSkillSlots = SKILL_GetSlots.OnServerEvent.Connect((player: Player) => {
		const playerId = tostring(player.UserId);
		if (playerId !== this._dataCache._userId) return;
		SKILL_GetSlots.FireClient(player, this.GetSkillSlots() as SkillsData);
	});

	// GetSkillInventory Event Connection
	private _connectionGetSkillInventory = SKILL_GetInventory.OnServerEvent.Connect((player: Player) => {
		// Player Id Check
		const playerId = tostring(player.UserId);
		if (playerId !== this._dataCache._userId) return;

		// Fire Client
		// eslint-disable-next-line prettier/prettier
        SKILL_GetInventory.FireClient(player, this._dataCache._playerData.SkillInventory as Array<string>);

	});

	// AssignSlot Event Connection
	private _connectionAssignSlot = SKILL_AssignSlot.OnServerEvent.Connect((player: Player, ...args) => {
		// Player Id Check
		const playerId = tostring(player.UserId);
		if (playerId !== this._dataCache._userId) return;

		// Args Check
		const slotNumber = args[0] as number;
		const skillId = args[1] as string;

		// Args Validation
		if (slotNumber === undefined || skillId === undefined) return;
		if (slotNumber < 1 || slotNumber > 5) return;

		// Skill Validation
		if (!this.ValidateSkill(skillId)) return;

		// Set Skill Slot
		this.SetSkillSlot(args[0] as number, args[1] as string);
	});

	//Constructor
	constructor(dataCache: DataCache) {
		this._dataCache = dataCache;
		this._dataCache.Save();
	}

	// Vakidate Skill by checking if the skill exists in the player's inventory
	public ValidateSkill(skillId: string): boolean {
		const playersSkills = this._dataCache._playerData.SkillInventory;
		return playersSkills.find((skill) => skill === skillId) !== undefined;
	}

	// Set Skill Slot
	public SetSkillSlot(slot: number, skillId: string) {
		const playersSkills = this._dataCache._playerData.SkillInventory;
		const matchingSkill = playersSkills.find((skill) => skill === skillId);
		if (matchingSkill === undefined) {
			Logger.Log("SkillSlotManager", "\nSkill not found in player's inventory\n", skillId);
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

	// Get Skill Slots
	public GetSkillSlots(): SkillsData {
		return this._dataCache._playerData.Skills;
	}
}
