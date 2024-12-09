import { HoldableSkill, SkillDecorator, Message } from "@rbxts/wcs";
import { ReplicatedStorage } from "@rbxts/services";

const AnimationsFolder = ReplicatedStorage.FindFirstChild("Melee Unarmed",true) as Folder;
const Animations = AnimationsFolder.GetChildren().map((animation) => animation as Animation);

@SkillDecorator
export class Block extends HoldableSkill {
	@Message({
		Type: "Event",
		Destination: "Client",
	})
	protected ClientCode() {
		warn("Block Activated");
	}

	public OnStartServer() {
		warn("Block Started");
		this.HoldTimer.secondReached.Connect((second) => {
			warn("Block Held: ", second);
		});
		const humanoid: Humanoid = this.Character.Humanoid;
		const animator = humanoid.FindFirstChildOfClass("Animator") as Animator | undefined;
		if (!animator) {
			warn("Animator not found");
			return;
		}
		const animationTrack = animator.LoadAnimation(Animations[1]);
		//animationTrack.Play();
	}

	public OnEndServer() {
		warn("Block Ended");
	}

	public OnConstructServer() {
		warn("Block Constructed");
		this.SetMaxHoldTime(3);
	}
}
