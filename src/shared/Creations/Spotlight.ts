import { ReplicatedStorage, Workspace, TweenService } from "@rbxts/services";
const SoulSteelStorage = ReplicatedStorage.FindFirstChild("SoulSteelStorage", true) as Folder;

export class Spotlight {
	//create a contructor that takes in the spotlight model
	private instance: Model;
	private hitPart: Part;
	private Character: Model;
	private StateValue: StringValue;
	public imageId: string = "rbxassetid://82703415014111";
	public AttachmentParent: Attachment | undefined;

	// Constructor
	constructor(character: Model, attachment: Attachment) {
		// Validate the model and configuration
		// Model Validation
		const _spotlightModel = SoulSteelStorage.FindFirstChild("Spotlight", true)?.Clone() as Model;
		const _spotlightConfiguration = _spotlightModel.FindFirstChildOfClass("Configuration") as Configuration;
		const _hitpart = _spotlightModel.FindFirstChild("HitPart") as Part;

		if (!_spotlightModel || !_spotlightConfiguration || !_hitpart) {
			error("Spotlight model or configuration not found.");
		}

		// Initialize the spotlight
		this.instance = _spotlightModel; // Cloned already
		this.hitPart = _hitpart;
		this.instance.PrimaryPart = this.hitPart; // Set the PrimaryPart
		this.Character = character;
		this.AttachmentParent = attachment;

		// Initialize the StateValue reference object
		this.StateValue = _spotlightConfiguration.FindFirstChild("State") as StringValue;

		// Listen for property changes
		this.InitializePropertyChangeListeners();

		// Set the initial state
		this.StateValue.Value = "Idle";
		return this;
	}

	// Initialize Property Change Listeners
	protected InitializePropertyChangeListeners() {
		// State Value Changed
		this.StateValue.GetPropertyChangedSignal("Value").Connect(() => {
			this.OnStateChanged();
		});

		// Hit Part Touched
		this.hitPart.Touched.Connect((hit) => {
			print("Hit Part Touched");
			if (hit.Parent !== this.Character && hit.Parent?.IsA("Model")) {
				this.hitPart.Color = Color3.fromRGB(255, 0, 0);
				this.StateValue.Value = "Triggered";
			}
		});
	}

	// State Changed
	protected OnStateChanged() {
		switch (this.StateValue.Value) {
			case "Idle":
				this.OnIdle();
				break;
			case "Triggered":
				this.OnTriggered();
				break;
			case "Inactive":
				this.OnInactive();
				break;
			default:
				break;
		}
	}

	protected OnIdle() {
		print("Spotlight is Idle");
		const tweenInfo = new TweenInfo(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);

		const spotlightBasePosition = this.instance.PrimaryPart?.Position as Vector3;
		const tweenService = TweenService;

		//TweenTest
		const part = new Instance("Part");
		part.Size = new Vector3(4, 4, 4);
		part.Anchored = false;
		part.Position = new Vector3(0, 10, 0);
		part.Parent = Workspace;

		const testTween = TweenService.Create(part, new TweenInfo(2), {
			Position: new Vector3(20, 10, 0),
		});

		testTween.Play();
		//TweenTest

		const moveSpotlight = () => {
			if (this.StateValue.Value !== "Idle") return;

			const randomOffset = new Vector3(
				math.random(-20, 20),
				math.random(0, 2), // Adjust for vertical range if needed
				math.random(-20, 20),
			);

			const targetPosition = spotlightBasePosition.add(randomOffset);

			// Ensure the CFrame is constructed with the target position
			const targetCFrame = new CFrame(targetPosition);

			// Create the tween to move the spotlight
			const tween = tweenService.Create(this.instance.PrimaryPart as BasePart, tweenInfo, {
				CFrame: targetCFrame.mul(CFrame.Angles(0, 0, math.rad(90))),
			});

			tween.Completed.Connect(() => {
				if (this.StateValue.Value === "Idle") {
					print("Spotlight has reached the target position");
					moveSpotlight(); // Continue the idle behavior
				}
			});

			tween.Play();
		};

		moveSpotlight();
	}

	protected OnTriggered() {
		print("Spotlight is Triggered");
	}

	protected OnInactive() {
		print("Spotlight is Inactive");
	}

	public SpawnSpotlight() {
		this.instance.Parent = Workspace;
		const WorldCFrame = this.AttachmentParent?.WorldCFrame;

		if (!WorldCFrame) {
			warn("AttachmentParent WorldCFrame is not set.");
			return;
		}

		// Apply a rotation to adjust the orientation
		let adjustedCFrame = WorldCFrame.mul(CFrame.Angles(0, 0, math.rad(90))); // Rotate 90 degrees around the Z-axis

		adjustedCFrame = adjustedCFrame.add(new Vector3(0, 13, 0)); // Adjust the position if needed

		this.instance.PivotTo(adjustedCFrame);

		const stringVector =
			"Location: [" +
			math.round(this.instance.GetPivot().Position.X) +
			", " +
			math.round(this.instance.GetPivot().Position.Y) +
			", " +
			math.round(this.instance.GetPivot().Position.Z) +
			"]";
		print("Spawning spotlight at position: ", stringVector);
		return this.instance;
	}
}
