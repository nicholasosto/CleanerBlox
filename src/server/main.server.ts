import { Players } from "@rbxts/services";
import { CreateServer } from "@rbxts/wcs";
import { DataManager } from "./Data/DataManager";
import { WCSFolders } from "shared/WCS/Folders";
import { Logger } from "shared/Utility/Logger";
import { EntityManager } from "./Entity/EntityManager";
import { GameStorage } from "shared/Utility/GameStorage";
import { AIInstanceCreator } from "./AI/AIInstanceCreator";
import { TagGod } from "./TagClasses/TagGod";
import { HttpService } from "@rbxts/services";
import { NotificationManager } from "./Notification/NotificationManager";

DataManager.Start();
EntityManager.Start();
AIInstanceCreator.Start();
TagGod.Start();
NotificationManager.Start();

// WCS Server Start
const WCSServer = CreateServer();
WCSServer.RegisterDirectory(WCSFolders.Skills);
WCSServer.RegisterDirectory(WCSFolders.Movesets);
WCSServer.RegisterDirectory(WCSFolders.StatusEffects);
WCSServer.Start();

// Handle Character Added
function handleCharacterAdded(character: Model) {
	Logger.Log("Main", "Character Added");
	const JSONTestString = HttpService.JSONEncode(WCSServer);
	const player = Players.GetPlayerFromCharacter(character) as Player;
	NotificationManager.Notify(player, "Welcome to the game!");
}

// Handle Player Added
function handlePlayerAdded(player: Player) {
	player.CharacterAdded.Connect(handleCharacterAdded);
}

// Connect Player Added
Players.PlayerAdded.Connect(handlePlayerAdded);
