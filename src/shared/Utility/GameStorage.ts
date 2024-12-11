import { ReplicatedStorage } from "@rbxts/services";

export class GameStorage {
	// Main Package
	private static _storageModel: Model = ReplicatedStorage.WaitForChild("SoulSteelStorage") as Model;

	// Sub-Packages

	// Accessory Storage
	private static _accessoriesStorage: Folder = this._storageModel.WaitForChild("ACCESSORIES") as Folder;

	// Animation Storage
	private static _animationsStorage: Folder = this._storageModel.WaitForChild("ANIMATIONS") as Folder;

	// Audio
	private static _audioStorage: Folder = this._storageModel.WaitForChild("AUDIO") as Folder;

	// Configuration
	private static _configurationStorage: Folder = this._storageModel.WaitForChild("CONFIGURATIONS") as Folder;

	// GUI
	private static _guiStorage: Folder = this._storageModel.WaitForChild("GUI") as Folder;

	// Models
	private static _modelsStorage: Folder = this._storageModel.WaitForChild("MODELS") as Folder;

	// Particles
	private static _particlesStorage: Folder = this._storageModel.WaitForChild("PARTICLES") as Folder;

	// ACCESSORY STORAGE
	public static getAccessory(accessoryName: string): Model {
		// Get the accessory from the storage
		const _accessory = this._accessoriesStorage.FindFirstChild(accessoryName, true) as Model;

		// Validate the accessory
		if (!_accessory) {
			this.printAvailableItems(this._accessoriesStorage);
			error(`Accessory ${accessoryName} not found in storage.`);
		}

		return _accessory;
	}

	// ANIMATION STORAGE
	public static getAnimation(animationName: string): Animation {
		// Get the animation from the storage
		const _animation = this._animationsStorage.FindFirstChild(animationName, true) as Animation;

		// Validate the animation
		if (!_animation) {
			this.printAvailableItems(this._animationsStorage);
			error(`Animation ${animationName} not found in storage.`);
		}

		return _animation;
	}

	// AUDIO STORAGE
	public static getAudio(audioName: string): Sound {
		// Get the audio from the storage
		const _audio = this._audioStorage.FindFirstChild(audioName, true) as Sound;

		// Validate the audio
		if (!_audio) {
			this.printAvailableItems(this._audioStorage);
			error(`Audio ${audioName} not found in storage.`);
		}

		return _audio;
	}

	// CONFIGURATION STORAGE
	public static getConfiguration(configurationName: string): Configuration {
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
	public static getGUI(guiName: string): GuiObject {
		// Get the GUI from the storage
		const _gui = this._guiStorage.FindFirstChild(guiName, true) as GuiObject;

		// Validate the GUI
		if (!_gui) {
			this.printAvailableItems(this._guiStorage);
			error(`GUI ${guiName} not found in storage.`);
		}

		return _gui;
	}

	// MODEL STORAGE
	public static getModel(modelName: string): Model {
		// Get the model from the storage
		const _model = this._modelsStorage.FindFirstChild(modelName, true) as Model;

		// Validate the model
		if (!_model) {
			this.printAvailableItems(this._modelsStorage);
			error(`Model ${modelName} not found in storage.`);
		}

		return _model;
	}

	// Particles Storage
	public static getParticleGroupPart(particleGroupName: string): Part {
		// Get the particle group part from the storage
		const _particleGroupPart = this._particlesStorage.FindFirstChild(particleGroupName, true) as Part;

		// Validate the particle group part
		if (!_particleGroupPart) {
			this.printAvailableItems(this._particlesStorage);
			error(`Particle Group Part ${particleGroupName} not found in storage.`);
		}

		return _particleGroupPart;
	}

	// HELPER FUNCTIONS
	private static printAvailableItems(storage: Folder) {
		const _items = storage.GetChildren();
		for (const item of _items) {
			if (item.IsA("Folder")) {
				item.GetChildren().forEach((child) => {
					print(child.Name);
				});
			}
			print(item.Name);
		}
	}
}
