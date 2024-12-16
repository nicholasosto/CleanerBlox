// import { ReplicatedStorage, Players } from "@rbxts/services";
// import { ProgressBar } from "../../shared/UI/ProgressBar";
// import { GameStorage } from "../../shared/Utility/GameStorage";
// import { Character } from "@rbxts/wcs";
// import { Logger } from "shared/Utility/Logger";

// const localPlayer = Players.LocalPlayer as Player;

// export class UIController {
// 	private static _player: Player = localPlayer;
// 	private static _playerGui: PlayerGui = this._player.WaitForChild("PlayerGui") as PlayerGui;

// 	// Progress Bars GUI
// 	private static _progressBarGui: ScreenGui = this._playerGui.WaitForChild("Bars") as ScreenGui;
// 	private static _progressBarParent: Frame = this._progressBarGui.WaitForChild("ParentFrame") as Frame;

// 	// Attribute Labels GUI
// 	private static _attributeLabelGui: ScreenGui = this._playerGui.WaitForChild("Attributes") as ScreenGui;
// 	private static _attributeLabelParent: Frame = this._attributeLabelGui
// 		.WaitForChild("MasterFrame")
// 		.WaitForChild("ParentFrame") as Frame;

// 	// ActionBar GUI
// 	private static _actionBarGui: ScreenGui = this._playerGui.WaitForChild("Action Bar") as ScreenGui;

// 	private static _instance: UIController;

// 	private constructor() {
// 		// Private Constructor
// 	}

// 	// Start
// 	public static Start(): void {
// 		UIController.AddAttributeBars();
// 		UIController.AddAttributeLabels();
// 	}

// 	// Add Attribute Bars and Progression Bars
// 	public static AddAttributeBars(): void {
// 		let _character: Model | undefined = this._player.Character;
// 		if (this._player.Character) {
// 			_character = this._player.Character;
// 		} else {
// 			_character = this._player.CharacterAdded.Wait()[0];
// 		}

// 		if (_character === undefined) return;

// 		let heathAttribute = _character.GetAttribute("MaxHealth");
// 		while (heathAttribute === undefined) {
// 			heathAttribute = _character.GetAttribute("MaxHealth");
// 			Logger.Log("UIController", "Waiting for MaxHealth Attribute");
// 			task.wait(1);
// 		}

// 		// Health Bar
// 		const healthBar = new ProgressBar(
// 			_character,
// 			"HealthCurrent",
// 			"HeathMax",
// 			this._progressBarParent,
// 			"Health",
// 			ColorGradients.Rust,
// 		);

// 		// Mana Bar
// 		const manaBar = new ProgressBar(
// 			_character,
// 			"ManaCurrent",
// 			"ManaMax",
// 			this._progressBarParent,
// 			"Mana",
// 			ColorGradients.Mana,
// 		);

// 		// Stamina Bar
// 		const staminaBar = new ProgressBar(
// 			_character,
// 			"StaminaCurrent",
// 			"StaminaMax",
// 			this._progressBarParent,
// 			"Stamina",
// 			ColorGradients.Stamina,
// 		);

// 		// Experience Bar
// 		const experienceBar = new ProgressBar(
// 			this._player,
// 			"Experience",
// 			"ExperienceToNextLevel",
// 			this._progressBarParent,
// 			"Experience",
// 			ColorGradients.Experience,
// 		);
// 	}

// 	// Add Attribute Labels
// 	public static AddAttributeLabels(): void {
// 		const character = this._player.Character as Model;
// 		const characterAttributes = character.GetAttributes();
// 		characterAttributes.forEach((attribute) => {

// 		AttributeLabels.Strength.create(this._attributeLabelParent, character);
// 		AttributeLabels.Speed.create(this._attributeLabelParent, character);
// 		AttributeLabels.Dexterity.create(this._attributeLabelParent, character);
// 		AttributeLabels.Intelligence.create(this._attributeLabelParent, character);
// 		AttributeLabels.Constitution.create(this._attributeLabelParent, character);
// 		AttributeLabels.Level.create(this._attributeLabelParent, character);
// 		AttributeLabels.Experience.create(this._attributeLabelParent, character);
// 		AttributeLabels.ExperienceToNextLevel.create(this._attributeLabelParent, character);
// 		AttributeLabels.MaxHealth.create(this._attributeLabelParent, character);
// 		AttributeLabels.MaxMana.create(this._attributeLabelParent, character);
// 		AttributeLabels.MaxStamina.create(this._attributeLabelParent, character);
// 	}

// 	// Load Action Bar
// 	public static LoadActionBar(): void {
// 		const ActionBarCells: Array<Frame> = new Array<Frame>();
// 		const Cell_01: Frame = this._actionBarGui.FindFirstChild("Cell-01", true) as Frame;
// 		const Cell_02: Frame = this._actionBarGui.FindFirstChild("Cell-02", true) as Frame;
// 		const Cell_03: Frame = this._actionBarGui.FindFirstChild("Cell-03", true) as Frame;
// 		const Cell_04: Frame = this._actionBarGui.FindFirstChild("Cell-04", true) as Frame;
// 		const Cell_05: Frame = this._actionBarGui.FindFirstChild("Cell-05", true) as Frame;

// 		ActionBarCells.push(Cell_01);
// 		ActionBarCells.push(Cell_02);
// 		ActionBarCells.push(Cell_03);
// 		ActionBarCells.push(Cell_04);
// 		ActionBarCells.push(Cell_05);

// 		ActionBarCells.forEach((cell) => {
// 			const newCell = new Instance("Frame") as Frame;

// 			newCell.Size = new UDim2(2.2, 0, 2, 0);
// 			newCell.Position = new UDim2(0, 0, 0, 0);
// 			newCell.BackgroundColor3 = new Color3(0, 0, 0);
// 			newCell.Name = "Dummy";
// 			newCell.Parent = cell;
// 		});

// 		AbilityButtons.Spotlights.create(Cell_03);
// 	}
// }
