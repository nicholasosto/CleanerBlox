// Begin: KeyboardController.ts
import { UserInputService } from "@rbxts/services";
import { Character, Skill } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";



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
			Logger.Log("KeyboardController", "Character Added");
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
		Logger.Log("KeyboardController", `Skill Toggle: ${skillName} - ${begin}`);
		const character = Character.GetLocalCharacter() as Character;

		const skill = character.GetSkillFromString(skillName) as Skill;
		Logger.Log("KeyboardController", `Skill: ${skill}`);

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
		Logger.Log("KeyboardController", `Key Pressed: ${key} - ${begin}`);
		switch (key) {
			case Enum.KeyCode.Q:
				break;
			case Enum.KeyCode.E:
				break;
			case Enum.KeyCode.R:
				this.SkillToggle("BigRed", begin);
				break;
			default:
				warn(`Unhandled key: ${key}`);
				break;
		}
	}
}
// End: KeyboardController.ts
