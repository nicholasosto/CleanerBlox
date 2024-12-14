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