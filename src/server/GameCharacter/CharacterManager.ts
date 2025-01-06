/* eslint-disable prettier/prettier */
import { HttpService, Players } from "@rbxts/services";
import { PlayerGameCharacter } from "./Classes/PlayerGameCharacter";
import { BaseGameCharacter } from "./Classes/BaseGameCharacter";
import { CommunicationGod } from "shared/__Cleanup/Experimental/CommunicationGod";
import { Logger } from "shared/Utility/Logger";
import Signal from "@rbxts/signal";

export class GameCharacterRegistry {
	private static _instance: GameCharacterRegistry;
	private static _characterMap: Map<string, BaseGameCharacter> = new Map<string, BaseGameCharacter>();
	private static _playerCharacterMap: Map<string, PlayerGameCharacter> = new Map<string, PlayerGameCharacter>();
	private static _connectionCharacterAdded: RBXScriptConnection;
	private static _entityCreatedEvent = CommunicationGod.ServerSignals.get("Entity_Created");
	
	private constructor() {
		// Handle Character Added
		GameCharacterRegistry._connectionCharacterAdded = Players.PlayerAdded.Connect((player) => {
			player.CharacterAdded.Connect((character) => {

				const playerGameCharacter = new PlayerGameCharacter(player);
				Logger.Log(script, "Registering Player: ", playerGameCharacter._player.Name);
				GameCharacterRegistry._playerCharacterMap.set(tostring(player.UserId), playerGameCharacter);;
			});
		});
	}

	// Start: Run on server to initialize the EntityManager
	public static Start() {
		this.GetInstance();
	}

	// GetInstance: Get the instance of the EntityManager
	private static GetInstance(): GameCharacterRegistry {
		if (GameCharacterRegistry._instance === undefined) {
			GameCharacterRegistry._instance = new GameCharacterRegistry();
		}
		return GameCharacterRegistry._instance;
	}

	// CreateEntity: Create a new entity and add it to the EntityManager
	public static CreateEntity(rig: Model) {
		const entity = new BaseGameCharacter(rig);
		GameCharacterRegistry._characterMap.set(rig.Name, entity);
	}

	// GetEntity: Get an entity by name
	public static GetEntity(name: string): BaseGameCharacter {
		return GameCharacterRegistry._characterMap.get(name) as BaseGameCharacter;
	}

	// GetPlayerCharacter: Get a player character by player UserId
	public static GetPlayerCharacter(userId: number): PlayerGameCharacter {
		return GameCharacterRegistry._playerCharacterMap.get(tostring(userId)) as PlayerGameCharacter;
	}

	// RemoveEntity: Remove an entity by name
	public static RemoveEntity(name: string) {
		GameCharacterRegistry._characterMap.delete(name);
	}
}
