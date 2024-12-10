import { Players } from "@rbxts/services";
// WCS
import { ReplicatedStorage } from "@rbxts/services";
import { CreateClient, WCS_Client } from "@rbxts/wcs";
import { Character } from "@rbxts/wcs";

// WCS Shared Folder
const ParentFolder = ReplicatedStorage.WaitForChild("TS").WaitForChild("WCS");
// WCS Folders
const skillsFolder = ParentFolder.WaitForChild("Skills");
const movesetFolder = ParentFolder.WaitForChild("Movesets");
const statusEffectsFolder = ParentFolder.WaitForChild("StatusEffects");

export class WCSWrapper {
	public wcsCharacter: Promise<Character>;
	public Client: WCS_Client;
    private Player = Players.LocalPlayer;
	constructor() {
		this.Client = CreateClient();

		// Register Folders
		this.RegisterFolders();

        // Get Player Character
        const character = this.Player.Character || this.Player.CharacterAdded.Wait()[0];
		this.wcsCharacter = WCSWrapper.getWCSCharacter(character);
		this.wcsCharacter.then((character) => {
			print("WCSWrapper: WCS Character: ", character.GetAppliedProps());
		});

        return this;
	}
	// Constructor: Register Folders
	private RegisterFolders() {
		if (skillsFolder && movesetFolder && statusEffectsFolder) {
			print("WCSWrapper: Registering Folders");
			this.Client.RegisterDirectory(skillsFolder);
			this.Client.RegisterDirectory(movesetFolder);
			this.Client.RegisterDirectory(statusEffectsFolder);
		}
	}

	// PUBLIC STATIC: Get WCS Character
	public static async getWCSCharacter(characterModel: Model): Promise<Character> {
		const wcsCharacter = Character.GetCharacterFromInstance(characterModel);
		if (wcsCharacter) {
			return wcsCharacter;
		}

		return new Promise<Character>((resolve) => {
			Players.LocalPlayer.CharacterAdded.Connect((newCharacter) => {
				const wcsCharacter = Character.GetCharacterFromInstance(newCharacter);
				if (wcsCharacter) {
					resolve(wcsCharacter);
				}
			});
		});
	}
}
