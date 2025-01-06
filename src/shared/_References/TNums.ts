export enum SkillNames {
	MoveForward = "MoveForward",
	MoveBackward = "MoveBackward",
	MoveLeft = "MoveLeft",
	MoveRight = "MoveRight",
	Jump = "Jump",
	Attack = "Attack",
	Block = "Block",
	Dash = "Dash",
	Spotlights = "Spotlights",
}

export class TNums {
	private constructor() {
		// Private constructor to prevent instantiation
	}
	public static SkillNames = SkillNames;
}
