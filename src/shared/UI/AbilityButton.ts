// AbilityButton Class
import { PackageManager, EGuiTemplates } from "shared/GameAssetManagers";
import { Skill } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";

// Attribute Label Class
export class AbilityButton {
	// Private Variables
	private _abilityButtonFrame: Frame;
	private _imageButton: ImageButton;
	private _cooldownBar: Frame;
	private _wcsSkill: Skill;

	private _connection: RBXScriptConnection | undefined;

	// Constructor
	constructor(actionBar: Frame, wcsSkill: Skill, slot: number) {
		// Action Bar Slot Configuration

		// Ability Button GUI Element
		this._abilityButtonFrame = PackageManager.LoadGuiTemplate(EGuiTemplates.AbilityButton) as Frame;
		this._abilityButtonFrame.Name = wcsSkill.GetName() + "_ButtonFrame";

		// Action Bar Slot Reference
		let actionBarSlot = actionBar.FindFirstChild("Slot" + slot) as Frame;
		actionBarSlot = actionBarSlot.FindFirstChild("Content") as Frame;

		// Parent Ability Button to Action Bar Slot
		this._abilityButtonFrame.Parent = actionBarSlot;

		// Image Button
		this._imageButton = this._abilityButtonFrame.FindFirstChild("ImageButton") as ImageButton;

		// Cooldown Bar
		this._cooldownBar = this._abilityButtonFrame.FindFirstChild("CooldownBar") as Frame;

		//Skill Configuration
		this._wcsSkill = wcsSkill;

		this._imageButton.Activated.Connect((inputObj) => {
			Logger.Log(script, "Ability Button Activated: ", inputObj);
		});

		Logger.Log(script, "Skill Name: ", this._wcsSkill.GetName());
		Logger.Log(script, "Skill Frame: ", this._abilityButtonFrame);
		return this;
	}

	public SetCooldown(percentRemaining: number) {
		this._cooldownBar.SetAttribute("BarPercent", percentRemaining);
	}

	public Destroy() {
		if (this._connection) {
			this._connection.Disconnect();
		}
		this._imageButton.Destroy();
	}
}
