import { Players, RunService } from "@rbxts/services";
import { IResource } from "../Interfaces/IResource";
import { GameStorage } from "shared/Utility/GameStorage";
import { Logger } from "shared/Utility/Logger";

export class EntityResourceBar {
	Bar: Frame;
	BarName: string;

	constructor(parent: Frame | ScreenGui, name: string) {
		this.Bar = GameStorage.cloneGUIComponent("Progress Bar Template") as Frame;

		this.BarName = name;

		this.Bar.Parent = parent;
		this.Bar.Name = name + "Bar";
		this.Bar.SetAttribute("TextValue", name);
	}

	public setBarValue(percentage: number) {
		this.Bar.SetAttribute("BarPercent", percentage);
	}
}

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
	private _resourceBar: EntityResourceBar | undefined;

	_regenConnection: RBXScriptConnection | undefined;
	_minChangeConnection: RBXScriptConnection | undefined;
	_maxChangeConnection: RBXScriptConnection | undefined;

	constructor(parent: Instance, name: string, maxValue: number, regenRate: number, regenAmount: number = 1) {
		const player = Players.GetPlayerFromCharacter(parent);
		if (player) {
			const playerGUI = player.WaitForChild("PlayerGui") as PlayerGui;
			if (playerGUI !== undefined) {
				const HUD: ScreenGui = playerGUI.WaitForChild("HUD") as ScreenGui;
				this._resourceBar = new EntityResourceBar(HUD, name);
			}
		}
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
		this.RegenActive = true;

		// Create Attributes on the Entity
		this.Entity.SetAttribute(this.AttributeNameMax, this.MaxValue);
		this.Entity.SetAttribute(this.AttributeNameCurrent, this.CurrentValue);

		// Connections
		this._regenConnection = RunService.Heartbeat.Connect((dt) => {
			const timeSinceLastTick = tick() - this._lastRegenTick;
			//warn("time: ", timeSinceLastTick, "rate: ", this.RegenRate);
			if (this.RegenActive && timeSinceLastTick >= this.RegenRate) {
				//warn("EntityResource - Regen Step");
				this._lastRegenTick = tick();
				this._regenStep();
			}
		});

		this._minChangeConnection = this.Entity.GetAttributeChangedSignal(this.Name + "Current").Connect(() => {
			//Logger.Log("EntityResource", this.Name, this.CurrentValue);
			this.onResourceChange();
		});

		this._maxChangeConnection = this.Entity.GetAttributeChangedSignal(this.Name + "Max").Connect(() => {
			//Logger.Log("EntityResource", this.Name, this.MaxValue);
			this.onResourceChange();
		});
		this.onResourceChange();
		this.setCurrentValue(10);
		return this;
	}

	// Regen Step: Called updates once per configured RegenRate for the amount of RegenAmount
	private _regenStep() {
		this.setCurrentValue(this.CurrentValue + this.RegenAmount);
	}

	public setMaxValue(value: number) {
		this.MaxValue = value;
		this.Entity.SetAttribute(this.Name + "Max", value);
	}

	public setCurrentValue(value: number) {
		//warn("EntityResource - Setting Value: " + value);
		this.CurrentValue = value;
		this.Entity.SetAttribute(this.Name + "Current", value);
	}

	public adjustCurrentValue(value: number) {
		//Logger.Log("EntityResource - Adjusting Value by: " + value);
		this.CurrentValue += value;
		this.Entity.SetAttribute(this.Name + "Current", this.CurrentValue);
	}

	// Prints the current resource values
	public onResourceChange() {
		//warn(this.Entity.Name + " onResourceChange not implemented: " + this.Name + "\nCurrent: " + this.CurrentValue);
		this._resourceBar?.setBarValue((this.CurrentValue / this.MaxValue) * 100);
	}

	public assignOnMinChange(callback: (value: number) => void) {
		this._minChangeConnection = this.Entity.GetAttributeChangedSignal(this.Name + "Current").Connect(callback);
	}

	public assignOnMaxChange(callback: (value: number) => void) {
		if (this._maxChangeConnection && this._maxChangeConnection.Connected) {
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
