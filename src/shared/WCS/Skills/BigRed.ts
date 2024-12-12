import { HoldableSkill, SkillDecorator } from "@rbxts/wcs";
import { CFrameGenerator } from "shared/Utility/CFrameGenerator";
import { Logger } from "shared/Utility/Logger";
import { GameStorage } from "shared/Utility/GameStorage";
import { CharacterAttachments } from "shared/Interfaces/ICharacterAttachments";
import { ParticleGroupManager } from "shared/Utility/ParticleGroupManager";

@SkillDecorator
export class BigRed extends HoldableSkill {
	// Properties
	private AbilityPart: Model | undefined;
	private ChargingEffectAttachment: Attachment | undefined;
	private _characterModel: Model | undefined;
	private _characterAttachments: CharacterAttachments | undefined;

	// Skill Settings
	private _defaultHoldTime: number = 5;
	private _defaultCooldownTime: number = 3;

	private LoadAssets() {
		// Load the AbilityPart
		this.AbilityPart = GameStorage.cloneModel("HomingSphere");

		// Gets a cloned Attachment from the GameStorage with particle effect children
		this.ChargingEffectAttachment = GameStorage.cloneParticleGroupAttachment("RedCasting");

		// Gets the character model
		this._characterModel = this.Character.Instance as Model;

		// Creates the Floor and Halo attachments and sets the attachment references
		this._characterAttachments = new CharacterAttachments(this._characterModel);

		// Parent the ChargingEffectAttachment to the Floor attachment
		this.ChargingEffectAttachment.Parent = this._characterAttachments.Floor;

		Logger.Log(this.GetName(), "-- 03. Assets Loaded \n");
	}

	private DisableAssets() {
		ParticleGroupManager.disableParticleGroup(this.ChargingEffectAttachment);
		Logger.Log(this.GetName(), "-- 05. Assets Disabled \n");
	}

	// 00. CONSTRUCT SERVER
	public OnConstructServer() {
		Logger.Log(this.GetName(), "\n--------  Construct Server  --------\n");

		Logger.Log(this.GetName(), "-- 01. Max Hold Time \n");
		// Set Skill Properties
		this.SetMaxHoldTime(this._defaultHoldTime);
		// Connect to the HoldTimer's secondReached event
		this.HoldTimer.secondReached.Connect((seconds) => this.stageActivated(seconds));


		// Load Skill Assets
		Logger.Log(this.GetName(), "-- 02. Load Assets \n");
		this.LoadAssets();
	}

	// MOVE START
	public OnStartServer() {
		Logger.Log(this.GetName(), "\n--------  Start Server  --------\n");
		this.LoadAssets();
		this.ApplyCooldown(this._defaultCooldownTime);
	}

	// Stages
	private stageActivated(seconds: number) {
		Logger.Log(this.GetName(), "\n--------  Stage Activated Server  --------\n");
		Logger.Log("BigRed", "Stage Activated: ", tostring(seconds), tostring(this.CooldownTimer.getTimeLeft()));
		switch (seconds) {
			case 1:
				this.Stage3();
				break;
			case 2:
				this.Stage2();
				break;
			case 3:
				this.Stage1();
				break;
			default:
				break;
		}
	}

	// STAGE 1
	private Stage1() {
		Logger.Log(this.GetName(), " - Stage 01 called\n");
	}

	// STAGE 2
	private Stage2() {
		Logger.Log(this.GetName(), " - Stage 02 called\n");
	}

	// STAGE 3
	private Stage3() {
		Logger.Log(this.GetName(), " - Stage 03 called\n");
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log(this.GetName(), "\n--------  Stage Activated Server  --------\n");
		this.DisableAssets();
	}
}
