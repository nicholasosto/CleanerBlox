import { Character } from "@rbxts/wcs";
import { IAttachments } from "../Interfaces/IAttachments";
import { ICoreStats } from "shared/Interfaces/IData";
import { EntityResource } from "./EntityResource";
import { EntityAttachments } from "./EntityAttachment";
import * as Calculator from "./EntityCalculator";
import { Logger } from "shared/Utility/Logger";
import { HttpService, ReplicatedStorage } from "@rbxts/services";
import { ProgressBar } from "shared/UI/ProgressBar";

export class AbilityButton {
	private _imageId: string | undefined;
	private _progressBar: Frame | undefined;
	private _imageButton: ImageButton | undefined;
	constructor(displayName:string, imageId: string, frame: Frame) {
		Logger.Log("AbilityButton: Constructing");
		this._imageId = imageId;
		this._progressBar = frame.FindFirstChild("Progress Bar",true) as Frame;
		this._imageButton = frame.FindFirstChild("ImageButton",true) as ImageButton;
		if(this._imageButton === undefined || this._progressBar === undefined) {
			Logger.Log("AbilityButton: Image Button not found");
			return;
		}

		this._progressBar.SetAttribute("TextValue",displayName);
	}
}

export class BaseEntity {
	// CharacterModel
	CharacterModel: Model;
	WCS_Character: Character;

	// Object Values
	Target: Model | undefined;

	// Attachments
	EntityAttachments: IAttachments;

	// Data with default values
	StatsData: ICoreStats = {
		Level: 1,
		Strength: 10,
		Dexterity: 10,
		Intelligence: 10,
		Constitution: 10,
		Speed: 10,
	};

	// Resources with default values
	public Health: EntityResource;
	public Mana: EntityResource;
	public Stamina: EntityResource;

	// Max Values TODO: Possibly move to a different class
	public MaxHealth: number = 15;
	public MaxMana: number = 15;
	public MaxStamina: number = 15;

	// Events
	private _eventEntityCreated: RemoteEvent = ReplicatedStorage.WaitForChild("Remotes").WaitForChild(
		"ENTITY_Created",
	) as RemoteEvent;
	private _eventEntityDestroyed: RemoteEvent = ReplicatedStorage.WaitForChild("Remotes").WaitForChild(
		"ENTITY_Destroyed",
	) as RemoteEvent;

	constructor(rig: Model) {
		// Set the CharacterModel
		this.CharacterModel = rig;

		// WCS Character
		this.WCS_Character = new Character(rig);
		this.WCS_Character.ApplyMoveset("DefaultMoveset");

		const skill = this.WCS_Character.GetSkillFromString("ShapeTester");

		
		
		
		// Set the Attachments
		this.EntityAttachments = new EntityAttachments(rig);

		this.updateAttributes();

		// Set the Resources
		this.Stamina = new EntityResource(this.CharacterModel, "Stamina", this.MaxStamina, 1, 10);
		this.Mana = new EntityResource(this.CharacterModel, "Mana", this.MaxMana, 1, 10);
		this.Health = new EntityResource(this.CharacterModel, "Health", this.MaxHealth, 1, 10);

		const humanoid = rig.WaitForChild("Humanoid") as Humanoid;

		const player = this.WCS_Character.Player as Player;
		const playerGui = player.WaitForChild("PlayerGui") as PlayerGui;
		const hudScreen = playerGui.WaitForChild("HUD") as ScreenGui;
		const abilitySlotsFrame = (hudScreen.FindFirstChild("AbilitySlots",true) as Frame).GetChildren();
		const abilitySlots = abilitySlotsFrame.filter((child) => child.IsA("Frame"));

		abilitySlots.forEach((slot) => {
			const abilityButton = new AbilityButton("ShapeTester","102596975485791",slot as Frame);
		});
		if (player) {
			this._eventEntityCreated.FireClient(player);
		}

		humanoid.Died.Connect(() => {
			const player = this.WCS_Character.Player;
			if (player) {
				this._eventEntityDestroyed.FireClient(player);
			}
			this.Destroy();
		});

		return this;
	}

	private updateAttributes() {
		// Set the Max Values
		this.MaxStamina = Calculator.calculateMaxStamina(this.StatsData.Speed, 11);
		this.MaxMana = Calculator.calculateMaxMana(this.StatsData.Intelligence, 11);
		this.MaxHealth = Calculator.calculateMaxHealth(this.StatsData.Constitution, 11);

		// Set the Stats Attributes
		this.CharacterModel.SetAttribute("Strength", this.StatsData.Strength);
		this.CharacterModel.SetAttribute("Dexterity", this.StatsData.Dexterity);
		this.CharacterModel.SetAttribute("Intelligence", this.StatsData.Intelligence);
		this.CharacterModel.SetAttribute("Constitution", this.StatsData.Constitution);
		this.CharacterModel.SetAttribute("Speed", this.StatsData.Speed);
	}

	public setTarget(target: Model) {
		this.Target = target;
	}

	public Destroy() {
		//Logger.Log("BaseEntity: Destroying: ", this?.CharacterModel);
		this.Health.Destroy();
		this.Mana.Destroy();
		this.Stamina.Destroy();
		this.WCS_Character.Destroy();
	}
}
