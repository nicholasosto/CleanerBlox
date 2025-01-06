// GameCharacter.ts: Game Character Classes
// BaseGameCharacter: Base Class for Game Characters
// PlayerGameCharacter: Player Character
import { Character, DamageContainer, UnknownStatus } from "@rbxts/wcs";
import { CharacterResource } from "../Subclasses/CharacterResource";
import { EAnimations, CharacterAnimations } from "shared/_References/Animations";
import { CharacterStats, getDefaultCharacterStats } from "shared/_References/Character/CharacterStats";


// Utility Imports
import { Logger } from "shared/Utility/Logger";
import { BasicHold } from "shared/WCS/Skills/BasicHold";
import { BasicRanged } from "shared/WCS/Skills/BasicRanged";
import { BasicMelee } from "shared/WCS/Skills/BasicMelee";

export type CharacterState =
	| "Idle"
	| "Walking"
	| "Running"
	| "Jumping"
	| "Falling"
	| "Crouching"
	| "Sprinting"
	| "Dead";

// BaseGameCharacter (NPCs and Players inherit from this)
export class BaseGameCharacter {
	// Public Properties
	// Character Properties
	public CharacterName: string;
	public CharacterModel: Model;
	public Animator: Animator;
	public Animations = CharacterAnimations;
	public AnimationTracks = new Map<EAnimations, AnimationTrack>();
	public WCS_Character: Character;
	public Target: Model | undefined;

	// Stats
	public CharacterStats: CharacterStats;

	// Resources
	public Health: CharacterResource;
	public Mana: CharacterResource;
	public Stamina: CharacterResource;

	// Protected Properties
	protected _State: CharacterState = "Idle";
	//protected _Moveset: Moveset;

	// WCS Character Connections
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
		this.CharacterStats = getDefaultCharacterStats();

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

		// Create Resources: Health, Mana, Stamina
		this.Health = new CharacterResource(this, "Health");
		this.Mana = new CharacterResource(this, "Mana");
		this.Stamina = new CharacterResource(this, "Stamina");

		// Assign Skills
		new BasicMelee(this.WCS_Character);
		new BasicHold(this.WCS_Character);
		new BasicRanged(this.WCS_Character);
		// Initialize Connections
		this.initializeConnections();
		this._LoadAnimations();
		do{
			this._PlayAnimation(EAnimations.SKILL_BasicMelee);
			wait(1);
		} while (this.AnimationTracks !== undefined);

		return this;
	}

	protected _AssignSkills(skillNames: string[]) {
		// TODO: Assign skills via skill names
	}

	// Animation Methods
	protected _LoadAnimations() {
		// Load Animations
		for (const [animationName, animation] of pairs(CharacterAnimations)) {
			animation.Parent = this.CharacterModel;
			animation.Name = animationName as string;
			const animationTrack = this.Animator.LoadAnimation(animation);
			this.AnimationTracks.set(animationName as EAnimations, animationTrack);
		}
	}
	protected _PlayAnimation(animationName: EAnimations) {

		Logger.Log(script, "SuperClass-PlayAnimation(): " + animationName);
		this.AnimationTracks.forEach((animationTrack) => {
			animationTrack.Stop();
		});

		const animationTrack = this.AnimationTracks.get(animationName);
		if (animationTrack) {
			animationTrack.Play();
		}
	}

	// State System Methods
	protected onStateChange(newState: string) {
		Logger.Log(script, "SuperClass-OnStateChange(): " + newState);
	}

	public SetState(state: string) {
		Logger.Log(script, "SuperClass-SetState(): " + state);
		this.CharacterModel.SetAttribute("State", state);
		this._State = this.CharacterModel.GetAttribute("State") as CharacterState;
	}

	// Update Attributes
	public updateAttributes() {
		// Set the Stats Attributes
		this.CharacterModel.SetAttribute("Strength", this.CharacterStats.Strength);
		this.CharacterModel.SetAttribute("Dexterity", this.CharacterStats.Dexterity);
		this.CharacterModel.SetAttribute("Intelligence", this.CharacterStats.Intelligence);
		this.CharacterModel.SetAttribute("Constitution", this.CharacterStats.Constitution);
		this.CharacterModel.SetAttribute("Speed", this.CharacterStats.Speed);
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
