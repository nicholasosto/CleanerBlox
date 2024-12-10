// Game Services
import { Players } from "@rbxts/services";
import { KeyboardClient } from "./Keyboard";
import { UIService } from "./UI/UIService";
import { WCSWrapper } from "./WCSWrapper";

const player = Players.LocalPlayer;

UIService.Start();
UIService.LoadActionBar();
player.CharacterAdded.Connect((character) => {

	// WCS Wrapper
	const wcsWrapper = new WCSWrapper();

	wcsWrapper.Client.Start();

	const keyboardClient = new KeyboardClient(character);

	const wcsCharacter = wcsWrapper.wcsCharacter;

	
});

player.CharacterRemoving.Connect((character) => {
	print("CLIENT: Character Removed: ", character);
});

