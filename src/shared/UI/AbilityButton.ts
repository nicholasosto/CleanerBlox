// AbilityButton Class

// GameStorage
import { GameStorage } from "shared/Utility/GameStorage";
import { SignalButton } from "./SignalButton";
import { ProgressBar } from "./ProgressBar";
import { Character } from "@rbxts/wcs";
import { EffectList } from "shared/Effects/TEffect";

// Template
const Template = GameStorage.getGUI("Ability Button Template") as Frame;

// Attribute Label Class
export class AbilityButton {
	// Private Variables
	private _instance: Frame = Template.Clone();
	private _imageButton: ImageButton = this._instance.FindFirstChild("ImageButton", true) as ImageButton;
	private _progressBarFrame: Frame = this._instance.FindFirstChild("Progress Bar", true) as Frame;
	private _wcsSkillName: string;
	public signalButton: SignalButton = new SignalButton(this._imageButton, { name:"DUMMY", holdable: true });

	// Uninitialized Variables
	private _parent: Instance | undefined;
	private _wcsCharacter: Character | undefined;
	private _connection: RBXScriptConnection | undefined;

	// Constructor
	constructor(displayName: string, wcsSkillName: string, imageId: string) {
		this._imageButton.SetAttribute("Image", imageId);
		this._progressBarFrame.SetAttribute("TextValue", displayName);
		this._instance.Name = displayName;
		this._wcsSkillName = wcsSkillName;
		
	}

	// Called from UIService to create the Attribute Label
	public create(parent: Instance) {
		this._instance.Parent = parent;
		// Set the connections
		this.setConnections();
	}

	// Set Connections
	private setConnections() {
		// Set the connections
		this._connection = this._imageButton.Activated.Connect(() => {
			const player = game.GetService("Players").LocalPlayer;
			const character = player.Character;
			EffectList.BlackHole_01.playEffect(character?.FindFirstChild("HumanoidRootPart") as Instance);
			print("Ability Button Activated");
		});
	}
}
