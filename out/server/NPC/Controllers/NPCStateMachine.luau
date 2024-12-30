-- Compiled with roblox-ts v3.0.0
--[[
	
	// States
	import { IState } from "../Types/StateInterface";
	import { IdleState } from "../States/IdleState";
	import { PatrolState } from "../States/PatrolState";
	import { AttackState } from "../States/AttackState";
	
	// Utility
	import { Logger } from "shared/Utility/Logger";
	import { CharacterUtility } from "shared/Utility/CharacterUtility";
	import
	
	// WCS Plugin Services
	import { Character } from "@rbxts/wcs";
	
	export class NPCStateMachine {
		private _wcsCharacter: Character;
		public currentState: IState;
		public _states: Map<string, IState> = new Map<string, IState>();
	
		public modelInstance: Model;
		public humanoidInstance: Humanoid;
		public highlight: Highlight;
	
		// Constructor: Assigns the initial state and calls the onEnter method
		constructor(npc: NPCController) {
			// Assign the model and humanoid instances
			this.modelInstance = robloxModel;
			this.highlight = robloxModel.WaitForChild("StateColor") as Highlight;
			this.highlight.Enabled = false;
			// Set the initial state to Idle
			this._states.set("Idle", new IdleState(this));
			this._states.set("Patrol", new PatrolState(this));
			this._states.set("Attack", new AttackState(this));
			this.currentState = this._states.get("Idle") as IState;
	
			this._wcsCharacter = Character.GetCharacterFromInstance(robloxModel) as Character;
			this.humanoidInstance = robloxModel.FindFirstChildOfClass("Humanoid") as Humanoid;
			return this;
		}
	
		public changeState(newState: IState): void {
			Logger.NPCLog("StateMachine changeState");
			if (this.currentState !== newState) {
				const previousState = this.currentState;
				if (previousState) {
					previousState.onExit(newState);
				}
				this.currentState = newState;
				this.currentState.onEnter(previousState);
			}
		}
	
		public update(dt: number): void {
			Logger.NPCLog("StateMachine update");
			this.currentState.onUpdate(dt);
			// State Change Conditions check
		}
	}
	
]]
return nil
