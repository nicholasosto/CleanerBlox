import { InsertService, Players } from "@rbxts/services";
import { Logger } from "./Utility/Logger";
import { Inventory } from "./UI/UIEnums";

// Package IDs
export enum EPackageIDs {
	Environment = 16178566269,
	Effects = 16593023479,
	Audio = 16412665714,
	NPC = 16034962856,
	GameStorage = 106038395934214,
	Weapons = 16226642685,
	UITemplates = 102507696180343,
}

// GUI Templates
export enum EGuiTemplates {
	AbilityButton = "AbilityButton_Template",
	AttributeLabel = "AttributeLabel_Template",
	CharacterFrame = "CharacterFrame_Template",
	InventoryPanel = "InventoryPanel_Template",
}

// Aura Names
export enum EAuraNames {
	TimeAura = "TimeAura",
	FireAura = "FireAura",
	WaterAura = "WaterAura",
}

export enum EScreenGuis {
	HUD = "HUD",
	Developer = "Developer",
	MainGui = "MainGui",
}

export enum EGUIElements {
	ActionBar = "ActionBarMain",
	CharacterFrame = "CharacterFrame",
}

// Package Manager
export class PackageManager {
	// Load Entire Package
	public static LoadPackage(packageID: EPackageIDs): Model | undefined {
		const packageContainer = InsertService.LoadAsset(packageID);
		if (packageContainer === undefined) {
			Logger.Log(script.Name, "Failed to load package with ID: ", packageID);
		}
		return packageContainer;
	}

	// Load Asset from GUI Templates Package
	public static LoadGuiTemplate(guiTemplate: EGuiTemplates): Instance | undefined {
		if (game.GetService("RunService").IsServer()) {
			Logger.Log(script.Name, "Cannot load GUI template on the server");
			return undefined;
		}
		const guiTemplateInstance = InsertService.LoadAsset(EPackageIDs.UITemplates).FindFirstChild(guiTemplate, true);
		if (guiTemplateInstance === undefined) {
			Logger.Log(script.Name, "Failed to load GUI template with name: ", guiTemplate);
		}
		return guiTemplateInstance;
	}

	public static GetGuiTemplate(guiTemplate: EGuiTemplates): Instance {
		const packageFolder = game.GetService("ReplicatedStorage").WaitForChild("Asset Package - UI Templates");
		const guiTemplateInstance = packageFolder.FindFirstChild(guiTemplate, true) as Instance;
		if (guiTemplateInstance === undefined) {
			Logger.Log(script.Name, "Failed to load GUI template with name: ", guiTemplate);
		}
		return guiTemplateInstance;
	}
}


// Event Manager
export class EventManager {
	public static EventsFolder = game.GetService("ReplicatedStorage").WaitForChild("Asset Package - Remotes");
	public static GetEvent(eventName: string): RemoteEvent {
		const event = EventManager.EventsFolder.FindFirstChild(eventName, true) as RemoteEvent;
		return event;
	}
}

// GUI Reference Handler
export class GuiReferenceHandler {
	// Get Screen GUI
	public static getScreenGui(player: Player, guiName: EScreenGuis): ScreenGui {
		const guiInstance = player.WaitForChild("PlayerGui").WaitForChild(guiName) as ScreenGui;
		if (guiInstance === undefined) {
			Logger.Log(script.Name, "Failed to load GUI with name: ", guiName);
		}
		return guiInstance;
	}

	// Toggle Screen GUI
	public static ToggleScreenGui(player: Player, guiName: EScreenGuis, toggle: boolean) {
		const guiInstance = player.WaitForChild("PlayerGui").WaitForChild(guiName) as ScreenGui;
		if (guiInstance === undefined) {
			Logger.Log(script.Name, "Failed to Toggle GUI with name: ", guiName);
		}
		guiInstance.Enabled = toggle;
	}

	// Get reference for UI Element
	public static getUIElement(player: Player, guiName: EScreenGuis, elementName: EGUIElements): Instance | undefined {
		const guiInstance = player.WaitForChild("PlayerGui").WaitForChild(guiName) as ScreenGui;
		const elementInstance = guiInstance.FindFirstChild(elementName, true);
		if (elementInstance === undefined) {
			Logger.Log(script.Name, "Failed to load UI Element with name: ", elementName);
		}
		return elementInstance;
	}
}
