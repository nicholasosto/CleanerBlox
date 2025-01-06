/* eslint-disable prettier/prettier */
import { BaseGameCharacter } from "./BaseGameCharacter";
import { EventManager } from "shared/GameAssetManagers";
import * as SkillsRef from "shared/_References/Character/Skills";
import { PackageManager } from "shared/GameAssetManagers";

import { DataCache, DataManager } from "server/Data/DataManager";
import { Logger } from "shared/Utility/Logger";

// PlayerGameCharacter (Inherits from BaseGameCharacter)
export class PlayerGameCharacter extends BaseGameCharacter {
	// Private
	public _player: Player;
	public _player: Player;
	private _dataCache: DataCache;

	// Constructor
	constructor(player: Player) {
		// Get Character
		const character = player.Character || player.CharacterAdded.Wait()[0];
		if (character === undefined) {
			Logger.Log(script, "PlayerGameCharacter: Character not found");
			throw "PlayerGameCharacter: Character Model not found";
		}

		// Super Constructor: BaseGameCharacter
		super(character);

		// Assign Player
		this._player = player;
		// DataCache
		this._dataCache = DataManager.GetDataCache(tostring(player.UserId));
		Logger.Log(script, "Skills: ", this._dataCache._playerData.Skills as unknown as string);
		const PlayerCharacterCreated = EventManager.GetEvent("PLAYER_CharacterCreated");
		PlayerCharacterCreated.FireClient(player);
		return this;
	}

	// Destroy
	public Destroy() {
		super.Destroy();
	}
}
