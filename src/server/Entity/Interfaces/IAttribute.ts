export interface IResource {
	MaxValue: number;
	CurrentValue: number;
	RegenRate: number;
	RegenAmount: number;
	RegenActive: boolean;
	startRegen: () => void;
	stopRegen: () => void;
	regen: () => void;
};

export interface IEntityAttributes {
	// Core Attributes
	Strength: number;
	Dexterity: number;
	Intelligence: number;
}
