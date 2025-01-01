// Begin: KeyboardController.ts
import { HttpService, UserInputService, Workspace } from "@rbxts/services";
import { ClientInventoryService } from "client/Services/ClientInventoryService";
import { ClientSkillService } from "client/Services/ClientSkillService";
import { Character, Skill } from "@rbxts/wcs";
import { CommunicationGod } from "shared/Experimental/CommunicationGod";
import { InventoryReference } from "shared/SharedReference";

// Set the skills here
const Skills: Map<Enum.KeyCode, string> = new Map<Enum.KeyCode, string>();
Skills.set(Enum.KeyCode.Q, "BasicMelee");
Skills.set(Enum.KeyCode.E, "CleanHold");
Skills.set(Enum.KeyCode.R, "BigRed");
Skills.set(Enum.KeyCode.T, "ShapeTester");

CommunicationGod.Summon();

export class KeyboardController {
	private static instance: KeyboardController;
	private static inputBeganConnection: RBXScriptConnection;
	private static inputEndedConnection: RBXScriptConnection;
	private static characterAddedConnection: RBXScriptConnection;

	public static Start() {
		if (this.instance === undefined) {
			this.instance = new KeyboardController();
		}
	}
	// Constructor
	constructor() {
		const Player = game.GetService("Players").LocalPlayer as Player;
		const character = Player.Character;
		KeyboardController.OnCharacterAdded(character as Model);
		// CHARACTER ADDED
		KeyboardController.characterAddedConnection = Player.CharacterAdded.Connect((character: Model) => {
			//Logger.Log("KeyboardController", "Character Added");
			KeyboardController.OnCharacterAdded(character);
		});
	}

	private static OnCharacterAdded(character: Model) {
		// Disconnect the previous connections
		KeyboardController.inputBeganConnection?.Disconnect();
		KeyboardController.inputEndedConnection?.Disconnect();

		const wcsCharacter = Character.GetLocalCharacter() as Character;

		// Input Began Connection
		KeyboardController.inputBeganConnection = UserInputService.InputBegan.Connect(
			(input: InputObject, isProcessed: boolean) => {
				switch (input.KeyCode) {
					case Enum.KeyCode.V:
						print("V Pressed");
						ClientSkillService.AssignSlotRequest("1", "Basic");
						break;
					case Enum.KeyCode.G:
						print("G Pressed");
						break;
					case Enum.KeyCode.H:
						print("H Pressed");
						this.InventoryToggle(InventoryReference.EInventorySlot.Body, "Plate_Legendary_RB", true);
						this.InventoryToggle(InventoryReference.EInventorySlot.Helmet, "Demon Lord Halo", true);
						break;
					case Enum.KeyCode.J:
						print("J Pressed");
						this.InventoryToggle(InventoryReference.EInventorySlot.LeftHand, "Scythe_Epic_Black", true);
						this.InventoryToggle(InventoryReference.EInventorySlot.RightHand, "Scythe_Epic_Black", true);
						break;
					default:
						KeyboardController.InputBegan(input, isProcessed);
						break;
				}
			},
		);

		// Input Ended Connection
		KeyboardController.inputEndedConnection = UserInputService.InputEnded.Connect(
			(input: InputObject, isProcessed: boolean) => {
				switch (input.KeyCode) {
					case Enum.KeyCode.V:
						print("V Pressed");
						ClientSkillService.AssignSlotRequest("1", "Basic");
						break;
					case Enum.KeyCode.G:
						print("G Pressed");
						break;
					case Enum.KeyCode.H:
						print("H Pressed");
						this.InventoryToggle(InventoryReference.EInventorySlot.Body, "Plate_Legendary_RB", false);
						this.InventoryToggle(InventoryReference.EInventorySlot.Helmet, "Demon Lord Halo", false);
						break;
					case Enum.KeyCode.J:
						print("J Pressed");
						this.InventoryToggle(InventoryReference.EInventorySlot.LeftHand, "Scythe_Epic_Black", false);
						this.InventoryToggle(InventoryReference.EInventorySlot.RightHand, "Scythe_Epic_Black", false);
						break;
					default:
						KeyboardController.InputEnded(input, isProcessed);
						break;
				}
			},
		);
	}

	private static InputBegan(input: InputObject, isProcessed: boolean) {
		KeyboardController.onKeyPress(input.KeyCode, true);
	}

	private static InputEnded(input: InputObject, isProcessed: boolean) {
		KeyboardController.onKeyPress(input.KeyCode, false);
	}

	private static InventoryToggle(
		equipmentSlot: InventoryReference.EInventorySlot,
		weaponName: string,
		begin: boolean,
	) {
		if (begin) {
			ClientInventoryService.SendEquipRequest(equipmentSlot, weaponName);
		} else {
			ClientInventoryService.SendUnequipRequest(equipmentSlot);
		}
	}

	// Helper: Skill Toggle
	private static SkillToggle(skillName: string, begin: boolean): void {
		const character = Character.GetLocalCharacter() as Character;

		if (!character) {
			return;
		}

		const skill = character.GetSkillFromString(skillName) as Skill;

		if (skill) {
			if (begin) {
				skill.Start();
			} else {
				skill.Stop();
			}
		}
	}

	// Main Function: onKeyPress
	private static onKeyPress(key: Enum.KeyCode, begin: boolean): void {
		const skillName = Skills.get(key);
		this.SkillToggle(skillName as string, begin);
	}
}
// End: KeyboardController.ts
