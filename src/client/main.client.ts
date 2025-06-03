// Game Services
import { HttpService, Players } from "@rbxts/services";

// Plugin Services
import { CreateClient, Character, Skill, SkillBase, UnknownSkill } from "@rbxts/wcs";

// My Services
import { ClientInventoryService } from "./Services/ClientInventoryService";
import { ClientSkillService } from "./Services/ClientSkillService";

// Controllers
import { KeyboardController } from "./Controllers/KeyboardController";
import { FlightController } from "./Controllers/FlightController";
import { GUIController } from "./Controllers/GUIController";
// TEST
import { InventoryPanel } from "./ScreenControllers/InventoryPanel";
import { DebugLogPanel } from "./ScreenControllers/DebugLogPanel";

//END TEST
// References
import { WCSFolders } from "shared/WCS/Folders";
import { Logger } from "shared/Utility/Logger";
import { CommunicationGod } from "shared/__Cleanup/Experimental/CommunicationGod";
import { EventManager } from "shared/GameAssetManagers";
import { AbilityButton } from "shared/UI/AbilityButton";

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
DebugLogPanel.Create();
//CommunicationGod.Summon();

// Variables
let WCSCharacter: Character | undefined;

// Handle Character Added
function handleCharacterAdded(character: Model) {
	//const wcsCharacter = Character.GetCharacterFromInstance(character);
	//Logger.Log(script, "Client", "Character Added: ", HttpService.JSONEncode(wcsCharacter));
}

// Handle Character Removing
function handleCharacterRemoving(character: Model) {
	//Logger.Log(script,"Client", "Character Removed: ", character);
}

// Check if character exists and perform Character Added event actions
if (Players.LocalPlayer.Character) {
	handleCharacterAdded(Players.LocalPlayer.Character);
}

// Character Added/Removing Events
Players.LocalPlayer.CharacterAdded.Connect(handleCharacterAdded);
Players.LocalPlayer.CharacterRemoving.Connect(handleCharacterRemoving);

Character.CharacterCreated.Connect((character: Character) => {
	WCSCharacter = character;
	WCSCharacter.SkillAdded.Connect((skill: UnknownSkill) => {
		Logger.Log(script, "Client", "Skill Added: ", skill.GetMetadata() as unknown as string);
	});

	const inventoryPanel = InventoryPanel.CreatePanel("Skill");
});

const PlayerCharacterCreated = EventManager.GetEvent("PLAYER_CharacterCreated");
PlayerCharacterCreated.OnClientEvent.Connect(() => {
	const player = Players.LocalPlayer;
	const character = player.Character || player.CharacterAdded.Wait()[0];

	const wcsCharacter = Character.GetCharacterFromInstance(character);
	const skills = wcsCharacter?.GetSkills();
	if (skills) {
		Logger.Log(script, "Client", "PlayerCharacterCreated: ", HttpService.JSONEncode(skills));
	}
	Logger.Log(script, "Client", "PlayerCharacterCreated: ");
});
