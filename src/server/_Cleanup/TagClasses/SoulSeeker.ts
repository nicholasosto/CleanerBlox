import { TweenService } from "@rbxts/services";
export class SoulSeaker {
	public _part: Part;
	public _target: Model | undefined;
	private _fire: Fire = new Instance("Fire") as Fire;
	private _VectorForce: VectorForce = new Instance("VectorForce") as VectorForce;

	constructor(part: Part) {
		this._part = part as Part;
		
		this._VectorForce.Enabled = false;
		this._VectorForce.Parent = this._part;
		//this._VectorForce.Force = new Vector3(math.random(-10,10), math.random(-10,10), math.random(-10,10));
		this._attachFire();
		this._seek();

		return this;
	}

	private _seek() {
		this._part.Anchored = false;
		this._VectorForce.Enabled = true;
	}

	private _attachFire() {
		this._fire.Size = 3;
		this._fire.Parent = this._part;
		this._fire.Heat = 10;
		this._fire.Color = Color3.fromRGB(255, 0, 0);
		this._fire.Parent = this._part;
	}

}
