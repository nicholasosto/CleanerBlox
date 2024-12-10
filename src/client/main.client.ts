// Game Services
import { ReplicatedStorage, Players, UserInputService } from "@rbxts/services";
import { KeyboardClient } from "./Keyboard";
import { UIService } from "./UI/UIService";
import { WCSWrapper } from "./WCSWrapper";
import { Character } from "@rbxts/wcs";
//import { ActionBar } from "./ActionBar";

const player = Players.LocalPlayer;

player.CharacterAdded.Connect((character) => {
	print("CLIENT: Character Added: ", character);
	// WCS Wrapper
	const wcsWrapper = new WCSWrapper();

	wcsWrapper.Client.Start();

	const keyboardClient = new KeyboardClient(character);
});

player.CharacterRemoving.Connect((character) => {
	print("CLIENT: Character Removed: ", character);
});

// UI Service
const uiService = new UIService(Players.LocalPlayer.WaitForChild("PlayerGui") as PlayerGui);
