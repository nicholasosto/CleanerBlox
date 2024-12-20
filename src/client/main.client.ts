// Game Services
import { Players } from "@rbxts/services";

// Plugin Services
import { CreateClient } from "@rbxts/wcs";

// My Services
import { ClientInventoryService } from "./Services/ClientInventoryService";
import { ClientSkillService } from "./Services/ClientSkillService";

// Controllers
import { KeyboardController } from "./Controllers/KeyboardController";
import { FlightController } from "./Controllers/FlightController";
import { GUIController } from "./Controllers/GUIController";

// References
import { WCSFolders } from "shared/WCS/Folders";
import { Logger } from "shared/Utility/Logger";
import { CommunicationGod } from "shared/Experimental/CommunicationGod";

// Start Services
ClientInventoryService.Start();
ClientSkillService.Start();



//UIController.Start();

// WCS Client Start
const wcsClient = CreateClient();
wcsClient.RegisterDirectory(WCSFolders.Skills);
wcsClient.RegisterDirectory(WCSFolders.Movesets);
wcsClient.RegisterDirectory(WCSFolders.StatusEffects);
wcsClient.Start();

// Start Controllers
KeyboardController.Start();
FlightController.Start();
GUIController.Start();
CommunicationGod.Summon();

// Handle Character Added
function handleCharacterAdded(character: Model) {
	Logger.Log("Client", "Character Added: ", character);
}

// Handle Character Removing
function handleCharacterRemoving(character: Model) {
	Logger.Log("Client", "Character Removed: ", character);
}

// Check if character exists and perform Character Added event actions
if (Players.LocalPlayer.Character) {
	handleCharacterAdded(Players.LocalPlayer.Character);
}

// Character Added/Removing Events
Players.LocalPlayer.CharacterAdded.Connect(handleCharacterAdded);
Players.LocalPlayer.CharacterRemoving.Connect(handleCharacterRemoving);
