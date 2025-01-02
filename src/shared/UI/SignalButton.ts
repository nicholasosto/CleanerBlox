// SignalButton.ts
import { Signal } from "@rbxts/signals-tooling";
import { Logger } from "shared/Utility/Logger";


export interface SignalButtonConfig {
	name: string;
	holdable?: boolean; // Whether the button supports hold actions
}

export class SignalButton {
	private readonly buttonInstance: Instance;
	private readonly holdable: boolean;
	private isPressed: boolean = false;

	// Signals
	public readonly Activated = new Signal<() => void>();
	public readonly Released = new Signal<() => void>();
	
	// Public Variables
	public getInstance(): Instance {
		return this.buttonInstance;
	}

	constructor(buttonInstance: Instance, config: SignalButtonConfig) {

		Logger.Log(script,"SignalButton", "<Constructor>", buttonInstance);
		this.buttonInstance = buttonInstance;
		this.holdable = config.holdable ?? false;

		// Connect input events
		if (buttonInstance.IsA("GuiButton")) {
			buttonInstance.MouseButton1Down.Connect(() => this.handlePress());
			buttonInstance.MouseButton1Up.Connect(() => this.handleRelease());
			buttonInstance.MouseLeave.Connect(() => this.handleRelease()); // Ensure release is triggered if mouse leaves the button
		} else {
			error("SignalButton can only be used with GuiButton instances.");
		}
	}

	public codedPress() {
		this.handlePress();
		task.wait(2);
		this.handleRelease();
	}

	private handlePress() {
		if (!this.isPressed) {
			this.isPressed = true;
			this.Activated.fire();
			Logger.Log(script,"SignalButton", "Button Pressed: ", this.buttonInstance);
		}
	}

	private handleRelease() {
		if (this.isPressed) {
			this.isPressed = false;
			Logger.Log(script,"SignalButton", "Rel1 ", this.buttonInstance);
			if (this.holdable) {
				this.Released.fire();
				Logger.Log(script,"SignalButton", "Rel2", this.buttonInstance);
			}
		}
	}

	public destroy() {
		this.Activated.disconnectAll();
		this.Released.disconnectAll();
	}
}
