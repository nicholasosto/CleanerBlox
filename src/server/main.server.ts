import { CollectionService, Players, Workspace } from "@rbxts/services";
import { CreateServer, Character } from "@rbxts/wcs";
import { DataService } from "./Data/DataService";
import { CharacterConfigurator } from "./Test Ideas/CharacterConfigurator";
import { DefaultMoveset } from "shared/WCS/Movesets/DefaultMoveset";
import { AnimationManager } from "shared/Utility/AnimationManager";
import { WCSFolders } from "shared/WCS/Folders";
import { Logger } from "shared/Utility/Logger";
import { ServerTests } from "./ServerTests";

const dataService = new DataService();

// WCS Server Start
const WCSServer = CreateServer();

WCSServer.RegisterDirectory(WCSFolders.Skills);
WCSServer.RegisterDirectory(WCSFolders.Movesets);
WCSServer.RegisterDirectory(WCSFolders.StatusEffects);

WCSServer.Start();
// WCS Server End

// Server Tests
ServerTests.TestHomingSphere();
// Server Tests End

const characterConfigurator = new CharacterConfigurator();

function handleCharacterAdded(character: Model) {
	// WCS Character setup
	const WCS_Character = new Character(character);
	WCS_Character.ApplySkillsFromMoveset(DefaultMoveset);
	WCS_Character.GetSkills().forEach((skill) => Logger.Log("WCS", "Skill", skill.GetName()));
	// Animation Manager
	AnimationManager.RegisterAnimationsFor(WCS_Character);

	// WCS Cleanup
	const humanoid = character.WaitForChild("Humanoid") as Humanoid;
	humanoid.Died.Connect(() => {
		Logger.Log("WCS", "Character Destroying", character);
		WCS_Character.Destroy();
	});
}

Players.PlayerAdded.Connect((Player) => {
	const userId = Player.UserId;
	Player.CharacterAdded.Connect((character) => {
		handleCharacterAdded(character);
	});
});
