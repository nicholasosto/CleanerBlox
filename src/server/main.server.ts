import { Logger } from "shared/Utility/Logger";
import { Players, RunService, HttpService } from "@rbxts/services";
import { Character, CreateServer } from "@rbxts/wcs";
import { DataManager } from "./Data/DataManager";
import { InventoryService } from "./Services/InventoryService";
import { WCSFolders } from "shared/WCS/Folders";
import { EntityManager } from "./Entity/EntityManager";
import { AIInstanceCreator } from "./AI/AIInstanceCreator";
import { TagGod } from "./TagClasses/TagGod";
import { NotificationManager } from "./Notification/NotificationManager";
import { TEventSuccessResponse } from "shared/SharedReference";
import { NPCController } from "./NPC/NPCController";
import { GameStorage } from "shared/Utility/GameStorage";
import { BasicMelee } from "shared/WCS/Skills/BasicMelee";


// Data and Data related services
DataManager.Start();
InventoryService.Start();

// Entity Manager
EntityManager.Start();

// Notification Manager
NotificationManager.Start();

// Testing OK to remove if necessary
AIInstanceCreator.Start();
TagGod.Start();

// WCS Server Start
const WCSServer = CreateServer();
WCSServer.RegisterDirectory(WCSFolders.Skills);
WCSServer.RegisterDirectory(WCSFolders.Movesets);
WCSServer.RegisterDirectory(WCSFolders.StatusEffects);
WCSServer.Start();

// NPC Testing
function runNPCTesting(character: Model) {
	const NPCModel = game.Workspace.WaitForChild("First_Boss") as Model;

	NPCModel?.PivotTo(character.GetPivot());

	if (NPCModel) {
		const NPC = new NPCController(NPCModel);

		NPC.rigModel.FindFirstChild("RightUpperArm")?.Destroy();
	} else {
		Logger.Log("Main", "NPC Model not found");
	}
}

// Handle Character Added
function handleCharacterAdded(character: Model) {
	Logger.Log("Main", "Character Added");
	runNPCTesting(character);
	const player = Players.GetPlayerFromCharacter(character) as Player;
	const response: TEventSuccessResponse = {
		success: true,
		message: "Character Added",
	};

	NotificationManager.Notify(player, response);
}

// Handle Player Added
function handlePlayerAdded(player: Player) {
	player.CharacterAdded.Connect(handleCharacterAdded);
	reduceHealth();
}

// Connect Player Added
Players.PlayerAdded.Connect(handlePlayerAdded);

function reduceHealth() {
	let characters = Character.GetCharacterMap();
	while (characters.size() < 1) {
		wait(1);
		Logger.Log("Main", "Waiting for Characters, size: " + characters.size());
		characters = Character.GetCharacterMap();
	}

	characters.forEach((character) => {
		character.DamageTaken.Connect((damage) => {
			Logger.Log("Main", "XDamage Taken: " + damage.Damage);
		});
	});

	do {
		characters.forEach((character) => {
			const MeleeSkill = character.GetSkillFromConstructor(BasicMelee);
			const DamageContainer = MeleeSkill?.DamageContainer;
			if (DamageContainer === undefined) {
				Logger.Log("Main", "No Damage Container Found");
				return;
			}

			const damage = character.TakeDamage(DamageContainer);
			Logger.Log("Main", "Damage Taken: " + damage.Damage);
		});

		wait(1);
	} while (characters.size() > 0);
}

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
