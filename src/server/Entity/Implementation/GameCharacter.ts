// GameCharacter.ts: Game Character Classes
// BaseGameCharacter: Base Class for Game Characters
// PlayerGameCharacter: Player Character

import { HttpService, ReplicatedStorage } from "@rbxts/services";
import { Character, DamageContainer, StatusEffect, UnknownStatus } from "@rbxts/wcs";

// Entity Related Imports
import { IAttachments } from "../Interfaces/IAttachments";
import { EntityAttachments } from "./EntityAttachment";
import { EntityResource } from "./EntityResource";

// Data Related Imports
import { TCoreStats } from "shared/SharedReference";
import { DataTemplate } from "server/Data/DataTemplate";

// Utility Imports
import * as Calculator from "./EntityCalculator";
import { Logger } from "shared/Utility/Logger";

// BaseGameCharacter (NPCs and Players inherit from this)
export class BaseGameCharacter {
	// Public Properties
	// Character Properties
	public CharacterName: string;
	public CharacterModel: Model;
	public WCS_Character: Character;
	public Target: Model | undefined;

	// Stats
	public StatsData: TCoreStats = {
		Strength: 10,
		Dexterity: 10,
		Intelligence: 10,
		Constitution: 10,
		Speed: 10,
		Level: 1,
		Experience: 0,
		ExperienceToNextLevel: 100,
		AttributePoints: 0,
	};

	// Resources
	public Health: EntityResource;
	public Mana: EntityResource;
	public Stamina: EntityResource;

	// Protected Properties
	protected _State: string = "Idle";
	protected _MovesetName = "DefaultMoveset";

	// Connections
	private _connectionCharacterTakeDamage: RBXScriptConnection | undefined;
	private _connectionCharacterDealtDamage: RBXScriptConnection | undefined;
	private _connectionStatusEffectAdded: RBXScriptConnection | undefined;
	private _connectionStatusEffectRemoved: RBXScriptConnection | undefined;
	private _connectionStatusEffectStarted: RBXScriptConnection | undefined;
	private _connectionStatusEffectEnded: RBXScriptConnection | undefined;

	// Constructor
	constructor(characterModel: Model, characterName: string = "Default Character Name") {
		// Assign Character Name
		this.CharacterName = characterName;

		// Assign Character Model
		this.CharacterModel = characterModel;
		if (this.CharacterModel === undefined) {
			throw "BaseGameCharacter: Character Model not found";
		}

		// Create WCS Character
		this.WCS_Character = new Character(characterModel);

		// Create Resources: Health, Mana, Stamina
		this.Health = new EntityResource(this.CharacterModel, "Health", 100, 1, 10);
		this.Mana = new EntityResource(this.CharacterModel, "Mana", 100, 1, 10);
		this.Stamina = new EntityResource(this.CharacterModel, "Stamina", 100, 1, 10);

		// Apply Default Moveset
		this.WCS_Character.ApplyMoveset(this._MovesetName);

		// Initialize Connections
		this.initializeConnections();

		return this;
	}

	protected onStateChange(newState: string) {
		Logger.Log("SuperClass-OnStateChange(): " + newState);
	}

	// Set State
	public SetState(state: string) {
		Logger.Log("SuperClass-SetState(): " + state);
		this.CharacterModel.SetAttribute("State", state);
		this._State = this.CharacterModel.GetAttribute("State") as string;
	}

	// Initialize Connections
	private initializeConnections() {
		this.destroyConnections();
		this._connectionCharacterTakeDamage = this.WCS_Character.DamageTaken.Connect((damage) => {
			Logger.Log("SuperClass-TakeDamage(): " + damage);
			this.handleCharacterTakeDamage(damage);
		});

		this._connectionCharacterDealtDamage = this.WCS_Character.DamageDealt.Connect((enemy, damage) => {
			Logger.Log("SuperClass-DealDamage(): " + damage);
			this.handleCharacterDealtDamage(enemy, damage);
		});

		this._connectionStatusEffectAdded = this.WCS_Character.StatusEffectAdded.Connect((statusEffect) => {
			Logger.Log("SuperClass-StatusEffectAdded(): " + statusEffect);
			this.handleStatusEffectAdded(statusEffect);
		});

		this._connectionStatusEffectRemoved = this.WCS_Character.StatusEffectRemoved.Connect((statusEffect) => {
			Logger.Log("SuperClass-StatusEffectRemoved(): " + statusEffect);
			this.handleStatusEffectRemoved(statusEffect);
		});

		this._connectionStatusEffectStarted = this.WCS_Character.StatusEffectStarted.Connect((statusEffect) => {
			Logger.Log("SuperClass-StatusEffectStarted(): " + statusEffect);
			this.handleStatusEffectStarted(statusEffect);
		});

		this._connectionStatusEffectEnded = this.WCS_Character.StatusEffectEnded.Connect((statusEffect) => {
			Logger.Log("SuperClass-StatusEffectEnded(): " + statusEffect);
			this.handleStatusEffectEnded(statusEffect);
		});
	}

