import { ReplicatedStorage, Players, Workspace } from "@rbxts/services";
import { CreateServer, Character } from "@rbxts/wcs";
import { DataService } from "./Data/DataService";
import { CharacterConfigurator } from "./Test Ideas/CharacterConfigurator";
import { DefaultMoveset } from "shared/WCS/Movesets/DefaultMoveset";
import { AnimationManager } from "shared/Utility/AnimationManager";

const dataService = new DataService();
const skillsFolder = ReplicatedStorage.FindFirstChild("Skills", true);
const movesetFolder = ReplicatedStorage.FindFirstChild("Movesets", true);
const statusEffectsFolder = ReplicatedStorage.FindFirstChild("StatusEffects", true);

const ToadiesFolder = Workspace.WaitForChild("ToadArmy") as Model;

const WCSServer = CreateServer();

if (skillsFolder && movesetFolder && statusEffectsFolder) {
	WCSServer.RegisterDirectory(skillsFolder);
	WCSServer.RegisterDirectory(movesetFolder);
	WCSServer.RegisterDirectory(statusEffectsFolder);
}

WCSServer.Start();

const characterConfigurator = new CharacterConfigurator();

Players.PlayerAdded.Connect((Player) => {
	const userId = Player.UserId;

	Player.CharacterAdded.Connect((CharacterModel) => {
		// apply the wrap when character model gets created
		const WCS_Character = new Character(CharacterModel);
		const ToadieModels: Model[] = ToadiesFolder.GetChildren().filter((child): child is Model => child.IsA("Model"));
		const WCS_Toadies: Character[] = [];

		ToadieModels.forEach((ToadieModel) => { 
			const ToadieCharacter = new Character(ToadieModel);
			WCS_Toadies.push(ToadieCharacter);
			ToadieCharacter.ApplySkillsFromMoveset(DefaultMoveset);
			AnimationManager.RegisterAnimationsFor(ToadieCharacter);
		});

		WCS_Character.ApplySkillsFromMoveset(DefaultMoveset);
		AnimationManager.RegisterAnimationsFor(WCS_Character);
		

		// destroy it when humanoid dies
		const humanoid = CharacterModel.WaitForChild("Humanoid") as Humanoid;
		humanoid.Died.Once(() => WCS_Character.Destroy());
	});
});
