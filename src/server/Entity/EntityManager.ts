/* eslint-disable prettier/prettier */
import { Players } from "@rbxts/services";
import { StatsData } from "shared/Interfaces/IData";
import { DataManager, DataCache } from "server/Data/DataManager";
import { EntityResource } from "server/Entity/Subclasses/EntityResource";
import * as Calculator from "./AttributeCalculations";
import { Logger } from "shared/Utility/Logger";
import { HttpService } from "@rbxts/services";
import { Character } from "@rbxts/wcs";
import { GameStorage } from "shared/Utility/GameStorage";


interface IEntityResources {
	Health: EntityResource;
	Mana: EntityResource;
	Stamina: EntityResource;
}

interface IEntityAttachments {
	Head: Attachment;
	LeftHand: Attachment;
	RightHand: Attachment;
	LeftFoot: Attachment;
	RightFoot: Attachment;
	Floor: Attachment;
	Halo: Attachment;
	Body: Attachment;
}

export class EntityAttachments implements IEntityAttachments {
	Head: Attachment;
	LeftHand: Attachment;
	RightHand: Attachment;
	LeftFoot: Attachment;
	RightFoot: Attachment;
	Floor: Attachment;
	Halo: Attachment;
	Body: Attachment;

	constructor(rigModel: Model) {
		this.Body = rigModel.FindFirstChild("LowerTorso")?.FindFirstChild("WaistCenterAttachment") as Attachment;
		this.Head = rigModel.FindFirstChild("Head")?.FindFirstChild("HairAttachment") as Attachment;
		this.LeftHand = rigModel.FindFirstChild("LeftHand")?.FindFirstChild("LeftGripAttachment") as Attachment;
		this.RightHand = rigModel.FindFirstChild("RightHand")?.FindFirstChild("RightGripAttachment") as Attachment;
		this.LeftFoot = rigModel.FindFirstChild("LeftFoot")?.FindFirstChild("LeftFootAttachment") as Attachment;
		this.RightFoot = rigModel.FindFirstChild("RightFoot")?.FindFirstChild("RightFootAttachment") as Attachment;
		this.Floor = rigModel.FindFirstChild("Floor")?.FindFirstChild("FloorAttachment") as Attachment;
		this.Halo = rigModel.FindFirstChild("Head")?.FindFirstChild("HaloAttachment") as Attachment;

		if (!this.Halo) {
			this.Halo = new Instance("Attachment");
			this.Halo.Name = "HaloAttachment";
			this.Halo.Position = new Vector3(0, 2, 0);
			this.Halo.Parent = rigModel.FindFirstChild("Head") as BasePart;
		}

		if (!this.Floor) {
			this.Floor = new Instance("Attachment");
			this.Floor.Name = "FloorAttachment";
			this.Floor.Position = new Vector3(0, -2, 0);
			this.Floor.Parent = rigModel.FindFirstChild("HumanoidRootPart") as BasePart;
		}

		if (
			!this.Body ||
			!this.Head ||
			!this.LeftHand ||
			!this.RightHand ||
			!this.LeftFoot ||
			!this.RightFoot ||
			!this.Floor ||
			!this.Halo
		) {
			throw "EntityAttachments: One or more attachments are missing";
		}
	}
}

export class BaseEntity {
	// CharacterModel
	CharacterModel: Model;
	WCS_Character: Character;

	// Object Values
	Target: Model | undefined;

	// Attachments
	EntityAttachments: IEntityAttachments;

	// Data with default values
	StatsData: StatsData = {
		Strength: 10,
		Dexterity: 10,
		Intelligence: 10,
		Constitution: 10,
		Speed: 10,
	};

	// Resources with default values
	EntityResources: IEntityResources = {
		Health: new EntityResource("Health", 200, 5, 11),
		Mana: new EntityResource("Mana", 200, 5, 11),
		Stamina: new EntityResource("Stamina", 200, 5, 11),
	};

	constructor(rig: Model) {
		// Set the CharacterModel
		this.CharacterModel = rig;

		// WCS Character
		this.WCS_Character = new Character(rig);

		this.WCS_Character.ApplyMoveset("DefaultMoveset");

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

		// Health Calculation
		const maxHealth = Calculator.calculateMaxHealth(this.StatsData.Constitution, 11);
		this.EntityResources.Health = new EntityResource("Health", maxHealth, 5, 11);

		// Health Attributes
		this.CharacterModel.SetAttribute("MaxHealth", this.EntityResources.Health.MaxValue);
		this.CharacterModel.SetAttribute("CurrentHealth", this.EntityResources.Health.MaxValue);

		// Mana Calculation
		const maxMana = Calculator.calculateMaxMana(this.StatsData.Intelligence, 11);
		this.EntityResources.Mana = new EntityResource("Mana", maxMana, 5, 11);
		
		// Mana Attributes
		this.CharacterModel.SetAttribute("MaxMana", this.EntityResources.Mana.MaxValue);
		this.CharacterModel.SetAttribute("CurrentMana", this.EntityResources.Mana.MaxValue);

		// Stamina Calculation
		const maxStamina = Calculator.calculateMaxStamina(this.StatsData.Speed, 11);
		this.EntityResources.Stamina = new EntityResource("Stamina", maxStamina, 5, 11);
		 
		// Stamina Attributes
		this.CharacterModel.SetAttribute("MaxStamina", this.EntityResources.Stamina.MaxValue);
		this.CharacterModel.SetAttribute("CurrentStamina", this.EntityResources.Stamina.MaxValue);

		// Stats Attributes
		this.CharacterModel.SetAttribute("Strength", this.StatsData.Strength);
		this.CharacterModel.SetAttribute("Dexterity", this.StatsData.Dexterity);
		this.CharacterModel.SetAttribute("Intelligence", this.StatsData.Intelligence);
	}

	public setTarget(target: Model) {
		this.Target = target;
	}
}

export class EntityManager {
	private static _instance: EntityManager;
	private static _entities: Map<string, BaseEntity> = new Map<string, BaseEntity>();
	private static _connectionCharacterAdded: RBXScriptConnection;

	private constructor() {
		EntityManager._connectionCharacterAdded = Players.PlayerAdded.Connect((player) => {

			
			player.CharacterAdded.Connect((character) => {

				const entity = new BaseEntity(character);

				EntityManager._entities.set(character.Name, entity);

				const testAttachmentGroup = GameStorage.cloneParticleGroupAttachment("C - BLOOD SPLATTER");
				testAttachmentGroup.Parent = entity.EntityAttachments.Head;
				
			});
		});
	}

	public static Start() {
		this.GetInstance();
	}
	private static GetInstance(): EntityManager {
		if (EntityManager._instance === undefined) {
			EntityManager._instance = new EntityManager();
		}

		return EntityManager._instance;
	}

	public static CreateEntity(rig: Model) {
		const entity = new BaseEntity(rig);
		EntityManager._entities.set(rig.Name, entity);
	}

	public static GetEntity(name: string): BaseEntity {
		return EntityManager._entities.get(name) as BaseEntity;
	}

	public static RemoveEntity(name: string) {
		EntityManager._entities.delete(name);
	}
}
