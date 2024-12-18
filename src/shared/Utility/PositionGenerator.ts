import {CollectionService, Workspace} from "@rbxts/services";
import {Logger} from "./Logger";

export class PositionGenerator {
	private static _instance: PositionGenerator;

	private constructor() {
		PositionGenerator._instance = this;
	}

	public static Start() {
		if (PositionGenerator._instance === undefined) {
			PositionGenerator._instance = new PositionGenerator();
		}
	}

	// Default Target Position
	public static GenerateDefaultTargetPosition(sourceModel: Model | BasePart, offset: number = 10): Vector3 {
		// get the source model's position and direction
		const sourceFrame = sourceModel.GetPivot();
		const sourcePosition = sourceFrame.Position;
		const sourceDirection = sourceFrame.LookVector;
		// ensure the target position is in front of the source model in the direction it is facing
		const targetPosition = sourcePosition.add(sourceDirection.mul(offset));
		return targetPosition;
	}

	public static GenerateRandomPositionsAroundSource(sourceModel: Model | BasePart, numPositions: number, radius: number): Vector3[] {
		// get the source model's position
		const sourceFrame = sourceModel.GetPivot();

		// set up the positions array
		const positions: Vector3[] = [];
		const angleIncrement = (2 * math.pi) / numPositions;
		

		// generate positions around the source model
		for (let i = 0; i < numPositions; i++) {
			const angle = i * angleIncrement;
			const x = radius * math.cos(angle);
			const z = radius * math.sin(angle);
			const position = new Vector3(x, 0, z);
			positions.push(sourceFrame.Position.add(position));
		}

		return positions;
	}

	public static CreateRing(userCFrame: CFrame, radius: number, numPositions: number): Vector3[] {
		const angleIncrement = (2 * math.pi) / numPositions;
		const ringCFrames: Vector3[] = [];

		for (let i = 0; i < numPositions; i++) {
			const angle = i * angleIncrement;
			const x = radius * math.cos(angle);
			const z = radius * math.sin(angle);
			const position = new Vector3(x, 0, z);
			const cframe = new CFrame(userCFrame.Position.add(position));
			ringCFrames.push(cframe.Position);
		}

		return ringCFrames;
	}

	private static PositionGeneratorTests(start: boolean) {
			const scriptBlock = game.GetService("Workspace").FindFirstChild("ScriptBlock", true) as BasePart;
			if (!start) {
				scriptBlock.ClearAllChildren();
				Logger.Log("PositionGeneratorTests", "Cleared Children");
				return;
			}
			const scriptBlockAttachment = new Instance("Attachment");
			scriptBlock.Name = "ScriptBlockAttachment";
			scriptBlockAttachment.Parent = scriptBlock;
	
			const randomPositionTest = PositionGenerator.GenerateRandomPositionsAroundSource(scriptBlock, 15, 22);
			const fireIndicator = new Instance("Fire");
			fireIndicator.Color = Color3.fromRGB(255, 222, 0);
			fireIndicator.Parent = scriptBlock;
			let beamCreated = false;
			randomPositionTest.forEach((position) => {
				const firePart = new Instance("Part");
				const fire = new Instance("Fire");
				const fireAttachment = new Instance("Attachment");
				fireAttachment.Parent = firePart;
				const beam = new Instance("Beam");
				if (!beamCreated) {
					beamCreated = true;
					beam.Parent = firePart;
					beam.Color = new ColorSequence(new Color3(1, 0, 0));
					beam.FaceCamera = true;
					beam.LightEmission = 1;
					beam.LightInfluence = 0;
					beam.Segments = 10;
					beam.Attachment0 = scriptBlockAttachment;
					beam.Attachment1 = fireAttachment;
	
					firePart.Name = "HitPart";
					firePart.Color = Color3.fromRGB(255, 0, 0);
				} else {
					beamCreated = false;
				}
	
				fire.Color = Color3.fromRGB(255, 222, 0);
				fire.Parent = firePart;
				firePart.Size = new Vector3(1, 1, 1);
				firePart.Position = position;
				firePart.Anchored = true;
				firePart.Parent = scriptBlock;
			});
	
			const defaultTargetPosition = PositionGenerator.GenerateDefaultTargetPosition(scriptBlock, 10);
		}
}
