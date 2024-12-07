import { HoldableSkill, SkillDecorator, Message } from "@rbxts/wcs";
import { ReplicatedStorage } from "@rbxts/services";
import { rotateModel, rotatePart } from "shared/PartEffects";

const SkillModels = {
	Spotlight: ReplicatedStorage.FindFirstChild("CastingSpotlight", true) as Model,
	Casting_Circle: ReplicatedStorage.FindFirstChild("CastingCircle", true) as Model,
};

const SkillConfiguration: Configuration = ReplicatedStorage.FindFirstChild("Config_Spotlights", true) as Configuration;
const Sounds = SkillConfiguration.FindFirstChild("_Sounds") as Folder;
const Animations = SkillConfiguration.FindFirstChild("_Animations") as Folder;
const Models = SkillConfiguration.FindFirstChild("_Ref_Models") as Folder;

@SkillDecorator
export class Spotlights extends HoldableSkill {
	protected initiate() {
		print("Spotlights initiated");
		const numSpotlights = 3;

		// Get the casting FLOOR attachment
		const characterModel = this.Character.Instance as Model;
		const castingAttachment = characterModel.FindFirstChild("CastingFloor", true) as Attachment;
		print(castingAttachment.Position);

		// Clone Model Parts
		// (1) Casting Circle
		const castingCircle = SkillModels.Casting_Circle.Clone();
		castingCircle.PivotTo(castingAttachment.WorldCFrame);
		castingCircle.Parent = castingAttachment;

		// Spotlights
		const castingSpotlights = new Array<Model>();
		for (let i = 0; i < numSpotlights; i++) {
			const spotlight = SkillModels.Spotlight.Clone();
			castingSpotlights.push(spotlight);
			//castingSpotlights[i].Parent = characterModel;
			//castingSpotlights[i].PivotTo(characterModel.GetPivot().mul(new CFrame(1, 1, 1.5)));
		}
	}

	protected stage1() {
		print("Spotlights stage 1");
	}

	protected stage2() {
		print("Spotlights stage 2");
	}

	protected stage3() {
		print("Spotlights stage 3");
		rotateModel(this.Character.Instance as Model, 1);
	}

	public OnStartServer() {
		warn("Spotlights Started");
		this.initiate();
	}

	public OnEndServer() {
		warn("Spotlights Ended");
	}

	public OnConstructServer() {
		warn("Spotlights Constructed");

		// Set the Max Hold Time for the skill
		this.SetMaxHoldTime(5);

		// Connect to the HoldTimer's secondReached event
		this.HoldTimer.secondReached.Connect((second) => {
			switch (second) {
				case 3:
					this.stage1();
					break;
				case 2:
					this.stage2();
					break;
				case 1:
					this.stage3();
					break;
				default:
					break;
			}
		});
		this.HoldTimer.start();
	}
}
