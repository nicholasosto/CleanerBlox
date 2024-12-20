import { TEventSuccessResponse, TSkillSlot } from "shared/SharedReference";
import { GameStorage } from "shared/Utility/GameStorage";
import { DataManager } from "../DataManager";
import { Logger } from "shared/Utility/Logger";

// Remote Events

// Requests
const SKILLS_SkillSlotRequest: RemoteEvent = GameStorage.getEvent("SKILL_SkillSlotRequest");
const SKILLS_ClearSlotRequest: RemoteEvent = GameStorage.getEvent("SKILL_ClearSlotRequest");
const SKILL_AssignSlotRequest: RemoteEvent = GameStorage.getEvent("SKILL_AssignSlotRequest");

// Responses
const SKILLS_SkillSlotResponse: RemoteEvent = GameStorage.getEvent("SKILL_SkillSlotResponse");
const SKILLS_ClearSlotResponse: RemoteEvent = GameStorage.getEvent("SKILL_ClearSlotResponse");
const SKILLS_AssignSlotResponse: RemoteEvent = GameStorage.getEvent("SKILL_AssignSlotResponse");

// Skills Manager
export class SkillService {
	// Static Instance
	private static _instance: SkillService;

	// Event Listener Connections
	private static _connectionSkillSlotsRequest: RBXScriptConnection | undefined;
	private static _connectionClearSlotRequest: RBXScriptConnection | undefined;
	private static _connectionAssignSlotRequest: RBXScriptConnection | undefined;

	// Constructor
	private constructor() {
		SkillService.ClearConnections();

		// Skill Slot Request Listener
		SkillService._connectionSkillSlotsRequest = SKILLS_SkillSlotRequest.OnServerEvent.Connect((player: Player) => {
			Logger.Log("SkillService", "Skill Slot Requested");
			const userId = tostring(player.UserId);
			const playerData = DataManager.GetDataCache(userId)._playerData;
			SKILLS_SkillSlotResponse.FireClient(player, playerData.SkillSlots);
		});

		// Clear Slot Request Listener
		SkillService._connectionClearSlotRequest = SKILLS_ClearSlotRequest.OnServerEvent.Connect(
			(player: Player, ...args: Array<unknown>) => {
				const SlotId = args[0] as string;
				print("Getting player data", args);
			},
		);
		return this;
	}

	// Clear Connections
	private static ClearConnections() {
		SkillService._connectionSkillSlotsRequest?.Disconnect();
		SkillService._connectionClearSlotRequest?.Disconnect();
		SkillService._connectionAssignSlotRequest?.Disconnect();
	}

	// Start
	public static Start() {
		if (SkillService._instance === undefined) {
			SkillService._instance = new SkillService();
		} else {
			Logger.Log("SkillService", "Already started");
		}
	}

	public static AssignSkills(player: Player, skills: Array<TSkillSlot>) {
		const userId = tostring(player.UserId);
		const playerData = DataManager.GetDataCache(userId)._playerData;
		const playerSkills = playerData.SkillSlots;

		playerSkills.forEach((skillSlot) => {
			Logger.Log("SkillService", "Assigning Skill: " + skillSlot.SkillId);
		});
	}

	// Clear Slot
	public static ClearSlot(player: Player, slotId: string): TEventSuccessResponse {
		const response: TEventSuccessResponse = {
			success: true,
			message: "Skill Slot Cleared",
		};
		return response;
	}
}
