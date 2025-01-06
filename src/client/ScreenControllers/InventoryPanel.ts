import * as SkillsRef from "shared/_References/Character/Skills";
import { PackageManager, EGuiTemplates } from "shared/GameAssetManagers";
import { ItemType } from "shared/_References/Inventory";
import { Logger } from "shared/Utility/Logger";

export class InventoryPanel {
	private _screenGui: ScreenGui;
	private _mainFrame: Frame;
	private _scrollingFrame: ScrollingFrame;
	private _inventoryType: string;
	private _toggleButton: TextButton;
	private _closeButton: TextButton;

	// Connections
	private _connections: Map<string, RBXScriptConnection> = new Map();

	constructor(screenGui: ScreenGui, inventoryType: string) {
		// ScreenGui
		this._screenGui = screenGui;

		// Inventory Type
		this._inventoryType = inventoryType;

		// Main Frame
		this._mainFrame = this._screenGui.FindFirstChild("MainFrame") as Frame;

		// Toggle and Close Button
		const toggleButtonReference = this._screenGui.FindFirstChild("ToggleButton") as ObjectValue;
		this._toggleButton = toggleButtonReference.Value as TextButton;
		const closeButtonReference = this._screenGui.FindFirstChild("CloseButton") as ObjectValue;
		this._closeButton = closeButtonReference.Value as TextButton;

		this._scrollingFrame = this._screenGui.FindFirstChild("InventoryScroller") as ScrollingFrame;

		// Connect Signals
		this._connectSignals();
		Logger.Log(script, "Inventory Panel Created");

		return this;
	}

	private _connectSignals() {
		// Toggle Button
		const connection = this._toggleButton.Activated.Connect(() => {
			this.ToggleScreenGui();
		});
		this._connections.set("Toggle", connection);

		// Close Button
		this._connections.set("Close", connection);
	}

	public ToggleScreenGui() {
		this._mainFrame.Visible = !this._mainFrame.Visible;
	}

	private _disconnectAll() {
		this._connections.forEach((connection) => {
			connection.Disconnect();
		});
	}

	public static CreatePanel(inventoryType: ItemType): InventoryPanel {
		const screenGui = PackageManager.GetGuiTemplate(EGuiTemplates.InventoryPanel) as ScreenGui;
		screenGui.Parent = game.GetService("Players").LocalPlayer.WaitForChild("PlayerGui");
		const inventoryPanel = new InventoryPanel(screenGui, inventoryType);
		return inventoryPanel;
	}
}
