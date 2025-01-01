
// Roblox Services
import { Players, HttpService } from "@rbxts/services";

// WCS System
import { Character, CreateServer } from "@rbxts/wcs";
import { WCSFolders } from "shared/WCS/Folders";

// Custom Imports
import { DataManager } from "./Data/DataManager";
import { InventoryService } from "./Services/InventoryService";
import { EntityManager } from "./Entity/EntityManager";
import { NotificationManager } from "./Notification/NotificationManager";
import { Logger } from "shared/Utility/Logger";


//Services Needing to Start
DataManager.Start();

// Inventory Service
InventoryService.Start();

// Entity Manager
EntityManager.Start();

// Notification Manager
NotificationManager.Start();

// WCS Server Start
const WCSServer = CreateServer();
WCSServer.RegisterDirectory(WCSFolders.Skills);
WCSServer.RegisterDirectory(WCSFolders.Movesets);
WCSServer.RegisterDirectory(WCSFolders.StatusEffects);
WCSServer.Start();
/*
// Handle Character Added
function handleCharacterAdded(character: Model) {
	Logger.Log("Character Added", character.Name);
}

// Handle Player Added
function handlePlayerAdded(player: Player) {
	player.CharacterAdded.Connect(handleCharacterAdded);
}

// Connect Player Added
Players.PlayerAdded.Connect(handlePlayerAdded);

Character.CharacterCreated.Connect((character) => {
	warn("WCS Character Created", character);
});


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