	// Connection Handlers
	private handleCharacterTakeDamage(damageContainer: DamageContainer) {
		Logger.Log("BaseEntity: Take Damage: " + damageContainer.Damage);
		const currentHealth = this.CharacterModel.GetAttribute("HealthCurrent") as number;
		const newHealth = currentHealth - damageContainer.Damage;

		warn("BaseEntity: Current Health: " + currentHealth);
		warn("BaseEntity: New Health: " + newHealth);

		this.Health.setCurrentValue(newHealth);
	}

	// Dealt Damage
	private handleCharacterDealtDamage(enemy: Character | undefined, damageContainer: DamageContainer) {
		Logger.Log("BaseEntity: Dealt Damage: ", damageContainer.Damage);
	}

	// Status Effects - Added
	private handleStatusEffectAdded(statusEffect: UnknownStatus) {
		Logger.Log("BaseEntity: Status Effect Added: ", statusEffect.Name);
	}

	// Status Effects - Removed
	private handleStatusEffectRemoved(statusEffect: UnknownStatus) {
		Logger.Log("BaseEntity: Status Effect Removed: ", statusEffect.Name);
	}

	// Status Effects - Started
	private handleStatusEffectStarted(statusEffect: UnknownStatus) {
		Logger.Log("BaseEntity: Status Effect Started: ", statusEffect.Name);
	}

	// Status Effects - Ended
	private handleStatusEffectEnded(statusEffect: UnknownStatus) {
		Logger.Log("BaseEntity: Status Effect Ended: ", statusEffect.Name);
	}

	// Update Attributes
	public updateAttributes() {
		// Set the Max Values
		const MaxStamina = Calculator.calculateMaxStamina(this.StatsData.Speed, 11);
		const MaxMana = Calculator.calculateMaxMana(this.StatsData.Intelligence, 11);
		const MaxHealth = Calculator.calculateMaxHealth(this.StatsData.Constitution, 11);

		// Set the Stats Attributes
		this.CharacterModel.SetAttribute("Strength", this.StatsData.Strength);
		this.CharacterModel.SetAttribute("Dexterity", this.StatsData.Dexterity);
		this.CharacterModel.SetAttribute("Intelligence", this.StatsData.Intelligence);
		this.CharacterModel.SetAttribute("Constitution", this.StatsData.Constitution);
		this.CharacterModel.SetAttribute("Speed", this.StatsData.Speed);
	}

	// Destroy Connections
	private destroyConnections() {
		this._connectionCharacterTakeDamage?.Disconnect();
		this._connectionCharacterDealtDamage?.Disconnect();
		this._connectionStatusEffectAdded?.Disconnect();
		this._connectionStatusEffectRemoved?.Disconnect();
		this._connectionStatusEffectStarted?.Disconnect();
		this._connectionStatusEffectEnded?.Disconnect();
	}

	// Destroy Object
	public Destroy() {
		this.Health.Destroy();
		this.Mana.Destroy();
		this.Stamina.Destroy();
		this.destroyConnections();
		this.WCS_Character.Destroy();
	}
}

// PlayerGameCharacter (Inherits from BaseGameCharacter)
export class PlayerGameCharacter extends BaseGameCharacter {
	// Private
	private _player: Player;
	private _playerGui: PlayerGui;

	// Constructor
	constructor(player: Player) {
		// Get Character
		const character = player.Character || player.CharacterAdded.Wait()[0];
		if (character === undefined) {
			Logger.ErrorLog("PlayerGameCharacter: Character Model not found");
			throw "PlayerGameCharacter: Character Model not found";
		}

		// Super Constructor
		super(character);

		// Assign Player
		this._player = player;

		// Assign PlayerGui
		this._playerGui = player.WaitForChild("PlayerGui") as PlayerGui;

		Logger.Log(script.Name, "PlayerGameCharacter Created: " + player.Name);

		return this;
	}

	// Destroy
	public Destroy() {
		super.Destroy();
	}
}

