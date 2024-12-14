import { Players } from "@rbxts/services";
import { CreateServer } from "@rbxts/wcs";
import { DataManager } from "./Data/DataManager";
import { WCSFolders } from "shared/WCS/Folders";
import { Logger } from "shared/Utility/Logger";
import { EntityManager } from "./Entity/EntityManager";

//const dataService = new DataService();

DataManager.Start();
EntityManager.Start();

// WCS Server Start
const WCSServer = CreateServer();
WCSServer.RegisterDirectory(WCSFolders.Skills);
WCSServer.RegisterDirectory(WCSFolders.Movesets);
WCSServer.RegisterDirectory(WCSFolders.StatusEffects);
WCSServer.Start();

// Handle Character Added
function handleCharacterAdded(character: Model) {
	Logger.Log("Main", "Character Added");
}

// Handle Player Added
function handlePlayerAdded(player: Player) {
	// Call DataManager OnPlayerJoined to load player data to the DataCache
	DataManager.RegisterPlayer(player);

	// Handle Character Added
	player.CharacterAdded.Connect(handleCharacterAdded);
}

// Connect Player Added
Players.PlayerAdded.Connect(handlePlayerAdded);
