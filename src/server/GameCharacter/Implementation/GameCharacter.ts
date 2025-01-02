// GameCharacter.ts: Game Character Classes
// BaseGameCharacter: Base Class for Game Characters
// PlayerGameCharacter: Player Character

import { HttpService, ReplicatedStorage } from "@rbxts/services";
import { DataCache, DataManager } from "server/Data/DataManager";
import { Character, DamageContainer, Skill, StatusEffect, UnknownStatus } from "@rbxts/wcs";
import {
	GuiReferenceHandler,
	PackageManager,
	EGuiTemplates,
	EPackageIDs,
	EGUIElements,
	EScreenGuis,
} from "shared/GameAssetManagers";

import { CharacterResource } from "./CharacterResource";

// Data Related Imports
import { TCoreStats } from "shared/SharedReference";
import { ESkillNames } from "shared/WCS/Interfaces/RSkills";
import { AbilityButton } from "shared/UI/AbilityButton";

// Utility Imports
import { ResourceCalculator } from "./Calculators";
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
	public Health: CharacterResource;
	public Mana: CharacterResource;
	public Stamina: CharacterResource;

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
		this.Health = new CharacterResource(this, "Health");
		this.Mana = new CharacterResource(this, "Mana");
		this.Stamina = new CharacterResource(this, "Stamina");

		// Apply Default Moveset
		this.WCS_Character.ApplyMoveset(this._MovesetName);

		// TODO: Add skill buttons to action bar in player gui

		// Initialize Connections
		this.initializeConnections();

		return this;
	}

	protected onStateChange(newState: string) {
		Logger.Log(script, "SuperClass-OnStateChange(): " + newState);
	}

	// Set State
	public SetState(state: string) {
		Logger.Log(script, "SuperClass-SetState(): " + state);
		this.CharacterModel.SetAttribute("State", state);
		this._State = this.CharacterModel.GetAttribute("State") as string;
	}

	// Initialize Connections
	private initializeConnections() {
		this.destroyConnections();
		this._connectionCharacterTakeDamage = this.WCS_Character.DamageTaken.Connect((damage) => {
			Logger.Log(script, "SuperClass-TakeDamage(): " + damage);
			this.handleCharacterTakeDamage(damage);
		});

		this._connectionCharacterDealtDamage = this.WCS_Character.DamageDealt.Connect((enemy, damage) => {
			Logger.Log(script, "SuperClass-DealDamage(): " + damage);
			this.handleCharacterDealtDamage(enemy, damage);
		});

		this._connectionStatusEffectAdded = this.WCS_Character.StatusEffectAdded.Connect((statusEffect) => {
			Logger.Log(script, "SuperClass-StatusEffectAdded(): " + statusEffect);
			this.handleStatusEffectAdded(statusEffect);
		});

		this._connectionStatusEffectRemoved = this.WCS_Character.StatusEffectRemoved.Connect((statusEffect) => {
			Logger.Log(script, "SuperClass-StatusEffectRemoved(): " + statusEffect);
			this.handleStatusEffectRemoved(statusEffect);
		});

		this._connectionStatusEffectStarted = this.WCS_Character.StatusEffectStarted.Connect((statusEffect) => {
			Logger.Log(script, "SuperClass-StatusEffectStarted(): " + statusEffect);
			this.handleStatusEffectStarted(statusEffect);
		});

		this._connectionStatusEffectEnded = this.WCS_Character.StatusEffectEnded.Connect((statusEffect) => {
			Logger.Log(script, "SuperClass-StatusEffectEnded(): " + statusEffect);
			this.handleStatusEffectEnded(statusEffect);
		});
	}

	// Connection Handlers
	private handleCharacterTakeDamage(damageContainer: DamageContainer) {
		Logger.Log(script, "BaseEntity: Take Damage: " + damageContainer.Damage);
		const currentHealth = this.CharacterModel.GetAttribute("HealthCurrent") as number;
		const newHealth = currentHealth - damageContainer.Damage;

		warn("BaseEntity: Current Health: " + currentHealth);
		warn("BaseEntity: New Health: " + newHealth);

		this.Health.SetCurrent(newHealth);
	}

	// Dealt Damage
	private handleCharacterDealtDamage(enemy: Character | undefined, damageContainer: DamageContainer) {
		Logger.Log(script, "BaseEntity: Dealt Damage: ", damageContainer.Damage);
	}

	// Status Effects - Added
	private handleStatusEffectAdded(statusEffect: UnknownStatus) {
		Logger.Log(script, "BaseEntity: Status Effect Added: ", statusEffect.Name);
	}

	// Status Effects - Removed
	private handleStatusEffectRemoved(statusEffect: UnknownStatus) {
		Logger.Log(script, "BaseEntity: Status Effect Removed: ", statusEffect.Name);
	}

	// Status Effects - Started
	private handleStatusEffectStarted(statusEffect: UnknownStatus) {
		Logger.Log(script, "BaseEntity: Status Effect Started: ", statusEffect.Name);
	}

	// Status Effects - Ended
	private handleStatusEffectEnded(statusEffect: UnknownStatus) {
		Logger.Log(script, "BaseEntity: Status Effect Ended: ", statusEffect.Name);
	}

	// Update Attributes
	public updateAttributes() {
		// Set the Max Values
		const MaxStamina = ResourceCalculator.calculateMaxStamina(this.StatsData.Speed, this.StatsData.Level);
		const MaxMana = ResourceCalculator.calculateMaxMana(this.StatsData.Intelligence, this.StatsData.Level);
		const MaxHealth = ResourceCalculator.calculateMaxHealth(this.StatsData.Constitution, this.StatsData.Level);

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
	private _dataCache: DataCache;
	private _playerGui: PlayerGui;
	private _hudGui: ScreenGui;
	private _abilityButtons: Map<string, AbilityButton> = new Map<string, AbilityButton>();
	private _actionBar: Frame;
	private _characterFrame: Frame;

	// Constructor
	constructor(player: Player) {
		// Get Character
		const character = player.Character || player.CharacterAdded.Wait()[0];
		if (character === undefined) {
			Logger.Log(script, "PlayerGameCharacter: Character not found");
			throw "PlayerGameCharacter: Character Model not found";
		}

		// Super Constructor: BaseGameCharacter
		super(character);

		// Assign Player
		this._player = player;

		// DataCache
		this._dataCache = DataManager.GetDataCache(tostring(player.UserId));

		// Assign GUI
		this._playerGui = player.WaitForChild("PlayerGui") as PlayerGui;

		// HUD GUI
		this._hudGui = GuiReferenceHandler.getScreenGui(player, EScreenGuis.HUD);

		// Action Bar
		this._actionBar = GuiReferenceHandler.getUIElement(player, EScreenGuis.HUD, EGUIElements.ActionBar) as Frame;

		// Character Frame
		this._characterFrame = GuiReferenceHandler.getUIElement(
			player,
			EScreenGuis.HUD,
			EGUIElements.CharacterFrame,
		) as Frame;

		// Create Ability Buttons
		this.createAbilityButton(ESkillNames.BasicMelee, 1);

		Logger.Log(
			script,
			"PlayerGameCharacter Created: \n",
			this._characterFrame,
			" ",
			this._actionBar,
			" ",
			this._hudGui,
		);

		this.WCS_Character.GetSkills().forEach((skill) => {
			print(" - ", skill.GetName());
		});
		return this;
	}

	// Create Ability Button
	protected createAbilityButton(skillName: ESkillNames, slot: number) {
		const skill: Skill = this.WCS_Character.GetSkillFromString(skillName) as Skill;
		if (skill === undefined) {
			Logger.Log(script.Name, "Skill not found");
		}

		const abilityButton = new AbilityButton(this._actionBar, skill, slot);

		this._abilityButtons.set(skillName, abilityButton);
		
	}

	// Destroy
	public Destroy() {
		super.Destroy();
	}
}
