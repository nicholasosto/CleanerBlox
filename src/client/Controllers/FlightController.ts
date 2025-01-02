import { Players, RunService, UserInputService } from "@rbxts/services";
import { Logger } from "shared/Utility/Logger";

const localPlayer = Players.LocalPlayer;

export class FlightController {
	private static instance: FlightController | undefined;

	private enabled = false;
	private character: Model | undefined;
	private humanoid: Humanoid | undefined;
	private rootPart: BasePart | undefined;

	private flightConnection: RBXScriptConnection | undefined;
	private inputBeganConnection: RBXScriptConnection | undefined;
	private inputEndedConnection: RBXScriptConnection | undefined;

	private isFlyingKeyDown = false; // Track if flight key is currently pressed

	constructor() {
		// Listen for when the local player's character is added
		localPlayer.CharacterAdded.Connect((character) => this.onCharacterAdded(character));
		localPlayer.CharacterRemoving.Connect(() => this.onCharacterRemoving());

		// If the character already exists (e.g. game just started or respawned), initialize immediately
		if (localPlayer.Character) {
			this.onCharacterAdded(localPlayer.Character);
		}

		// Set up input handling
		this.setupInputHandling();
	}

	public static Start() {
		if (!this.instance) {
			this.instance = new FlightController();
		}
		this.instance.setEnabled(true);
	}

	public static GetInstance(): FlightController | undefined {
		return this.instance;
	}

	public setEnabled(value: boolean) {
		this.enabled = value;
		Logger.Log(script, `Flight enabled: ${value}`);
	}

	public toggleEnabled() {
		this.setEnabled(!this.enabled);
	}

	private setupInputHandling() {
		// Track when the flight key (Space) is pressed or released
		this.inputBeganConnection = UserInputService.InputBegan.Connect((input, gameProcessed) => {
			if (!gameProcessed && input.KeyCode === Enum.KeyCode.Space) {
				this.isFlyingKeyDown = true;
			}
		});

		this.inputEndedConnection = UserInputService.InputEnded.Connect((input, gameProcessed) => {
			if (input.KeyCode === Enum.KeyCode.Space) {
				this.isFlyingKeyDown = false;
			}
		});
	}

	private onCharacterAdded(character: Model) {
		this.character = character;
		this.humanoid = character.WaitForChild("Humanoid") as Humanoid;
		this.rootPart = character.WaitForChild("HumanoidRootPart") as BasePart;

		// Clean up old connection if it exists
		if (this.flightConnection) {
			this.flightConnection.Disconnect();
		}

		// Connect to PreSimulation for flight updates
		this.flightConnection = RunService.PreSimulation.Connect(() => this.updateFlight());
	}

	private onCharacterRemoving() {
		// Disconnect the flight update connection if it exists
		if (this.flightConnection) {
			this.flightConnection.Disconnect();
			this.flightConnection = undefined;
		}

		this.character = undefined;
		this.humanoid = undefined;
		this.rootPart = undefined;
	}

	private updateFlight() {
		if (!this.enabled || !this.humanoid || !this.rootPart) return;

		if (this.isFlyingKeyDown) {
			// Disable physics state if flight key is down
			this.humanoid.SetStateEnabled(Enum.HumanoidStateType.Physics, false);
		} else {
			// Re-enable physics if not flying
			this.humanoid.SetStateEnabled(Enum.HumanoidStateType.Physics, true);
		}
	}

	public cleanup() {
		// Call this if you ever need to destroy the flight controller instance
		if (this.flightConnection) this.flightConnection.Disconnect();
		if (this.inputBeganConnection) this.inputBeganConnection.Disconnect();
		if (this.inputEndedConnection) this.inputEndedConnection.Disconnect();

		this.flightConnection = undefined;
		this.inputBeganConnection = undefined;
		this.inputEndedConnection = undefined;
	}
}

// End of src/client/Controllers/FlightController.ts
