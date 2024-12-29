// AttributeLabel Class

// GameStorage
import { GameStorage } from "shared/Utility/GameStorage";

// Template
const Template = GameStorage.cloneGUIComponent("Attribute Label Template") as Frame;

// Attribute Label Class
export class AttributeLabel {
	// Public Variables
	public DisplayName: string;
	public AttributeName: string;

	// Private Variables
	private _instance: Frame = Template.Clone();
	private _attributeValueImage: ImageLabel | undefined;
	private _parent: Instance | undefined;
	private _targetInstance: Instance | undefined;
	private _connection: RBXScriptConnection | undefined;

	// Constructor
	constructor(displayName: string, attributeName: string) {
		this.DisplayName = displayName;
		this.AttributeName = attributeName;
	}

	// Called from UIService to create the Attribute Label
	public create(parent: Instance, targetInstance: Instance) {
		// Clone the template
		const instance = Template.Clone();

		// Get the NameFrame
		const NameFrame = instance.FindFirstChild("AttributeName", true) as Frame;
		// Set the DisplayName
		NameFrame.SetAttribute("TextValue", this.DisplayName);

		// Get the AttributeValueImage
		this._attributeValueImage = instance.FindFirstChild("AttributeValue", true) as ImageLabel;

		// Set the parent
		this._parent = parent;
		// Parent the instance
		instance.Parent = this._parent;

		// Set the target instance
		this._targetInstance = targetInstance;

		// Set the connections
		this.setConnections();

		// Update the label
		this.updateLabel();
	}

	// Set Connections
	private setConnections() {
		// Set the connections
		this._connection = this._targetInstance?.GetAttributeChangedSignal(this.AttributeName).Connect(() => {
			this.updateLabel();
		});
	}

	// Update Label
	private updateLabel() {
		// Get the current attribute from the target instance
		const currentAttribute = this._targetInstance?.GetAttribute(this.AttributeName) as number;

		// Check if the attribute is undefined
		if (currentAttribute === undefined) {
			warn("Current Attribute is undefined");
			return;
		}

		// Set the TextValue
		this._attributeValueImage?.SetAttribute("TextValue", tostring(currentAttribute));
	}
}
