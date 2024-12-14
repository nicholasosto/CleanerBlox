import { RunService } from "@rbxts/services";

export class EntityResource {
	Entity: Model | Player | undefined;
	MaxValue: number;
	CurrentValue: number;
	RegenRate: number;
	RegenAmount: number;
	RegenActive: boolean;
	Name: string;
	_regenConnection = RunService.Heartbeat.Connect((delta) => this.regen(delta));
	_minChangeConnection: RBXScriptConnection | undefined;
	_maxChangeConnection: RBXScriptConnection | undefined;

	constructor(name: string, maxValue: number, regenRate: number, regenAmount: number) {
		this.Name = name;
		this.MaxValue = maxValue;
		this.CurrentValue = maxValue;
		this.RegenRate = regenRate;
		this.RegenAmount = regenAmount;
		this.RegenActive = false;
		return this;
	}

	startRegen() {
		this.RegenActive = true;
	}

	stopRegen() {
		this.RegenActive = false;
	}

	private async regen(delta: number) {
		while (this.RegenActive) {
			task.wait(this.RegenRate);
		}
	}

	public BindToEntity(entity: Model | Player) {
		this.Entity = entity;
		entity.SetAttribute(this.Name + "Max", this.MaxValue);
		entity.SetAttribute(this.Name + "Current", this.CurrentValue);
	}
}
