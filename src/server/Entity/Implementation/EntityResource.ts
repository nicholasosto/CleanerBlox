import { RunService } from "@rbxts/services";
import { IResource } from "../Interfaces/IResource";
import { Logger } from "shared/Utility/Logger";

export class EntityResource implements IResource {
	Entity: Instance;
	MaxValue: number;
	CurrentValue: number;
	RegenRate: number;
	RegenAmount: number;
	RegenActive: boolean;
	Name: string;
	AttributeNameCurrent: string;
	AttributeNameMax: string;

	private _lastRegenTick: number = 0;

	_regenConnection: RBXScriptConnection | undefined;
	_minChangeConnection: RBXScriptConnection | undefined;
	_maxChangeConnection: RBXScriptConnection | undefined;

	constructor(parent: Instance, name: string, maxValue: number, regenRate: number, regenAmount: number = 1) {
		
		// Parent Entity
		this.Entity = parent;

		// Attribute Names and Values
		this.Name = name;
		this.AttributeNameCurrent = this.Name + "Current";
		this.AttributeNameMax = this.Name + "Max";
		this.MaxValue = maxValue;
		this.CurrentValue = maxValue;

		// Regen Values
		this.RegenRate = regenRate;
		this.RegenAmount = regenAmount;
		this.RegenActive = false;

		// Create Attributes on the Entity
		this.Entity.SetAttribute(this.AttributeNameMax, this.MaxValue);
		this.Entity.SetAttribute(this.AttributeNameCurrent, this.CurrentValue);

		// Connections
		this._regenConnection = RunService.Heartbeat.Connect(() => {
			this._regenStep();
		});

		this._minChangeConnection = this.Entity.GetAttributeChangedSignal(this.Name + "Current").Connect(() => {
			this.onResourceChange();
		});

		this._maxChangeConnection = this.Entity.GetAttributeChangedSignal(this.Name + "Max").Connect(() => {
			this.onResourceChange();
		});

		return this;
	}

	// Regen Step: Called updates once per configured RegenRate for the amount of RegenAmount
	private _regenStep() {
		const timeSinceLastTick = tick() - this._lastRegenTick;
		if (timeSinceLastTick >= this.RegenRate && this.CurrentValue < this.MaxValue) {
			this.CurrentValue += this.RegenAmount;
			Logger.Log("EntityResource", this.Name, this.CurrentValue);
		}
		if (this.CurrentValue < this.MaxValue) {
			this.CurrentValue += this.RegenAmount;
		}
	}

	// Prints the current resource values
	public onResourceChange() {
		warn(this.Entity.Name + " onResourceChange not implemented: " + this.Name + "\nCurrent: " + this.CurrentValue);
	}

	public assignOnMinChange(callback: (value: number) => void) {
		this._minChangeConnection = this.Entity.GetAttributeChangedSignal(this.Name + "Current").Connect(callback);
	}

	public assignOnMaxChange(callback: (value: number) => void) {
		if(this._maxChangeConnection && this._maxChangeConnection.Connected) {
			this._maxChangeConnection.Disconnect();
		} 
		this._maxChangeConnection = this.Entity.GetAttributeChangedSignal(this.Name + "Max").Connect(callback);
	}

	public startRegen() {
		this.RegenActive = true;
	}

	public stopRegen() {
		this.RegenActive = false;
	}

	public BindToEntity(entity: Model | Player) {
		this.Entity = entity;
		entity.SetAttribute(this.Name + "Max", this.MaxValue);
		entity.SetAttribute(this.Name + "Current", this.CurrentValue);
	}

	private _disconnectConnections() {
		if (this._regenConnection && this._regenConnection.Connected) {
			this._regenConnection.Disconnect();
		}
		if (this._minChangeConnection && this._minChangeConnection.Connected) {
			this._minChangeConnection.Disconnect();
		}
		if (this._maxChangeConnection && this._maxChangeConnection.Connected) {
			this._maxChangeConnection.Disconnect();
		}
	}

	public Destroy() {
		this._disconnectConnections();
	}
}
