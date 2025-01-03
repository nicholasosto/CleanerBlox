import { ReplicatedStorage, AssetService } from "@rbxts/services";
import { Logger } from "./Logger";
import { EHumanoidDescription } from "shared/Refrences/Humanoids";
import * as WCS from "@rbxts/wcs";

export class GameStorage {
	// Main Package
	private static _storageModel: Model = ReplicatedStorage.WaitForChild("SoulSteelStorage") as Model;

	// Sub Folders
	private static _accessoriesStorage: Folder = this._storageModel.WaitForChild("ACCESSORIES") as Folder;
	private static _humanoidStorage: Folder = this._storageModel.WaitForChild("HUMANOID") as Folder;
	private static _animationsStorage: Folder = this._storageModel.WaitForChild("ANIMATIONS") as Folder;
	private static _audioStorage: Folder = this._storageModel.WaitForChild("AUDIO") as Folder;
	private static _configurationStorage: Folder = this._storageModel.WaitForChild("CONFIGURATIONS") as Folder;
	private static _guiStorage: Folder = this._storageModel.WaitForChild("GUI") as Folder;
	private static _modelsStorage: Folder = this._storageModel.WaitForChild("MODELS") as Folder;
	private static _toolsStorage: Folder = this._storageModel.WaitForChild("TOOLS") as Folder;
	private static _particlesStorage: Folder = this._storageModel.WaitForChild("PARTICLES") as Folder;

	// HUMANOID STORAGE
	public static cloneHumanoidDescription(humanoidName: EHumanoidDescription): HumanoidDescription | undefined {
		// Get the humanoid from the storage
		const _humanoid = this._humanoidStorage.FindFirstChild(humanoidName, true) as HumanoidDescription;

		// Validate the humanoid
		if (_humanoid === undefined) {
			Logger.Log(script, "GameStorage", `Humanoid ${humanoidName} not found in storage.`);
			return;
		}

		// Clone the humanoid
		const _clonedHumanoid = _humanoid.Clone();
		Logger.Log(script, "XXX Found", _clonedHumanoid);
		return _clonedHumanoid;
	}

	// ACCESSORY STORAGE
	public static cloneAccessory(accessoryName: string): Accessory | undefined {
		// Get the accessory from the storage
		const _accessory = this._accessoriesStorage.FindFirstChild(accessoryName, true) as Accessory;

		// Validate the accessory
		if (_accessory === undefined) {
			Logger.Log(script, "GameStorage", `Accessory ${accessoryName} not found in storage.`);
			return;
		}
		// Clone the accessory
		const _clonedAccessory = _accessory.Clone();

		return _clonedAccessory;
	}

	public static getEvent(event: string): RemoteEvent {
		const _event = ReplicatedStorage.WaitForChild("Asset Package - Remotes").FindFirstChild(
			event,
			true,
		) as RemoteEvent;
		if (!_event) {
			error(`Event ${event} not found in storage.`);
		}
		return _event;
	}

	public static cloneRigCharacter(rigName: string): Model {
		// Get the rig from the storage
		const _rig = this._modelsStorage.FindFirstChild(rigName, true) as Model;

		// Validate the rig
		if (!_rig) {
			this.printAvailableItems(this._modelsStorage);
			error(`Rig ${rigName} not found in storage.`);
		}

		// Clone the rig
		const _clonedRig = _rig.Clone();

		return _clonedRig;
	}

	// ANIMATION STORAGE
	public static cloneAnimation(animationName: string): Animation {
		// Get the animation from the storage
		const _animation = this._animationsStorage.FindFirstChild(animationName, true) as Animation;

		// Validate the animation
		if (!_animation) {
			this.printAvailableItems(this._animationsStorage);
			error(`Animation ${animationName} not found in storage.`);
		}

		return _animation.Clone();
	}

