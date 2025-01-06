// Roblox Services
import { Players, CollectionService } from "@rbxts/services";
import { BaseGameCharacter } from "server/GameCharacter/Classes/BaseGameCharacter";
// WCS System
import { Character, CreateServer } from "@rbxts/wcs";
import { WCSFolders } from "shared/WCS/Folders";

// Custom Imports
import { DataManager } from "./Data/DataManager";
//import { InventoryService } from "./Services/InventoryService";
import { GameCharacterRegistry } from "./GameCharacter/CharacterManager";
//import { NotificationManager } from "./Notification/NotificationManager";
//import { Logger } from "shared/Utility/Logger";


//Services Needing to Start
DataManager.Start();

// Inventory Service
//InventoryService.Start();

// Entity Manager
GameCharacterRegistry.Start();
GameCharacterRegistry.Start();

// Notification Manager
//NotificationManager.Start();

// WCS Server Start
const WCSServer = CreateServer();
WCSServer.RegisterDirectory(WCSFolders.Skills);
WCSServer.RegisterDirectory(WCSFolders.Movesets);
WCSServer.RegisterDirectory(WCSFolders.StatusEffects);
WCSServer.Start();

// TESTING

const NPCCollection = CollectionService.GetTagged("NPCCharacter");
NPCCollection.forEach((npc) => {
	const npcCharacter = new BaseGameCharacter(npc as Model);
	//Logger.Log(script.Name, "NPC Character: ", npcCharacter.CharacterName);
});

// END OF TESTING

// Handle Character Added
function handleCharacterAdded(character: Model) {
	//Logger.Log(script.Name, "Character Added: ", character);
}

// Handle Player Added
function handlePlayerAdded(player: Player) {
	player.CharacterAdded.Connect(handleCharacterAdded);
}

// Connect Player Added
Players.PlayerAdded.Connect(handlePlayerAdded);

Character.CharacterCreated.Connect((character) => {
	//Logger.Log(script.Name, "WCS Character Created");
});

