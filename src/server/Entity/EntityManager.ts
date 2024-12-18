/* eslint-disable prettier/prettier */
import { Players } from "@rbxts/services";
import { BaseEntity } from "./Implementation/Entity";
import { CommunicationGod } from "shared/Events/CommunicationGod";
import Signal from "@rbxts/signal";

export class EntityManager {
	private static _instance: EntityManager;
	private static _entities: Map<string, BaseEntity> = new Map<string, BaseEntity>();
	private static _connectionCharacterAdded: RBXScriptConnection;
	private static _entityCreatedEvent = CommunicationGod.ServerSignals.get("Entity_Created");
	
	private constructor() {
		EntityManager._connectionCharacterAdded = Players.PlayerAdded.Connect((player) => {

			
			player.CharacterAdded.Connect((character) => {

				const entity = new BaseEntity(character);

				EntityManager._entities.set(character.Name, entity);
			});
		});
	}

	// Start: Run on server to initialize the EntityManager
	public static Start() {
		this.GetInstance();
	}

	// GetInstance: Get the instance of the EntityManager
	private static GetInstance(): EntityManager {
		if (EntityManager._instance === undefined) {
			EntityManager._instance = new EntityManager();
		}
		return EntityManager._instance;
	}

	// CreateEntity: Create a new entity and add it to the EntityManager
	public static CreateEntity(rig: Model) {
		const entity = new BaseEntity(rig);
		EntityManager._entities.set(rig.Name, entity);
	}

	// GetEntity: Get an entity by name
	public static GetEntity(name: string): BaseEntity {
		return EntityManager._entities.get(name) as BaseEntity;
	}

	// RemoveEntity: Remove an entity by name
	public static RemoveEntity(name: string) {
		EntityManager._entities.delete(name);
	}
}
