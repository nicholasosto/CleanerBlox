// Roblox Services
import { Players, HttpService, Workspace, CollectionService } from "@rbxts/services";

// WCS System
import { Character, CreateServer } from "@rbxts/wcs";
import { WCSFolders } from "shared/WCS/Folders";

// Custom Imports
import { DataManager } from "./Data/DataManager";
import { InventoryService } from "./Services/InventoryService";
import { GameCharacterRegistry } from "./GameCharacter/CharacterManager";
import { NotificationManager } from "./Notification/NotificationManager";
import { PackageManager, EPackageIDs } from "shared/GameAssetManagers";
import { Logger } from "shared/Utility/Logger";

//Test Imports
import { BaseGameCharacter } from "./GameCharacter/Classes/BaseGameCharacter";
//END OF IMPORTS

//Services Needing to Start
DataManager.Start();

// Inventory Service
InventoryService.Start();

// Entity Manager
GameCharacterRegistry.Start();

// Notification Manager
NotificationManager.Start();

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
	Logger.Log(script.Name, "NPC Character: ", npcCharacter.CharacterName);
});

// END OF TESTING

// Handle Character Added
function handleCharacterAdded(character: Model) {
	Logger.Log(script.Name, "Character Added: ", character);
}

// Handle Player Added
function handlePlayerAdded(player: Player) {
	player.CharacterAdded.Connect(handleCharacterAdded);
}

// Connect Player Added
Players.PlayerAdded.Connect(handlePlayerAdded);

Character.CharacterCreated.Connect((character) => {
	Logger.Log(script.Name, "WCS Character Created");
	const contents = PackageManager.LoadPackage(EPackageIDs.NPC)?.GetChildren();
	const contentChild = contents?.[0]?.GetChildren();
	contentChild?.forEach((child) => {
		child.Parent = Workspace;
	});
});

/*
// Test Functions
function getAIResponse(prompt: string) {
	const apiKey = "sk-...";
	const response = HttpService.RequestAsync({
		Url: "https://api.openai.com/v1/chat/completions",
		Method: "POST",
		Headers: {
			"Content-Type": "application/json",
			Authorization: `Bearer ${apiKey}`,
		},
		Body: HttpService.JSONEncode({
			model: "gpt-3.5-turbo",
			messages: [{ role: "user", content: prompt }],
		}),
	});
	return HttpService.JSONDecode(response.Body);
}
*/
