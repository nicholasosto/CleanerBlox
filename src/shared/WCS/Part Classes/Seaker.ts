import { Character } from "@rbxts/wcs";

export class Seaker {
	private instance: Model | Part;
	private owner: Character;
	private target: Model | Character | CFrame;

	constructor(instance: Model | Part, owner: Character, target: Model | Character | CFrame) {
		this.instance = instance;
		this.owner = owner;
		this.target = target;
	}

	public SetTarget(target: Model | Character | CFrame) {
		this.target = target;
	}
}