	// AUDIO STORAGE
	public static cloneSound(instanceName: string, parent?: Instance): Sound | undefined {
		// Get the sound from the storage
		const _sound = this._audioStorage.FindFirstChild(instanceName, true) as Sound;

		if (_sound === undefined) {
			Logger.Log(script, "GameStorage", `Sound ${instanceName} not found in storage.`);
			return;
		}
		const _clonedSound = _sound.Clone();
		if (parent) {
			_clonedSound.Parent = parent;
		}

		return _clonedSound;
	}

	// CONFIGURATION STORAGE
	public static cloneConfiguration(configurationName: string): Configuration {
		// Get the configuration from the storage
		const _configuration = this._configurationStorage.FindFirstChild(configurationName, true) as Configuration;

		// Validate the configuration
		if (!_configuration) {
			this.printAvailableItems(this._configurationStorage);
			error(`Configuration ${configurationName} not found in storage.`);
		}

		return _configuration;
	}

	// GUI STORAGE
	public static cloneGUIComponent(guiName: string): GuiObject {
		// Get the GUI from the storage
		const _gui = this._guiStorage.FindFirstChild(guiName, true) as GuiObject;

		// Validate the GUI
		if (!_gui) {
			this.printAvailableItems(this._guiStorage);
			error(`GUI ${guiName} not found in storage.`);
		}

		return _gui.Clone();
	}
	// MODEL STORAGE
	public static cloneModel(modelName: string): Model {
		// Get the model from the storage
		const _model = this._modelsStorage.FindFirstChild(modelName, true) as Model;

		// Validate the model
		if (!_model) {
			this.printAvailableItems(this._modelsStorage);
			error(`Model ${modelName} not found in storage.`);
		}

		return _model.Clone();
	}

	public static cloneTool(toolName: string): Tool {
		// Get the tool from the storage
		const _tool = this._toolsStorage.FindFirstChild(toolName, true) as Tool;

		// Validate the tool
		if (!_tool) {
			this.printAvailableItems(this._modelsStorage);
			error(`Tool ${toolName} not found in storage.`);
		}

		return _tool.Clone();
	}

	// Particles Storage
	public static cloneParticleGroupAttachment(particleGroupName: string): Attachment {
		// Get the particle group part from the storage
		const _particleGroupPart = this._particlesStorage.FindFirstChild(particleGroupName, true)?.Clone() as Part;
		const _attachment = _particleGroupPart?.FindFirstChildWhichIsA("Attachment") as Attachment;

		// Validate the particle group part
		if (!_particleGroupPart) {
			this.printAvailableItems(this._particlesStorage);
			error(`Particle Group Part ${particleGroupName} not found in storage.`);
		}

		return _attachment;
	}

	// HELPER FUNCTIONS
	private static printAvailableItems(storage: Folder) {
		const _items = storage.GetChildren();
		for (const item of _items) {
			if (item.IsA("Folder")) {
				item.GetChildren().forEach((child) => {
					//print(child.Name);
				});
			}
			//print(item.Name);
		}
	}

	public static createSkillButton(wcsSkill: WCS.AnySkill): ImageButton {
		// Create the skill button
		const skillButton = this.cloneGUIComponent("SkillButton") as ImageButton;
		// skillButton.Name = wcsSkill.GetName();
		// skillButton.Image = wcsSkill.StateChanged.Connect((state) => {
		// 	state.StarterParams.
		// skillButton.Size = new UDim2(0, 50, 0, 50);
		// skillButton.Position = new UDim2(0, 0, 0, 0);
		// skillButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		// skillButton.BackgroundTransparency = 0.5;

		// Return the skill button
		return skillButton;
	}

	public static getUniqueModelNameswithinWorkspace(): string[] {
		const modelNames: string[] = [];
		const workspaceModels = game.Workspace.GetChildren();
		for (const model of workspaceModels) {
			if (model.IsA("Model")) {
				modelNames.push(model.Name);
			}
		}
		return modelNames;
	}
}
