import { ReplicatedStorage, Players } from "@rbxts/services";

const AttributeFrameTemplate = ReplicatedStorage.WaitForChild("UITemplates").WaitForChild("AttributeFrame");

export class UIFactory {
	private constructor() {
		// Private constructor to prevent instantiation
	}

	public static createAttributeFrame(player: Player, attribute: string): Frame {
		// Clone the template
		const attributeFrame = AttributeFrameTemplate.Clone() as Frame;

		// Listen for attribute changes
		player.GetAttributeChangedSignal(attribute).Connect((changedAttribute) => {
			//Logger.Log`Attribute ${attribute} changed to ${changedAttribute}`);
		});

		return attributeFrame;
	}
}
