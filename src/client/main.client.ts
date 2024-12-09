// Game Services
import { ReplicatedStorage, Players, UserInputService } from "@rbxts/services";
import { KeyboardClient } from "./Keyboard";
import { UIService } from "./UI/UIService";
//import { ActionBar } from "./ActionBar";

// Keyboard Client
// To use this class
const keyboardClient = new KeyboardClient();

// WCS
import { CreateClient } from "@rbxts/wcs";
import { Character } from "@rbxts/wcs";

// WCS: get the folders we need to register
const skillsFolder = ReplicatedStorage.FindFirstChild("Skills", true);
const movesetFolder = ReplicatedStorage.FindFirstChild("Movesets", true);
const statusEffectsFolder = ReplicatedStorage.FindFirstChild("StatusEffects", true);

// WCS: create the client
const Client = CreateClient();

// WCS: register the folders
if (skillsFolder && movesetFolder && statusEffectsFolder) {
	Client.RegisterDirectory(skillsFolder);
	Client.RegisterDirectory(movesetFolder);
	Client.RegisterDirectory(statusEffectsFolder);
}

// WCS: start the client
Client.Start();

// UI Service
const uiService = new UIService(Players.LocalPlayer.WaitForChild("PlayerGui") as PlayerGui);

// WCS: get the current character
function getCurrentWCS_Character() {
	const characterModel = Players.LocalPlayer.Character as Model;
	const character = Character.GetCharacterFromInstance(characterModel) as Character;
	if (!character) return undefined;
	return character;
}

// Input Handling
function handleKeyboardInputBegan(Input: InputObject, character: Character) {
	switch (Input.KeyCode) {
		case Enum.KeyCode.F:
			character.GetSkillFromString("Block")?.Start();
			break;
		case Enum.KeyCode.E:
			character.GetSkillFromString("Spotlights")?.Start();
			break;
	}
}

function handleKeyboardInputEnded(Input: InputObject, character: Character) {
	switch (Input.KeyCode) {
		case Enum.KeyCode.F:
			character.GetSkillFromString("Block")?.Stop();
			break;
		case Enum.KeyCode.E:
			character.GetSkillFromString("Spotlights")?.Stop();
			break;
	}
}

function handleInputBegan(Input: InputObject, GameProcessed: boolean) {
	if (GameProcessed) return;

	const character = getCurrentWCS_Character();
	if (!character) return;

	switch (Input.UserInputType) {
		case Enum.UserInputType.Keyboard:
			handleKeyboardInputBegan(Input, character);
			break;
		case Enum.UserInputType.MouseButton1:
			character.GetSkillFromString("Attack")?.Start();
			break;
		case Enum.UserInputType.MouseButton2:
			character.GetSkillFromString("Block")?.Start();
			break;
		default:
			print("Unhandled Input", Input.KeyCode);
	}
}

function handleInputEnded(Input: InputObject, GameProcessed: boolean) {
	if (GameProcessed) return;

	// get the current character from WCS
	const character = getCurrentWCS_Character();
	if (!character) return;

	switch (Input.UserInputType) {
		case Enum.UserInputType.Keyboard:
			handleKeyboardInputEnded(Input, character);
			break;
		case Enum.UserInputType.MouseButton1:
			character.GetSkillFromString("Attack")?.Stop();
			break;
		case Enum.UserInputType.MouseButton2:
			character.GetSkillFromString("Block")?.Stop();
			break;
		default:
			print("Unhandled Input", Input.KeyCode);
	}
}

UserInputService.InputBegan.Connect(handleInputBegan);

UserInputService.InputEnded.Connect(handleInputEnded);

