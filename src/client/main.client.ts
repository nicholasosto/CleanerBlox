// Game Services
import { Players, ReplicatedStorage } from "@rbxts/services";
import { KeyboardClient } from "./Keyboard";
import { UIService } from "./UI/UIService";
import { Character, CreateClient } from "@rbxts/wcs";
import { WCSFolders } from "shared/WCS/Folders";
import { Logger } from "shared/Utility/Logger";
import { ClientSkillManager } from "./ClientSkillManager";
import { SkillsData } from "shared/Interfaces/IData";

// Events
 const connectionSkillSlotRequest = ReplicatedStorage.FindFirstChild("SKILL_GetSlots", true) as RemoteEvent;
// const connectionSkillInventoryRequest = ReplicatedStorage.FindFirstChild("SKILL_GetInventory", true) as RemoteEvent;
 //const connectionAssignSlotRequest = ReplicatedStorage.FindFirstChild("SKILL_AssignSlot", true) as RemoteEvent;

 ClientSkillManager.Start();
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
	const playerGui = Players.LocalPlayer.WaitForChild("PlayerGui");


	Logger.Log("Client", "Character Added: ", character);
	const wcsCharacter = Character.GetLocalCharacter();

	wcsCharacter?.GetSkills().forEach((skill) => Logger.Log("Client", "Skill", skill.GetName()));

	connectionSkillSlotRequest.FireServer(Players.LocalPlayer);

	task.wait(1);

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

// connectionSkillSlotRequest.OnClientEvent.Connect((data: SkillsData) => {
// 	Logger.Log("Client", "Skill Slots", data);
// 	const SkillInventoryScroller = playerGui.WaitForChild("Developer").WaitForChild("SkillsInventory").WaitForChild("InventoryItems");
	
// });