import { ReplicatedStorage, Players } from "@rbxts/services";
import { ProgressBar } from "../../shared/UI/ProgressBar";
import { ColorGradients, AttributeLabels, AbilityButtons } from "../../shared/UI/UIEnums";
import { Character } from "@rbxts/wcs";

const localPlayer = Players.LocalPlayer as Player;

export class UIService {
	private static _player: Player = localPlayer;
	private static _playerGui: PlayerGui = this._player.WaitForChild("PlayerGui") as PlayerGui;

	// Progress Bars GUI
	private static _progressBarGui: ScreenGui = this._playerGui.WaitForChild("Bars") as ScreenGui;
	private static _progressBarParent: Frame = this._progressBarGui.WaitForChild("ParentFrame") as Frame;

	// Attribute Labels GUI
	private static _attributeLabelGui: ScreenGui = this._playerGui.WaitForChild("Attributes") as ScreenGui;
	private static _attributeLabelParent: Frame = this._attributeLabelGui
		.WaitForChild("MasterFrame")
		.WaitForChild("ParentFrame") as Frame;

	// ActionBar GUI
	private static _actionBarGui: ScreenGui = this._playerGui.WaitForChild("Action Bar") as ScreenGui;

	private static _instance: UIService;

	private constructor() {
		// Private Constructor
	}

	// Start
	public static Start(): void {
		print("Starting UI Service");

		print(" ** Creating Attribute Bars **");
		UIService.AddAttributeBars();

		print(" ** Createing Attribute Labels **");
		UIService.AddAttributeLabels();

		print(" ** Loading Toggle Buttons **");

	}

	// Add Attribute Bars and Progression Bars
	public static AddAttributeBars(): void {
		print("** Creating Progress Bars **");

		// Health Bar
		const healthBar = new ProgressBar(
			this._player,
			"CurrentHealth",
			"MaxHealth",
			this._progressBarParent,
			"Health",
			ColorGradients.Rust,
		);

		// Mana Bar
		const manaBar = new ProgressBar(
			this._player,
			"CurrentMana",
			"MaxMana",
			this._progressBarParent,
			"Mana",
			ColorGradients.Mana,
		);

		// Stamina Bar
		const staminaBar = new ProgressBar(
			this._player,
			"CurrentStamina",
			"MaxStamina",
			this._progressBarParent,
			"Stamina",
			ColorGradients.Stamina,
		);

		// Experience Bar
		const experienceBar = new ProgressBar(
			this._player,
			"Experience",
			"ExperienceToNextLevel",
			this._progressBarParent,
			"Experience",
			ColorGradients.Experience,
		);
		print("** Progress Bars Created **");
	}

	// Add Attribute Labels
	public static AddAttributeLabels(): void {
		AttributeLabels.Strength.create(this._attributeLabelParent, this._player);
		AttributeLabels.Speed.create(this._attributeLabelParent, this._player);
		AttributeLabels.Dexterity.create(this._attributeLabelParent, this._player);
		AttributeLabels.Intelligence.create(this._attributeLabelParent, this._player);
		AttributeLabels.Constitution.create(this._attributeLabelParent, this._player);
		AttributeLabels.Level.create(this._attributeLabelParent, this._player);
		AttributeLabels.Experience.create(this._attributeLabelParent, this._player);
		AttributeLabels.ExperienceToNextLevel.create(this._attributeLabelParent, this._player);
		AttributeLabels.MaxHealth.create(this._attributeLabelParent, this._player);
		AttributeLabels.MaxMana.create(this._attributeLabelParent, this._player);
		AttributeLabels.MaxStamina.create(this._attributeLabelParent, this._player);
	}

	// Load Action Bar
	public static LoadActionBar(): void {

		const ActionBarCells: Array<Frame> = new Array<Frame>();
		const Cell_01: Frame = this._actionBarGui.FindFirstChild("Cell-01",true) as Frame;
		const Cell_02: Frame = this._actionBarGui.FindFirstChild("Cell-02",true) as Frame;
		const Cell_03: Frame = this._actionBarGui.FindFirstChild("Cell-03",true) as Frame;
		const Cell_04: Frame = this._actionBarGui.FindFirstChild("Cell-04",true) as Frame;
		const Cell_05: Frame = this._actionBarGui.FindFirstChild("Cell-05",true) as Frame;

		ActionBarCells.push(Cell_01);
		ActionBarCells.push(Cell_02);
		ActionBarCells.push(Cell_03);
		ActionBarCells.push(Cell_04);
		ActionBarCells.push(Cell_05);

		ActionBarCells.forEach((cell) => {
			const newCell = new Instance("Frame") as Frame;

			newCell.Size = new UDim2(2.2,0,2,0);
			newCell.Position = new UDim2(0,0,0,0);
			newCell.BackgroundColor3 = new Color3(0,0,0);
			newCell.Name = "Dummy";
			newCell.Parent = cell;
		});


		AbilityButtons.Spotlights.create(Cell_03);
		print("Loading Action Bar");
	}
}
