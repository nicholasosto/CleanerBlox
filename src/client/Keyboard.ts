// Begin: KeyboardClient.ts
import { UserInputService } from "@rbxts/services";
import { TNums } from "shared/Enums/TNums";
import { Character, Skill } from "@rbxts/wcs";

export class KeyboardClient {
	private wcsCharacter: Character | Promise<Character> | undefined;
	private inputBeganConnection: RBXScriptConnection;
	private inputEndedConnection: RBXScriptConnection;

	// Constructor
	constructor(character: Model) {
		// Set the wcsCharacter
		do {
			this.wcsCharacter = Character.GetLocalCharacter();
			task.wait(0.3);
		} while (this.wcsCharacter === undefined);

		// Get the skills from WCS
		const skills = this.wcsCharacter.GetSkills();

		// INPUT BEGAN
		this.inputBeganConnection = UserInputService.InputBegan.Connect((input, isProcessed) => {
			if (isProcessed) return; // Prevent handling if another context has processed this input

			if (input.UserInputType === Enum.UserInputType.Keyboard) {
				const keyCode = input.KeyCode;
				this.onKeyPress(keyCode, true);
			}
		});

		// INPUT ENDED
		this.inputEndedConnection = UserInputService.InputEnded.Connect((input, isProcessed) => {
			if (isProcessed) return; // Prevent handling if another context has processed this input

			if (input.UserInputType === Enum.UserInputType.Keyboard) {
				const keyCode = input.KeyCode;
				this.onKeyPress(keyCode, false);
			}
		});
	}
	// Helper: Skill Toggle
	private SkillToggle(skillName: string, begin: boolean): void {
		const character = this.wcsCharacter as Character;

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
	private onKeyPress(key: Enum.KeyCode, begin: boolean): void {
		switch (key) {
			case Enum.KeyCode.Q:
				this.SkillToggle(TNums.SkillNames.Spotlights, begin);
				break;
			case Enum.KeyCode.E:
				this.SkillToggle(TNums.SkillNames.Dash, begin);
				break;
			default:
				warn(`Unhandled key: ${key}`);
				break;
		}
	}
}
// End: KeyboardClient.ts
