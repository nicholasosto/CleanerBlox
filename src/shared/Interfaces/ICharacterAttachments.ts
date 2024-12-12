export interface ICharacterAttachments {
	Character: Model;
	Head: Attachment;
	LeftHand: Attachment;
	RightHand: Attachment;
	LeftFoot: Attachment;
	RightFoot: Attachment;
	Floor: Attachment;
	Halo: Attachment;
	Body: Attachment;
}

export class CharacterAttachments implements ICharacterAttachments {
	Character: Model;
	Head: Attachment;
	LeftHand: Attachment;
	RightHand: Attachment;
	LeftFoot: Attachment;
	RightFoot: Attachment;
	Floor: Attachment;
	Halo: Attachment;
	Body: Attachment;

	constructor(rig: Model) {
		this.Character = rig;
		this.Head = rig.FindFirstChild("Head")?.FindFirstChild("HairAttachment") as Attachment;
		this.LeftHand = rig.FindFirstChild("LeftHand")?.FindFirstChild("LeftGripAttachment") as Attachment;
		this.RightHand = rig.FindFirstChild("RightHand")?.FindFirstChild("RightGripAttachment") as Attachment;
		this.LeftFoot = rig.FindFirstChild("LeftFoot")?.FindFirstChild("LeftFootAttachment") as Attachment;
		this.RightFoot = rig.FindFirstChild("RightFoot")?.FindFirstChild("RightFootAttachment") as Attachment;
		this.Floor = rig.FindFirstChild("Floor")?.FindFirstChild("FloorAttachment") as Attachment;
		this.Halo = rig.FindFirstChild("Halo")?.FindFirstChild("HaloAttachment") as Attachment;
		this.Body = rig.FindFirstChild("LowerTorso")?.FindFirstChild("WaistCenterAttachment") as Attachment;

		if (!this.Halo) {
			this.Halo = new Instance("Attachment");
			this.Halo.Name = "HaloAttachment";
			this.Halo.Position = new Vector3(0, 2, 0);
			this.Halo.Parent = rig.FindFirstChild("Head") as BasePart;
		}

		if (!this.Floor) {
			this.Floor = new Instance("Attachment");
			this.Floor.Name = "FloorAttachment";
			this.Floor.Position = new Vector3(0, -2, 0);
			this.Floor.Parent = rig.FindFirstChild("HumanoidRootPart") as BasePart;
		}

		if (
			!this.Head ||
			!this.LeftHand ||
			!this.RightHand ||
			!this.LeftFoot ||
			!this.RightFoot ||
			!this.Floor ||
			!this.Halo ||
			!this.Body
		) {
			throw "CharacterAttachments: One or more attachments are missing";
		}

		return this;
	}
}
