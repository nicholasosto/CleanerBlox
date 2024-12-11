import { Players } from "@rbxts/services";
// WCS
import { WCSFolders } from "../shared/WCS/Folders";
import { ReplicatedStorage } from "@rbxts/services";
import { CreateClient, WCS_Client } from "@rbxts/wcs";
import { Character } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";

// WCS Shared Folder
const ParentFolder = ReplicatedStorage.WaitForChild("TS").WaitForChild("WCS");
// WCS Folders
// const skillsFolder = ParentFolder.WaitForChild("Skills");
// const movesetFolder = ParentFolder.WaitForChild("Movesets");
// const statusEffectsFolder = ParentFolder.WaitForChild("StatusEffects");

export class WCSWrapper {
	private static _instance: WCSWrapper;
	public static wcsCharacter: Character | undefined;
	public Client: WCS_Client;
	private Player = Players.LocalPlayer;

	private constructor() {
		Logger.Log("Wrapper", "Wrapper Created");
		this.Client = CreateClient();

		// Register Folders
		this.Client.RegisterDirectory(WCSFolders.Skills);
		this.Client.RegisterDirectory(WCSFolders.Movesets);
		this.Client.RegisterDirectory(WCSFolders.StatusEffects);

		return this;
	}

	public static Start() {
		Logger.Log("WCS", "Start");
		if (WCSWrapper._instance) {
			Logger.Log("WCS", "WCS Already Started");
			return WCSWrapper._instance;
		}

		Logger.Log("WCS", "WCS Starting");
		WCSWrapper._instance = new WCSWrapper();

		return WCSWrapper._instance;
	}

	public static RegisterCharacter(character: Model) {
		Logger.Log("WCS", "Register Character: ", character);
		const WCS_Character = new Character(character);
	}

	public static OnCharacterAdded(character: Model) {
		Logger.Log("WCSX", "Character Added: ", character);
		// apply the wrap when character model gets created
		WCSWrapper.wcsCharacter = new Character(character);
		Logger.Log("WCS", "WCS", WCSWrapper.wcsCharacter);
		// destroy it when humanoid dies
		const humanoid = character.WaitForChild("Humanoid") as Humanoid;

		humanoid.Died.Once(() => {
			if (WCSWrapper.wcsCharacter) {
				WCSWrapper.wcsCharacter.Destroy();
			}
		});
	}

	public async getWCSCharacter(characterModel: Model): Promise<Character> {
		const character = Character.GetCharacterFromInstance(characterModel);
		return new Promise((resolve) => {
			resolve(character as Character);
		});
	}
}
