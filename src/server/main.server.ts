import { ReplicatedStorage, Players } from "@rbxts/services";
import { CreateServer, Character } from "@rbxts/wcs";
import { DefaultMoveset } from "shared/WCS/Movesets/DefaultMoveset";
import { DataService } from "./Data/DataService";
import { PlayerData } from "../shared/TS_Types";
import { CharacterConfigurator } from "./Test Ideas/CharacterConfigurator";

const dataService = new DataService();
const skillsFolder = ReplicatedStorage.FindFirstChild("Skills", true);
const movesetFolder = ReplicatedStorage.FindFirstChild("Movesets", true);
const statusEffectsFolder = ReplicatedStorage.FindFirstChild("StatusEffects", true);

const Server = CreateServer();

if (skillsFolder && movesetFolder && statusEffectsFolder) {
	Server.RegisterDirectory(skillsFolder);
	Server.RegisterDirectory(movesetFolder);
	Server.RegisterDirectory(statusEffectsFolder);
}

Server.Start();

const characterConfigurator = new CharacterConfigurator();

Players.PlayerAdded.Connect((Player) => {
	const userId = Player.UserId;

	Player.CharacterAdded.Connect((CharacterModel) => {
		// apply the wrap when character model gets created
		const WCS_Character = new Character(CharacterModel);

		const spotlightButton: ImageButton = Player.WaitForChild("PlayerGui").WaitForChild("Action Bar").FindFirstChild("SpotlightButton",true) as ImageButton;
		print("SpotlightButton: ",spotlightButton);

		
		WCS_Character.ApplyMoveset(DefaultMoveset);
		WCS_Character.SkillStarted.Connect((skill) => {
			print(`Skill ${skill.GetName()} started`);
		});

		spotlightButton.Activated.Connect(() => {
			print("Spotlight Button Activated");
			WCS_Character.GetSkillFromString("Spotlights")?.Start();
			
		});

		// destroy it when humanoid dies
		const humanoid = CharacterModel.WaitForChild("Humanoid") as Humanoid;
		humanoid.Died.Once(() => WCS_Character.Destroy());
	});
});
