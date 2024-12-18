import { Skill, SkillDecorator } from "@rbxts/wcs";
import { AnimationManager, AudioManager } from "shared/WCS/SkillManagers";
import { ParticleGroupManager } from "shared/Utility/ParticleGroupManager";
import { PositionGenerator } from "shared/Utility/PositionGenerator";
import { WeaponManager } from "../Movesets/WeaponManager";
import { TweenService, Workspace } from "@rbxts/services";
import { Logger } from "shared/Utility/Logger";

@SkillDecorator
export class ShapeTester extends Skill {
	// 00. CONSTRUCT
	public OnConstruct() {
		Logger.Log("ShapeTester", "OnConstruct");
	}

	public OnConstructServer(): void {}

	// 01. CONSTRUCT CLIENT
	public OnConstructClient(): void {}

	// MOVE START
	public OnStartServer() {
		Logger.Log("ShapeTester", "OnStartServer");
		const fire = new Instance("Fire");
		fire.Size = 3;
		fire.Parent = this.Character.Instance as Model;
		const firePart = new Instance("Part");
		firePart.Parent = this.Character.Instance as Model;
		fire.Parent = firePart;
		firePart.Size = new Vector3(0.5, 0.5, 0.5);
		firePart.Anchored = true;

		const character = this.Character.Instance as Model;
		if (character === undefined) {
			Logger.Log("ShapeTester", "No Character Found");
			return;
		}
		const spiral = PositionGenerator.CreateSpiral(character.GetPivot(), 10, 100, 2);
		const spiralParts: Part[] = [];
		spiral.forEach((position) => {
			const part = new Instance("Part");
			part.Size = new Vector3(1, 1, 1);
			part.Position = position;
			part.Name = "SpiralPart" + tostring(position.X) + tostring(position.Y) + tostring(position.Z);
			part.Anchored = true;
			part.Parent = Workspace.FindFirstChild("JSONParts") as Folder;
			spiralParts.push(part);
		});

		const spawnedParts = Workspace.FindFirstChild("JSONParts")?.GetChildren() as Array<Part>
		
		spawnedParts.forEach((part) => {
			print(part.GetPivot().Position);
			const position = part.GetPivot().Position;
			print(position);
			task.wait(1);
		});
	}

	// END SERVER
	public OnEndServer() {}
}
