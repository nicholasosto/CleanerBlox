import { IAttachments } from "../Interfaces/IAttachments";

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
		this.Head = character.FindFirstChild("HatAttachment") as Attachment;
		this.LeftHand = character.FindFirstChild("LeftGripAttachment") as Attachment;
		this.RightHand = character.FindFirstChild("RightGripAttachment") as Attachment;
		this.LeftFoot = character.FindFirstChild("LeftFootAttachment") as Attachment;
		this.RightFoot = character.FindFirstChild("RightFootAttachment") as Attachment;
		this.Floor = character.FindFirstChild("FloorAttachment") as Attachment;
		this.Halo = character.FindFirstChild("HaloAttachment") as Attachment;
		this.Body = character.FindFirstChild("BodyAttachment") as Attachment;
	}
}
