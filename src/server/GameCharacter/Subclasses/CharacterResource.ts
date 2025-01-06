// Roblox Services
import { RunService } from "@rbxts/services";

// Custom Imports
import { BaseGameCharacter } from "../Classes/BaseGameCharacter";

export enum EResourceTypes {
	Health = "Health",
	Mana = "Mana",
	Stamina = "Stamina",
	Experience = "Experience",
	DomainEnergy = "DomainEnergy",
}

export class CharacterResourceBar {
	private _progressBarFrame: Frame;

	constructor(progressBarFrame: Frame, name: EResourceTypes) {
		this._progressBarFrame = progressBarFrame;
		this._progressBarFrame.SetAttribute("TextValue", name);
		this._progressBarFrame.SetAttribute("BarPercent", 100);
	}

	public setProgressByValues(currentValue: number, maxValue: number) {
		this._progressBarFrame.SetAttribute("BarPercent", (currentValue / maxValue) * 100);
	}

	public setProgressByPercent(percentage: number) {
		this._progressBarFrame.SetAttribute("BarPercent", percentage);
	}
}

export class CharacterResource {
	public GameCharacter: Instance;

	public Name: string = "DefaultResource";
	public AttributeNameCurrent: string = "DefaultResourceCurrent";
	public AttributeNameMax: string = "DefaultResourceMax";

	// Resource Values
	private _maxValue: number = 100;
	private _currentValue: number = 100;

	// Regen Values
	private _regenRate: number = 1;
	private _regenAmount: number = 10;
	private _regenActive: boolean = true;
	private _lastRegenTick: number = 0;

	// Resource Bar instance
	private _resourceBar: CharacterResourceBar | undefined;

	// Connections
	private _heartbeatConnection: RBXScriptConnection | undefined;
	private _minChangeConnection: RBXScriptConnection | undefined;
	private _maxChangeConnection: RBXScriptConnection | undefined;

	constructor(gameCharacter: BaseGameCharacter, resourceName: string) {
		// Parent GameCharacter
		this.GameCharacter = gameCharacter.CharacterModel;

		// Attribute Names and Values
		this.Name = resourceName;
		this.AttributeNameCurrent = this.Name + "Current";
		this.AttributeNameMax = this.Name + "Max";

		// Create Attributes on the GameCharacter
		this.GameCharacter.SetAttribute(this.AttributeNameMax, this._maxValue);
		this.GameCharacter.SetAttribute(this.AttributeNameCurrent, this._currentValue);

		// initializeConnections
		this._initializeConnections();
		this._onResourceChange();
		return this;
	}

	// Initialize Connections
	private _initializeConnections() {
		// Disconnect Connections if they exist
		this._disconnectConnections();

		//Heartbeat Connection
		this._heartbeatConnection = RunService.Heartbeat.Connect((dt) => {
			this._regenStep();
		});

		// Min Change Connection
		this._minChangeConnection = this.GameCharacter.GetAttributeChangedSignal(this.Name + "Current").Connect(() => {
			//Logger.Log(script,"CharacterResource", this.Name, this._currentValue);
			this._onResourceChange();
		});

		// Max Change Connection
		this._maxChangeConnection = this.GameCharacter.GetAttributeChangedSignal(this.Name + "Max").Connect(() => {
			//Logger.Log(script,"CharacterResource", this.Name, this._maxValue);
			this._onResourceChange();
		});
	}

	// Set Max Value
	public SetMax(value: number) {
		this._maxValue = value;
		this.GameCharacter.SetAttribute(this.Name + "Max", value);
	}

	// Set Current Value
	public SetCurrent(value: number) {
		this._currentValue = value;
		this.GameCharacter.SetAttribute(this.Name + "Current", value);
	}

	// Regen Toggle: Activates or deactivates the regen step
	public RegenToggle(activate: boolean) {
		this._regenActive = activate;
	}

	// Regen Step: Called updates once per configured _regenRate for the amount of _regenAmount
	private _regenStep() {
		// Time Since Last Tick
		const timeSinceLastTick = tick() - this._lastRegenTick;

		if (this._regenActive && timeSinceLastTick >= this._regenRate) {
			//warn("CharacterResource - Regen Step");
			this._lastRegenTick = tick();
			this.SetCurrent(this._currentValue + this._regenAmount);
		}
	}

	// Prints the current resource values
	private _onResourceChange() {
		this._resourceBar?.setProgressByValues(this._currentValue, this._maxValue);
	}

	// Disconnects all connections
	private _disconnectConnections() {
		this._heartbeatConnection?.Disconnect();
		this._minChangeConnection?.Disconnect();
		this._maxChangeConnection?.Disconnect();
	}

	// Destructor
	public Destroy() {
		this._disconnectConnections();
	}
}
