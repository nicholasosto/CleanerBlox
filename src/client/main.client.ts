// Game Services
import { Players } from "@rbxts/services";
import { KeyboardClient } from "./Keyboard";
import { UIService } from "./UI/UIService";
import { Character, CreateClient } from "@rbxts/wcs";
import { WCSFolders } from "shared/WCS/Folders";
import { Logger } from "shared/Utility/Logger";

UIService.Start();
UIService.LoadActionBar();
const wcsClient = CreateClient();
wcsClient.RegisterDirectory(WCSFolders.Skills);
wcsClient.RegisterDirectory(WCSFolders.Movesets);
wcsClient.RegisterDirectory(WCSFolders.StatusEffects);
wcsClient.Start();

// function loadSignalButtonInstance(instanceName: string) {
// 	const matchingInstanceNames = Players.LocalPlayer.WaitForChild("PlayerGui")
// 		.GetDescendants()
// 		.filter((descendant) => descendant.Name === instanceName);

// 	// Button Instance
// 	const buttonInstance = matchingInstanceNames.filter((instance) => instance.IsA("GuiButton"))[0];

// 	// Check if button is already loaded
// 	const existingButton = signalButtons.find((button) => button.getInstance() === buttonInstance);

// 	// Create Signal Button
// 	if (!existingButton) {
// 		const signalButton = new SignalButton(buttonInstance, { name: instanceName });
// 		signalButtons.push(signalButton);
// 		Logger.Log("SignalButton", "Button Loaded: ", buttonInstance);
// 	} else {
// 		Logger.Log("SignalButton", "Button Already Loaded: ", buttonInstance);
// 	}
// }

function handleCharacterAdded(character: Model) {
	const keyboardClient = new KeyboardClient(character);

	Logger.Log("Client", "Character Added: ", character);
	const wcsCharacter = Character.GetLocalCharacter();

	wcsCharacter?.GetSkills().forEach((skill) => Logger.Log("Client", "Skill", skill.GetName()));
}

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
