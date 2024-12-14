import { Character } from "@rbxts/wcs";
import { IAttachments } from "../Interfaces/IAttachments";
import { ICoreStats } from "shared/Interfaces/IData";
import { EntityResource } from "./EntityResource";
import { EntityAttachments } from "./EntityAttachment";
import * as Calculator from "./EntityCalculator";
import { Logger } from "shared/Utility/Logger";

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

	constructor(rig: Model) {
		// Set the CharacterModel
		this.CharacterModel = rig;

		// WCS Character
		this.WCS_Character = new Character(rig);
		this.WCS_Character.ApplyMoveset("DefaultMoveset");

		// Create the Entity Resources
		this.Health = new EntityResource(rig, "Health", 200, 5, 11);
		this.Mana = new EntityResource(rig, "Mana", 200, 5, 11);
		this.Stamina = new EntityResource(rig, "Stamina", 200, 5, 11);

		// Set the Attachments
		this.EntityAttachments = new EntityAttachments(rig);

		this.setAttributes();

		const humanoid = rig.WaitForChild("Humanoid") as Humanoid;

		humanoid.Died.Connect(() => {
			this.WCS_Character.Destroy();
		});

		return this;
	}

	private setAttributes() {
		Logger.Log("BaseEntity: Setting Attributes: ", this?.CharacterModel);
        const rig = this.CharacterModel;

		// Health Calculation
		const maxHealth = Calculator.calculateMaxHealth(this.StatsData.Constitution, 11);
		this.Health = new EntityResource(rig, "Health", maxHealth, 5, 11);

		// Health Attributes
		// this.CharacterModel.SetAttribute("MaxHealth", this.Health.MaxValue);
		// this.CharacterModel.SetAttribute("CurrentHealth", this.Health.MaxValue);

		// Mana Calculation
		const maxMana = Calculator.calculateMaxMana(this.StatsData.Intelligence, 11);
		this.Mana = new EntityResource(rig,"Mana", maxMana, 5, 11);

		// Mana Attributes
		// this.CharacterModel.SetAttribute("MaxMana", this.Mana.MaxValue);
		// this.CharacterModel.SetAttribute("CurrentMana", this.Mana.MaxValue);

		// Stamina Calculation
		const maxStamina = Calculator.calculateMaxStamina(this.StatsData.Speed, 11);
		this.Stamina = new EntityResource(rig,"Stamina", maxStamina, 5, 11);

		// Stamina Attributes
		// this.CharacterModel.SetAttribute("MaxStamina", this.Stamina.MaxValue);
		// this.CharacterModel.SetAttribute("CurrentStamina", this.Stamina.MaxValue);

		// Stats Attributes
		this.CharacterModel.SetAttribute("Strength", this.StatsData.Strength);
		this.CharacterModel.SetAttribute("Dexterity", this.StatsData.Dexterity);
		this.CharacterModel.SetAttribute("Intelligence", this.StatsData.Intelligence);
	}

	public setTarget(target: Model) {
		this.Target = target;
	}
}
