import { ReplicatedStorage, Workspace, TweenService, Players } from "@rbxts/services";
import { CFrameGenerator } from "shared/Utility/CFrameGenerator";
import { GameStorage } from "shared/GameStorage";

export class Spotlight {
	// Static Properties
	private static template: Model = GameStorage.getModel("Spotlight").Clone();
	private static cFrameGenerator = new CFrameGenerator();

	// Instance Properties
	public instance: Model;
	private Character: Model;
	private PrimaryPart: BasePart | undefined;
	private HitPart: BasePart | undefined;
	private SpotlightTween: Tween | undefined;
	private HomingTween: Tween | undefined
	private CFrame: CFrame | undefined;
	private Target: Model | undefined;
	private HitConnection: RBXScriptConnection | undefined;
	private StateChangeConnection: RBXScriptConnection | undefined;

	// Constructor
	constructor(cFrame: CFrame, character: Model) {
		// Set the instance
		this.instance = Spotlight.template.Clone();
		this.Character = character as Model;

		print("Spotlight Instance: ", this.instance, cFrame);

		this.PrimaryPart = this.instance.PrimaryPart as BasePart;
		this.HitPart = this.instance.FindFirstChild("HitPart") as BasePart;
		this.CFrame = cFrame;

		this.instance.Parent = Workspace;
		this.instance.PivotTo(cFrame);

		// Set the Attribute "State" to "UNK"
		this.instance.SetAttribute("State", "UNK");

		this.SpotlightTween = this.CreateRandomTween() as Tween;
		this.HomingTween = this.CreateHomingTween() as Tween;

		// Listen for property changes
		this.HitConnection = this.PrimaryPart.Touched.Connect((hit) => this.handlePartTouched(hit));

		// Listen for state changes
		this.StateChangeConnection = this.instance
			.GetAttributeChangedSignal("State")
			.Connect(() => this.OnStateChanged());

		// Set the State to Idle
		this.instance.SetAttribute("State", "Idle");
		return this;
	}

	protected handlePartTouched(hit: BasePart) {
		const parent = hit.Parent as Model;

		if (!parent) return;

		if (!parent.FindFirstChild("Humanoid")) return;

		if(parent === this.Character) return;

		this.Target = parent;

		this.instance.SetAttribute("State", "Triggered");

	}

	protected CreateRandomTween() {
		const hitPart = this.PrimaryPart as BasePart;
		// Tween Properties
		const _duration = 2;
		const _easingStyle = Enum.EasingStyle.Linear;
		const _easingDirection = Enum.EasingDirection.InOut;
		const _repeatCount = -1;
		const _reverses = false;

		// Create the TweenInfo object
		const tweenInfo = new TweenInfo(_duration, _easingStyle, _easingDirection, _repeatCount, _reverses);

		// Spotlight Base Position
		if (!this.CFrame) {
			return;
		}

		// Randomize the Goal Position
		const GoalCFrame = this.CFrame.mul(new CFrame(math.random(-30, 30), 0, math.random(-30, 30)));

		// Create the Tween
		const spotlightTween = TweenService.Create(hitPart, tweenInfo, {
			CFrame: GoalCFrame,
		});

		return spotlightTween;
	}

	protected CreateHomingTween() {
		const hitPart = this.PrimaryPart as BasePart;
		// Tween Properties
		const _duration = 1;
		const _easingStyle = Enum.EasingStyle.Linear;
		const _easingDirection = Enum.EasingDirection.InOut;
		const _repeatCount = -1;
		const _reverses = false;

		// Create the TweenInfo object
		const tweenInfo = new TweenInfo(_duration, _easingStyle, _easingDirection, _repeatCount, _reverses);

		// Spotlight Base Position
		if (!this.CFrame) {
			return;
		}

		// Create the Tween
		if(!this.Target) {
			warn("Target not found");
			return;
		}
		const goalFrame = this.Target.GetPivot() as CFrame;

		const homingTween = TweenService.Create(hitPart, tweenInfo, {
			CFrame: goalFrame,
		});

		return homingTween;
	}

	// State Changed
	protected OnStateChanged() {
		print("State Changed: ", this.instance.GetAttribute("State"));
		switch (this.instance.GetAttribute("State")) {
			case "Idle":
				this.OnIdle();
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

	// State: Idle
	protected OnIdle() {
		print("Spotlight is Idle");
		const PrimaryPart = this.PrimaryPart as BasePart;

		if (!PrimaryPart) {
			return;
		}

		PrimaryPart.Color = Color3.fromRGB(255, 255, 255);
		print("Tween Play: ", this.SpotlightTween);
		this.SpotlightTween?.Play();
	}

	// State: Exploding
	protected OnExploding() {
		print("Spotlight is Exploding");
		const PrimaryPart = this.PrimaryPart as BasePart;
		PrimaryPart.Color = Color3.fromRGB(74, 74, 135);
		const humanoidTarget = this.Target?.FindFirstChild("Humanoid") as Humanoid;

		if (humanoidTarget) {
			humanoidTarget.TakeDamage(110);
		}
		this.instance.Destroy();
	}

	// State: Triggered
	protected OnTriggered() {
		print("Spotlight is Triggered");
		const HitPart = this.HitPart as BasePart;
		HitPart.Color = Color3.fromRGB(255, 0, 0);
		this.instance.SetAttribute("State", "Homing");
	}

	protected OnHoming() {
		print("Spotlight is Homing");
		const PrimaryPart = this.PrimaryPart as BasePart;
		PrimaryPart.Color = Color3.fromRGB(0, 255, 0);
		this.HomingTween = this.CreateHomingTween();
		this.HomingTween?.Completed.Connect(() => {
			this.instance.SetAttribute("State", "Exploding");
		});
		this.HomingTween?.Play();
	}

	// Destroy
	public Destroy() {
		this.HitConnection?.Disconnect();
		this.StateChangeConnection?.Disconnect();

		const state = this.instance.GetAttribute("State");
		const PrimaryPart = this.PrimaryPart as BasePart;

		this.instance.Destroy();
		//this.Destroy();
	}
}
