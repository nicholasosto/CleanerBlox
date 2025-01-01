import { GameStorage } from "shared/Utility/GameStorage";

// Events

// Requests
const SKILLS_SkillSlotRequest: RemoteEvent = GameStorage.getEvent("SKILL_SkillSlotRequest");
const SKILLS_ClearSlotRequest: RemoteEvent = GameStorage.getEvent("SKILL_ClearSlotRequest");
const SKILL_AssignSlotRequest: RemoteEvent = GameStorage.getEvent("SKILL_AssignSlotRequest");

// Responses
const SKILLS_SkillSlotResponse: RemoteEvent = GameStorage.getEvent("SKILL_SkillSlotResponse");
const SKILLS_ClearSlotResponse: RemoteEvent = GameStorage.getEvent("SKILL_ClearSlotResponse");
const SKILLS_AssignSlotResponse: RemoteEvent = GameStorage.getEvent("SKILL_AssignSlotResponse");

export class ClientSkillService {
	// Static Instance
	private static _instance: ClientSkillService;

	// Event Listener Connections
	private static _connectionSkillSlotsResponse: RBXScriptConnection | undefined;
	private static _connectionClearSlotResponse: RBXScriptConnection | undefined;
	private static _connectionAssignSlotResponse: RBXScriptConnection | undefined;

	private constructor() {
		// Equip Response
		ClientSkillService._connectionSkillSlotsResponse = SKILLS_SkillSlotResponse.OnClientEvent.Connect(
			(response: string) => {
				//print("Equip Response", response);
			},
		);

		// Unequip Response
		ClientSkillService._connectionClearSlotResponse = SKILLS_ClearSlotResponse.OnClientEvent.Connect(
			(response: string) => {
				print("Unequip Response", response);
			},
		);

		// Assign Slot Response
		ClientSkillService._connectionAssignSlotResponse = SKILLS_AssignSlotResponse.OnClientEvent.Connect(
			(response: string) => {
				print("Assign Slot Response", response);
			},
		);


        return this;
	}

	// Start
	public static Start() {
		if (ClientSkillService._instance === undefined) {
			ClientSkillService._instance = new ClientSkillService();
		} else {
			print("ClientSkillService Already Started");
		}
	}

	// Send Equip Request
	public static AssignSlotRequest(slotId: string, skillId: string) {
		SKILL_AssignSlotRequest.FireServer(slotId, skillId);
	}

	// Clear Slot Request
	public static ClearSlotRequest(slotId: string) {
		SKILLS_ClearSlotRequest.FireServer(slotId);
	}

	// Send Get Slots Request
	public static GetSlotsRequest() {
		SKILLS_SkillSlotRequest.FireServer();
	}
}
