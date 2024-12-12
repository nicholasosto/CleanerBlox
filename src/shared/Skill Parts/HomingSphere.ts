import { GameStorage } from "shared/Utility/GameStorage";


// States for HomingSphere
export enum HSState {
	Created = "Created",
	Searching = "Searching",
	Homing = "Homing",
	Exploding = "Exploding",
}


// HomingSphere: Class for HomingSphere
export class HomingSphere {
	private _instance: Model;
	private _owner: Model | undefined;
	private _hitPart: BasePart | undefined;
	private _state: HSState = HSState.Created;

	constructor(sphereModel?: Model, owner?: Model) {
		this._instance = sphereModel || GameStorage.getModel("HomingSphere");
		this._owner = owner;

		this._hitPart = this._instance.FindFirstChild("HitPart") as BasePart;

		if (!this._hitPart) {
			error("HitPart not found in HomingSphere");
		}

		this.transitionTo(HSState.Searching);

		return this;
	}

	public transitionTo(newState: HSState): void {
		this._state = newState;
		switch (newState) {
			case HSState.Created:
				this.onCreated();
				break;
			case HSState.Searching:
				this.onSearching();
				break;
			case HSState.Homing:
				this.onHoming();
				break;
			case HSState.Exploding:
				this.onExploding();
				break;
		}
	}

	public onCreated(): void {
		print("HomingSphere Created");
	}

	public onSearching(): void {
		print("HomingSphere Searching");
	}

	public onHoming(): void {
		print("HomingSphere Homing");
	}

	public onExploding(): void {
		print("HomingSphere Exploding");
	}
}
