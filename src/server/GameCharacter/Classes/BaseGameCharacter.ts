// GameCharacter.ts: Game Character Classes
// BaseGameCharacter: Base Class for Game Characters
// PlayerGameCharacter: Player Character
import {
	Character,
	DamageContainer,
	Moveset,
	Skill,
	StatusEffect,
	UnknownStatus,
	CreateMoveset,
	SkillBase,
	UnknownSkill,
} from "@rbxts/wcs";
import { CharacterResource } from "../Subclasses/CharacterResource";

// Data Related Imports
import { TCoreStats } from "shared/SharedReference";
import { AnimationHelper, EAnimations } from "shared/_References/GameReference";
import { ESkillNames } from "shared/WCS/Interfaces/RSkills";
import { AbilityButton } from "shared/UI/AbilityButton";

// Utility Imports
import { ResourceCalculator } from "../Subclasses/Calculators";
import { Logger } from "shared/Utility/Logger";
import { BasicHold } from "shared/WCS/Skills/BasicHold";
import { BasicRanged } from "shared/WCS/Skills/BasicRanged";
import { BasicMelee } from "shared/WCS/Skills/BasicMelee";
import * as GameReference from "shared/_References/GameReference";

// BaseGameCharacter (NPCs and Players inherit from this)
export class BaseGameCharacter {
	// Public Properties
	// Character Properties
	public CharacterName: string;
	public CharacterModel: Model;
	public Animator: Animator;
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
	//protected _Moveset: Moveset;

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

		// Assign Animator
		this.Animator = this.CharacterModel.FindFirstChild("Animator", true) as Animator;
		if (this.Animator === undefined) {
			throw "BaseGameCharacter: Animator not found";
		}
		// Create WCS Character
		this.WCS_Character = new Character(characterModel);
		//this._Moveset = CreateMoveset("_DefaultMoveset", [BasicMelee, BasicHold]);
		//this.WCS_Character.ApplyMoveset(this._Moveset);

		// Create Resources: Health, Mana, Stamina
		this.Health = new CharacterResource(this, "Health");
		this.Mana = new CharacterResource(this, "Mana");
		this.Stamina = new CharacterResource(this, "Stamina");

		// Apply Default Moveset
		//this.WCS_Character.ApplyMoveset(this._MovesetName);
		new BasicMelee(this.WCS_Character);
		new BasicHold(this.WCS_Character);
		const skillConfig = GameReference.SkillConfigurations[ESkillNames.BasicRanged];
		Logger.Log(script, "Message", skillConfig.ImageId);

		// Initialize Connections
		this.initializeConnections();

		return this;
	}

	protected _AssignSkills(skillNames: string[]) {
		// TODO: Assign skills via skill names
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

	// Load Animation Tracks
	private loadAnimationTracks() {
		// Load Animation Tracks
		const animationTrack = AnimationHelper.CreateAnimationTrack(this.CharacterModel, EAnimations.COMBAT_Damage);
		animationTrack.Looped = true;
		animationTrack.Play();
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
