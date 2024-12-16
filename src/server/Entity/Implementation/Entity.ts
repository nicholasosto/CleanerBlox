import { Character } from "@rbxts/wcs";
import { IAttachments } from "../Interfaces/IAttachments";
import { ICoreStats } from "shared/Interfaces/IData";
import { EntityResource } from "./EntityResource";
import { EntityAttachments } from "./EntityAttachment";
import * as Calculator from "./EntityCalculator";
import { Logger } from "shared/Utility/Logger";
import { HttpService, ReplicatedStorage } from "@rbxts/services";
import { SkillConfigurations } from "shared/WCS/Interfaces/SkillConfigurations";

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
		
		// Set the Attachments
		this.EntityAttachments = new EntityAttachments(rig);

		this.updateAttributes();

		// Set the Resources
		this.Stamina = new EntityResource(this.CharacterModel, "Stamina", this.MaxStamina, 1, 10);
		this.Mana = new EntityResource(this.CharacterModel, "Mana", this.MaxMana, 1, 10);
		this.Health = new EntityResource(this.CharacterModel, "Health", this.MaxHealth, 1, 10);

		const humanoid = rig.WaitForChild("Humanoid") as Humanoid;

		const player = this.WCS_Character.Player as Player;

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
		Logger.Log("BaseEntity: Destroying: ", this?.CharacterModel);
		this.Health.Destroy();
		this.Mana.Destroy();
		this.Stamina.Destroy();
		this.WCS_Character.Destroy();
	}
}
