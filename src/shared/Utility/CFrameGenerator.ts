import { ICFrameCreator } from "shared/Interfaces/ICFrameGenerator";

/**
 * A class responsible for generating CFrames for skill activations or object 
 * placements. The user’s position and orientation are derived directly from the 
 * provided userCFrame.
 */

export class CFrameGenerator implements ICFrameCreator {

	createOffsetFrame(sourceFrame: CFrame, offsetFrame: CFrame): CFrame {
		return sourceFrame.mul(offsetFrame);
	}

	createTargetFrame(userCFrame: CFrame, offset: number): CFrame {
		return userCFrame.mul(new CFrame(0, -1* userCFrame.Y, -offset));
	}

	createRing(userCFrame: CFrame, radius: number, numPositions: number): CFrame[] {
		const angleIncrement = (2 * math.pi) / numPositions;
		const ringCFrames: CFrame[] = [];

		for (let i = 0; i < numPositions; i++) {
			const angle = i * angleIncrement;
			const x = radius * math.cos(angle);
			const z = radius * math.sin(angle);
			const position = new Vector3(x, 0, z);
			const cframe = new CFrame(userCFrame.Position.add(position));
			ringCFrames.push(cframe);
		}

		return ringCFrames;
	}
}