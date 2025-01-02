/* eslint-disable prettier/prettier */
import { HttpService, Players } from "@rbxts/services";
import { PlayerGameCharacter, BaseGameCharacter } from "./Implementation/GameCharacter";
import { CommunicationGod } from "shared/Experimental/CommunicationGod";
import { Logger } from "shared/Utility/Logger";
import Signal from "@rbxts/signal";

export class EntityManager {
	private static _instance: EntityManager;
	private static _entities: Map<string, BaseGameCharacter> = new Map<string, BaseGameCharacter>();
	private static _connectionCharacterAdded: RBXScriptConnection;
	private static _entityCreatedEvent = CommunicationGod.ServerSignals.get("Entity_Created");
	
	private constructor() {
		// Handle Character Added
		EntityManager._connectionCharacterAdded = Players.PlayerAdded.Connect((player) => {
			player.CharacterAdded.Connect((character) => {

				const playerGameCharacter = new PlayerGameCharacter(player);
				//Logger.Log(script, HttpService.JSONEncode(playerGameCharacter).find("CharacterFrame"));
			});
			player.CharacterAdded.Connect((character) => {

				//const entity = new BaseEntity(character);
				//warn("EntityManager - Player Added", player.Name, "entityCreation triggered");

				//EntityManager._entities.set(character.Name, entity);
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
		const entity = new BaseGameCharacter(rig);
		EntityManager._entities.set(rig.Name, entity);
	}

	// GetEntity: Get an entity by name
	public static GetEntity(name: string): BaseGameCharacter {
		return EntityManager._entities.get(name) as BaseGameCharacter;
	}

	// RemoveEntity: Remove an entity by name
	public static RemoveEntity(name: string) {
		EntityManager._entities.delete(name);
	}
}
