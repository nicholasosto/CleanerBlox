// Begin: KeyboardController.ts
import { HttpService, UserInputService, Workspace } from "@rbxts/services";
import { Character, Skill } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";
import { PositionGenerator } from "shared/Utility/PositionGenerator";
import { GameStorage } from "shared/Utility/GameStorage";
import { CommunicationGod } from "shared/Events/CommunicationGod";

// Set the skills here
const Skills: Map<Enum.KeyCode, string> = new Map<Enum.KeyCode, string>();
Skills.set(Enum.KeyCode.Q, "BasicMelee");
Skills.set(Enum.KeyCode.E, "CleanHold");
Skills.set(Enum.KeyCode.R, "BigRed");
Skills.set(Enum.KeyCode.T, "ShapeTester");

CommunicationGod.Summon();
const AI_Request = GameStorage.getEvent("AI_Request");

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
				if (input.KeyCode === Enum.KeyCode.F) {
					print("F Pressed");
					AI_Request.FireServer(Workspace.FindFirstChild("TrembusTech") as Model);
				}
				KeyboardController.InputBegan(input, isProcessed);
			},
		);

		// Input Ended Connection
		KeyboardController.inputEndedConnection = UserInputService.InputEnded.Connect(
			(input: InputObject, isProcessed: boolean) => {
				KeyboardController.InputEnded(input, isProcessed);
			},
		);
	}

	private static InputBegan(input: InputObject, isProcessed: boolean) {
		KeyboardController.onKeyPress(input.KeyCode, true);
	}

	private static InputEnded(input: InputObject, isProcessed: boolean) {
		KeyboardController.onKeyPress(input.KeyCode, false);
	}

	// Helper: Skill Toggle
	private static SkillToggle(skillName: string, begin: boolean): void {
		const character = Character.GetLocalCharacter() as Character;

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
