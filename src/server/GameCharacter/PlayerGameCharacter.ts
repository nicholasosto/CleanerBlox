import { Skill } from "@rbxts/wcs";
import { BaseGameCharacter } from "./BaseGameCharacter";
import { GuiReferenceHandler, EGUIElements, EScreenGuis } from "shared/GameAssetManagers";
import { ESkillNames } from "shared/WCS/Interfaces/RSkills";

import { DataCache, DataManager } from "server/Data/DataManager";
import { AbilityButton } from "shared/UI/AbilityButton";
import { Logger } from "shared/Utility/Logger";

// PlayerGameCharacter (Inherits from BaseGameCharacter)
export class PlayerGameCharacter extends BaseGameCharacter {
	// Private
	private _player: Player;
	private _dataCache: DataCache;
	private _playerGui: PlayerGui;
	private _hudGui: ScreenGui;
	private _abilityButtons: Map<string, AbilityButton> = new Map<string, AbilityButton>();
	private _actionBar: Frame;
	private _characterFrame: Frame;

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

		// Assign GUI
		this._playerGui = player.WaitForChild("PlayerGui") as PlayerGui;

		// HUD GUI
		this._hudGui = GuiReferenceHandler.getScreenGui(player, EScreenGuis.HUD);

		// Action Bar
		this._actionBar = GuiReferenceHandler.getUIElement(player, EScreenGuis.HUD, EGUIElements.ActionBar) as Frame;

		// Character Frame
		this._characterFrame = GuiReferenceHandler.getUIElement(
			player,
			EScreenGuis.HUD,
			EGUIElements.CharacterFrame,
		) as Frame;

		// Create Ability Buttons
		this.createAbilityButton(ESkillNames.BasicMelee, 1);

		Logger.Log(
			script,
			"PlayerGameCharacter Created: \n",
			this._characterFrame,
			" ",
			this._actionBar,
			" ",
			this._hudGui,
		);

		this.WCS_Character.GetSkills().forEach((skill) => {
			print(" - ", skill.GetName());
		});
		return this;
	}

	// Create Ability Button
	protected createAbilityButton(skillName: ESkillNames, slot: number) {
		const skill: Skill = this.WCS_Character.GetSkillFromString(skillName) as Skill;
		if (skill === undefined) {
			Logger.Log(script.Name, "Skill not found");
		}

		const abilityButton = new AbilityButton(this._actionBar, skill, slot);

		this._abilityButtons.set(skillName, abilityButton);
	}

	// Destroy
	public Destroy() {
		super.Destroy();
	}
}
