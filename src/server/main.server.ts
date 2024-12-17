import { Players } from "@rbxts/services";
import { CreateServer } from "@rbxts/wcs";
import { DataManager } from "./Data/DataManager";
import { WCSFolders } from "shared/WCS/Folders";
import { Logger } from "shared/Utility/Logger";
import { EntityManager } from "./Entity/EntityManager";
import { CommunicationGod } from "shared/Events/CommunicationGod";

import { GameStorage } from "shared/Utility/GameStorage";

// Test imports
import { AssetService } from "@rbxts/services";
import { PositionGenerator } from "shared/Utility/PositionGenerator";

//const dataService = new DataService();

DataManager.Start();
EntityManager.Start();
CommunicationGod.Summon();

// WCS Server Start
const WCSServer = CreateServer();
WCSServer.RegisterDirectory(WCSFolders.Skills);
WCSServer.RegisterDirectory(WCSFolders.Movesets);
WCSServer.RegisterDirectory(WCSFolders.StatusEffects);
WCSServer.Start();

// Handle Character Added
function handleCharacterAdded(character: Model) {
	Logger.Log("Main", "Character Added");
	warn("GameModels");
	GameStorage.getUniqueModelNameswithinWorkspace().forEach((name) => {
		print(name);
	});

	const humanoid: Humanoid = character.WaitForChild("Humanoid") as Humanoid;

	const connection = humanoid.HealthChanged.Connect((health) => {
		warn("Health Changed: ", health);
	});

	const connection2: RBXScriptConnection = humanoid.StateChanged.Connect((oldState, newState) => {
		warn("State Changed: ");
		print(oldState," ==> " ,newState);
	});
}

// Handle Player Added
function handlePlayerAdded(player: Player) {
	// Call DataManager OnPlayerJoined to load player data to the DataCache
	//DataManager.RegisterPlayer(player);

	// Handle Character Added
	player.CharacterAdded.Connect(handleCharacterAdded);
}

// Connect Player Added
Players.PlayerAdded.Connect(handlePlayerAdded);
