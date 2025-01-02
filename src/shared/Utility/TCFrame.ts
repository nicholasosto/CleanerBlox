// Objective: Provide a Service to handle CFrames position and rotation
import { RunService, TweenService, Workspace } from "@rbxts/services";

export enum FormationFrames {
	Circle,
	Line,
	Square,
	Triangle,
	Diamond,
	Pentagon,
	Hexagon,
	Octagon,
	Decagon,
	Dodecagon,
	Star,
}

export class TCFrame {
	constructor() {
		// Constructor
	}

	private static createFire() {
		const fire = new Instance("Fire");
		fire.Size = 5;
		fire.Heat = 10;
		fire.Color = Color3.fromRGB(255, 0, 0);
		fire.Enabled = true;
		return fire;
	}

	private static CircleFormation(modelSourceAttachment: Attachment) {
		// Generate a circle formation

		// Set default values
		const numPositions = 9;
		const radius = 15;
		const distanceFromSource = 10;
		const directionVector = new Vector3(0, 1, 0);

		// Create an array of attachments to return
		const attachments: Array<Attachment> = new Array<Attachment>();
		// Add the source attachment to the array position 0
		// Get the source CFrame world position
		const sourceCFrame = modelSourceAttachment.WorldCFrame;
		const destinationCenterPoint = new Vector3(sourceCFrame.X, sourceCFrame.Y, sourceCFrame.Z - distanceFromSource);

		// Generate the circle formation
		for (let i = 0; i < numPositions; i++) {
			// Calculate the angle
			const angle = ((2 * math.pi) / numPositions) * i;

			// Goal Position
			const goalPosition = new Vector3(
				radius * math.cos(angle),
				destinationCenterPoint.Y,
				destinationCenterPoint.Z + radius * math.sin(angle),
			);

			// Calculate the goal CFrame
			const goalCFrame = new CFrame(goalPosition);

			// Create a new attachment
			const attachment = new Instance("Attachment");
			attachment.Name = "CircleAttachment_" + i;
			attachment.Position = goalPosition;
			attachment.Parent = modelSourceAttachment.Parent;

			// Temp Create Fire
			const fire = this.createFire();
			fire.Parent = attachment;

			// Set the attachment Parent
			attachments.push(attachment);
		}

		return attachments;
	}

	// Line Formation
	private static LineFormation(
		modelSourceAttachment: Attachment,
		numPositions: number = 2,
		distanceFromSource: number = 70,
	) {
		// Create an array of attachments to return
		const attachments: Array<Attachment> = new Array<Attachment>();
		const sourceAttachment = modelSourceAttachment;
		// Add the source attachment to the array position 0
		//attachments.push(sourceAttachment);
		warn("Line Formation: ", numPositions, " positions", " distance from source: ", distanceFromSource, " studs");
		// Destination Attachment
		const destinationAttachment = new Instance("Attachment");
		destinationAttachment.Name = "DestinationAttachment";
		destinationAttachment.Position = new Vector3(
			sourceAttachment.WorldCFrame.X,
			sourceAttachment.WorldCFrame.Y,
			sourceAttachment.WorldCFrame.Z - distanceFromSource,
		);
		//Logger.Log(script,"Destination Attachment Position: ", destinationAttachment.Position);

		// Calculate the segment length based on the number of positions and the distance from the source
		const segmentLength = distanceFromSource / numPositions;
		// Create the line formation
		for (let i = 0; i < numPositions; i++) {
			// Calculate the goal position
			const goalPosition = new Vector3(
				sourceAttachment.WorldCFrame.X,
				sourceAttachment.WorldCFrame.Y,
				sourceAttachment.WorldCFrame.Z - segmentLength * i,
			);

			// Create a new attachment
			const attachment = new Instance("Attachment");
			attachment.Name = "LineAttachment_" + i;
			attachment.Position = goalPosition;
			attachment.Parent = sourceAttachment.Parent;

			// Temp Create Fire
			const fire = this.createFire();
			fire.Parent = attachment;

			attachments.push(attachment);
		}

		return attachments;
	}

	public static generateAttachments(modelSourceAttachment: Attachment, formation: FormationFrames, tweenTo: boolean) {
		let attachments: Array<Attachment> = new Array<Attachment>();
		switch (formation) {
			case FormationFrames.Circle:
				attachments = this.CircleFormation(modelSourceAttachment);
				break;
			case FormationFrames.Line:
				attachments = this.LineFormation(modelSourceAttachment);
				break;
			case FormationFrames.Square:
				// Generate a square formation
				break;
			case FormationFrames.Triangle:
				// Generate a triangle formation
				break;
			case FormationFrames.Diamond:
				// Generate a diamond formation
				break;
			case FormationFrames.Pentagon:
				// Generate a pentagon formation
				break;
			case FormationFrames.Hexagon:
				// Generate a hexagon formation
				break;
			case FormationFrames.Octagon:
				// Generate an octagon formation
				break;
			case FormationFrames.Decagon:
				// Generate a decagon formation
				break;
			case FormationFrames.Dodecagon:
				// Generate a dodecagon formation
				break;
			case FormationFrames.Star:
				// Generate a star formation
				break;
			default:
				break;
		}
		return attachments;
		// Remove the RenderStepped connection code
	}
}
