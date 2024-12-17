// Begin: KeyboardController.ts
import { UserInputService } from "@rbxts/services";
import { Character, Skill } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";
import { PositionGenerator } from "shared/Utility/PositionGenerator";
import { GameStorage } from "shared/Utility/GameStorage";
import { CommunicationGod } from "shared/Events/CommunicationGod";
CommunicationGod.Summon();
function formatVector3(vector: Vector3): string {
	const x = "X:" + tostring(math.round(vector.X * 10) / 10);
	const y = " y: " + tostring(math.round(vector.Y * 10) / 10);
	const z = " Z: " + tostring(math.round(vector.Z * 10) / 10);
	return x + y + z;
}

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

	private static PositionGeneratorTests(start: boolean) {
		const scriptBlock = game.GetService("Workspace").FindFirstChild("ScriptBlock", true) as BasePart;
		if (!start) {
			scriptBlock.ClearAllChildren();
			Logger.Log("PositionGeneratorTests", "Cleared Children");
			return;
		}
		const scriptBlockAttachment = new Instance("Attachment");
		scriptBlock.Name = "ScriptBlockAttachment";
		scriptBlockAttachment.Parent = scriptBlock;

		const randomPositionTest = PositionGenerator.GenerateRandomPositionsAroundSource(scriptBlock, 15, 22);
		const fireIndicator = new Instance("Fire");
		fireIndicator.Color = Color3.fromRGB(255, 222, 0);
		fireIndicator.Parent = scriptBlock;
		let beamCreated = false;
		randomPositionTest.forEach((position) => {
			const firePart = new Instance("Part");
			const fire = new Instance("Fire");
			const fireAttachment = new Instance("Attachment");
			fireAttachment.Parent = firePart;
			const beam = new Instance("Beam");
			if (!beamCreated) {
				beamCreated = true;
				beam.Parent = firePart;
				beam.Color = new ColorSequence(new Color3(1, 0, 0));
				beam.FaceCamera = true;
				beam.LightEmission = 1;
				beam.LightInfluence = 0;
				beam.Segments = 10;
				beam.Attachment0 = scriptBlockAttachment;
				beam.Attachment1 = fireAttachment;

				firePart.Name = "HitPart";
				firePart.Color = Color3.fromRGB(255, 0, 0);
			} else {
				beamCreated = false;
			}

			fire.Color = Color3.fromRGB(255, 222, 0);
			fire.Parent = firePart;
			firePart.Size = new Vector3(1, 1, 1);
			firePart.Position = position;
			firePart.Anchored = true;
			firePart.Parent = scriptBlock;
		});

		const defaultTargetPosition = PositionGenerator.GenerateDefaultTargetPosition(scriptBlock, 10);
		warn("Default Target Position: ", formatVector3(defaultTargetPosition));
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
		const serverSignals: Map<string, RemoteEvent> = CommunicationGod.ServerSignals;
		//Logger.Log("KeyboardController", `Key Pressed: ${key} - ${begin}`);
		switch (key) {
			case Enum.KeyCode.Q:
				this.SkillToggle("DevilBeam", begin);
				break;
			case Enum.KeyCode.E:
				this.SkillToggle("Spotlights", begin);
				break;
			case Enum.KeyCode.R:
				this.SkillToggle("BigRed", begin);
				break;
			case Enum.KeyCode.T:
				this.PositionGeneratorTests(begin);
				break;
			case Enum.KeyCode.Y:
				serverSignals.forEach((signal, name) => {
					signal.FireServer(begin);
					print("Fired Signal: ", name);
				});
				break;
			default:
				//warn(`Unhandled key: ${key}`);
				break;
		}
	}
}
// End: KeyboardController.ts
