export enum AttachmentPoints {
	Head = "Head",
	LeftHand = "LeftHand",
	RightHand = "RightHand",
	LeftFoot = "LeftFoot",
	RightFoot = "RightFoot",
	Floor = "Floor",
	Halo = "Halo",
	Body = "Body",
}

export interface IAttachments {
	[AttachmentPoints.Head]: Attachment;

	[AttachmentPoints.LeftHand]: Attachment;
	[AttachmentPoints.RightHand]: Attachment;

	[AttachmentPoints.LeftFoot]: Attachment;
	[AttachmentPoints.RightFoot]: Attachment;

	[AttachmentPoints.Floor]: Attachment;
	[AttachmentPoints.Halo]: Attachment;
	[AttachmentPoints.Body]: Attachment;
}

export class EntityAttachments implements IAttachments {
	Head: Attachment;
	LeftHand: Attachment;
	RightHand: Attachment;
	LeftFoot: Attachment;
	RightFoot: Attachment;
	Floor: Attachment;
	Halo: Attachment;
	Body: Attachment;

	constructor(character: Model) {
		const characterHead = character.WaitForChild("Head");
		this.Head = character.FindFirstChild("HatAttachment") as Attachment;
		this.LeftHand = character.FindFirstChild("LeftGripAttachment") as Attachment;
		this.RightHand = character.FindFirstChild("RightGripAttachment") as Attachment;
		this.LeftFoot = character.FindFirstChild("LeftFootAttachment") as Attachment;
		this.RightFoot = character.FindFirstChild("RightFootAttachment") as Attachment;
		this.Floor = character.FindFirstChild("FloorAttachment") as Attachment;
		this.Halo = character.FindFirstChild("HaloAttachment") as Attachment;
		this.Body = character.FindFirstChild("BodyAttachment") as Attachment;

		// Halo Attachment
		if (this.Halo === undefined) {
			this.Halo = new Instance("Attachment");
			this.Halo.Name = "HaloAttachment";
			this.Halo.Parent = characterHead;
			this.Halo.Position = new Vector3(0, 1, 0);
		}

		// Body Attachment
		if (this.Floor === undefined) {
			this.Floor = new Instance("Attachment");
			this.Floor.Name = "FloorAttachment";
			this.Floor.Parent = this.Body;
			this.Floor.Position = new Vector3(0, -2, 0);
		}
	}
}
