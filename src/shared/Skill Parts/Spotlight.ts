import { TTweener } from "shared/Utility/TTweener";
import { Logger } from "shared/Utility/Logger";

export class Spotlight {
	// Instance Properties
	public instance: Model;
	public owner: Model | undefined;

	// Target and Connections
	private HitConnection: RBXScriptConnection | undefined;
	private StateChangeConnection: RBXScriptConnection | undefined;

	// Constructor
	constructor(spotlightModel: Model, owner?: Model) {
		// Set the instance
		this.instance = spotlightModel;

		// Set the Attribute "State" to "UNK"
		this.instance.SetAttribute("State", "UNK");

		// Listen for property changes
		this.HitConnection = this.instance.PrimaryPart?.Touched.Connect((hit) => this.handlePartTouched(hit));

		// Listen for state changes
		this.StateChangeConnection = this.instance
			.GetAttributeChangedSignal("State")
			.Connect(() => this.OnStateChanged());

		// Set the State to Idle
		this.instance.SetAttribute("State", "Active");
		return this;
	}

	// Handle Part Touched
	protected handlePartTouched(hit: BasePart) {
		Logger.Log("Spotlight", "Toucher", hit, hit?.Parent as Model);
	}

	// State Changed
	protected OnStateChanged() {
		print("State Changed: ", this.instance.GetAttribute("State"));
		switch (this.instance.GetAttribute("State")) {
			case "Active":
				this.OnActive();
				break;
			case "Triggered":
				this.OnTriggered();
				break;
			case "Inactive":
				print("TODO: Spotlight is Inactive");
				break;
			case "Homing":
				this.OnHoming();
				break;
			case "Exploding":
				this.OnExploding();
				break;
			default:
				break;
		}
	}

	// State: Active
	protected OnActive() {
		Logger.Log("Spotlight", "[State]", this.instance.GetAttribute("State") as string);

		const primaryPart = this.instance.PrimaryPart as Part;
		Logger.Log("Spotlight", "PrimaryPart", primaryPart);
		const tween = TTweener.tweenPartCFrame(this.instance.PrimaryPart as Part, new CFrame(0, 0, 0), 22);

		tween.Play();
	}

	// State: Triggered
	protected OnTriggered() {
		Logger.Log("Spotlight", "[State]", this.instance.GetAttribute("State") as string);
	}

	// State: Homing
	protected OnHoming() {
		Logger.Log("Spotlight", "[State]", this.instance.GetAttribute("State") as string);
	}

	// State: Exploding
	protected OnExploding() {
		Logger.Log("Spotlight", "[State]", this.instance.GetAttribute("State") as string);
	}

	// Destroy
	public Destroy() {
		this.HitConnection?.Disconnect();
		this.StateChangeConnection?.Disconnect();
		this.instance.Destroy();
		//this.Destroy();
	}
}
