import { Logger } from "shared/Utility/Logger";
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
		const characterHead = character.WaitForChild("Head");
		this.Head = character.FindFirstChild("HatAttachment") as Attachment;
		this.LeftHand = character.FindFirstChild("LeftGripAttachment") as Attachment;
		this.RightHand = character.FindFirstChild("RightGripAttachment") as Attachment;
		this.LeftFoot = character.FindFirstChild("LeftFootAttachment") as Attachment;
		this.RightFoot = character.FindFirstChild("RightFootAttachment") as Attachment;
		this.Floor = character.FindFirstChild("FloorAttachment") as Attachment;
		this.Halo = character.FindFirstChild("HaloAttachment") as Attachment;
		this.Body = character.FindFirstChild("BodyAttachment") as Attachment;

		const testFire = new Instance("Fire");
		testFire.Parent = game.Workspace;
		testFire.Size = 3;
		testFire.Heat = 2;
		testFire.Enabled = true;

		const testClone = testFire.Clone();

		// Halo Attachment
		if (this.Halo === undefined) {
			this.Halo = new Instance("Attachment");
			this.Halo.Name = "HaloAttachment";
			this.Halo.Parent = characterHead;
			this.Halo.Position = new Vector3(0, 1, 0);
			testClone.Parent = this.Halo;
			//Logger.Log("Halo", " - Constructed\n");
		}

		// Body Attachment
		if (this.Floor === undefined) {
			this.Floor = new Instance("Attachment");
			this.Floor.Name = "FloorAttachment";
			this.Floor.Parent = this.Body;
			this.Floor.Position = new Vector3(0, -2, 0);
		}

		//Logger.Log("EntityAttachments", " - Constructed\n");
	}
}
