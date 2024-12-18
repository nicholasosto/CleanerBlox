// Objective: Progress Bar Class

// GameStorage
import { GameStorage } from "shared/Utility/GameStorage";
import { Logger } from "shared/Utility/Logger";

// ProgressBar Template
const Template: Frame = GameStorage.getGUI("Progress Bar Template") as Frame;

// ProgressBar Class
export class ProgressBar {
	private _targetInstance: Instance; // The instance that contains the attributes to be watched
	private _instance: Frame; // The instance of the ProgressBar cloned from the template
	private _parent: Instance; // The parent of the ProgressBar

	// Constructor
	// eslint-disable-next-line prettier/prettier
	constructor( targetInstance: Instance, minAttributeName: string,	maxAttributeName: string, parent: Instance, displayName: string, colorSequence: ColorSequence) {
		// Clone the template
		this._instance = Template.Clone();

		// Set the parent
		this._parent = parent;

		// Set the model
		this._targetInstance = targetInstance as Instance;

		// update the color
		const gradient: UIGradient = this._instance.FindFirstChild("UIGradient", true) as UIGradient;
		const topFrame: Frame = this._instance.FindFirstChild("Top", true) as Frame;

		topFrame.BackgroundColor3 = colorSequence.Keypoints[0].Value;
		gradient.Color = colorSequence;

		// Set the connections
		this._targetInstance.GetAttributeChangedSignal(minAttributeName).Connect(() => {
			this.updateProgressBar(minAttributeName, maxAttributeName);
		});

		this._targetInstance.GetAttributeChangedSignal(maxAttributeName).Connect(() => {
			this.updateProgressBar(minAttributeName, maxAttributeName);
		});

		//Logger.Log("** Connections Set **");

		// Set the parent
		this._instance.Parent = this._parent;

		this._instance.SetAttribute("TextValue", displayName);

		// Set the ProgressBar
		this.updateProgressBar(minAttributeName, maxAttributeName);
	}

	// Update ProgressBar
	public updateProgressBar(currentName: string, maxName: string) {
		// Get the current and max attributes from the target instance
		const currentAttribute = this._targetInstance.GetAttribute(currentName) as number;
		const maxAttribute = this._targetInstance.GetAttribute(maxName) as number;

		// Check if the attributes are undefined
		if (currentAttribute === undefined || maxAttribute === undefined) {
			Logger.Log("Current or Max Attribute is undefined");
			return;
		}

		// Calculate the percentage
		const percentage = math.round((currentAttribute / maxAttribute) * 100);

		// Set the percentage
		this._instance.SetAttribute("BarPercent", percentage);
	}

	// Destroy ProgressBar
	public destroy() {
		this._instance.Destroy();
	}
}
