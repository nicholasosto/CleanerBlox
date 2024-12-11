// Game Services
import { Players } from "@rbxts/services";
import { KeyboardClient } from "./Keyboard";
import { UIService } from "./UI/UIService";
import { Character, CreateClient } from "@rbxts/wcs";
import { WCSFolders } from "shared/WCS/Folders";
import { Logger } from "shared/Utility/Logger";

// UI Service Start
UIService.Start();
UIService.LoadActionBar();

// WCS Client Start
const wcsClient = CreateClient();
wcsClient.RegisterDirectory(WCSFolders.Skills);
wcsClient.RegisterDirectory(WCSFolders.Movesets);
wcsClient.RegisterDirectory(WCSFolders.StatusEffects);
wcsClient.Start();

// Handle Character Added
function handleCharacterAdded(character: Model) {
	const keyboardClient = new KeyboardClient(character);

	Logger.Log("Client", "Character Added: ", character);
	const wcsCharacter = Character.GetLocalCharacter();

	wcsCharacter?.GetSkills().forEach((skill) => Logger.Log("Client", "Skill", skill.GetName()));
}

// Handle Character Removing
function handleCharacterRemoving(character: Model) {
	Logger.Log("Client", "Character Removed: ", character);
}

// Get character from LocalPlayer
const character = Players.LocalPlayer.Character;

// Check if character exists and perform Character Added event actions
if (character) {
	handleCharacterAdded(character);
}

// Character Added/Removing Events
Players.LocalPlayer.CharacterAdded.Connect(handleCharacterAdded);
Players.LocalPlayer.CharacterRemoving.Connect(handleCharacterRemoving);
