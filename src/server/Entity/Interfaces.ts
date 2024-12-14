import { Character } from "@rbxts/wcs";
import { EntityTypes, EntityStates } from "./Enums";

export interface IEntityAttachments {
	Head: Attachment;

	LeftHand: Attachment;
	RightHand: Attachment;

	LeftFoot: Attachment;
	RightFoot: Attachment;
    
	Floor: Attachment;
	Halo: Attachment;
	Body: Attachment;
}

export type IEntityResource = {
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
	// Derived Attributes
	Health: IEntityResource;
	Mana: IEntityResource;
	Stamina: IEntityResource;

	// Core Attributes
	Strength: number;
	Dexterity: number;
	Intelligence: number;
}

export interface IEntity {
	// Core Properties
	Id: string;
	Name: string;
	Type: EntityTypes;
	State: EntityStates;
	Attributes: IEntityAttributes;
	Attachments: IEntityAttachments;
	WCSCharacter: Character;

	// Methods
	MoveTo(position: Vector3): void;
	Attack(target: IEntity): void;
	Die(): void;
	Interact(target: IEntity): void;
	Cast(spell: string): void;
	Equip(item: string): void;
	Unequip(item: string): void;
	Use(item: string): void;
	LevelUp(): void;
	GainExperience(amount: number): void;
	TakeDamage(amount: number): void;
	Heal(amount: number): void;
	RestoreMana(amount: number): void;
	RestoreStamina(amount: number): void;
}
