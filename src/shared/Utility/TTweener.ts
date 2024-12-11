import { TweenService } from "@rbxts/services";
import { Logger } from "shared/Utility/Logger";
import { CFrameGenerator } from "./CFrameGenerator";

export const InfoTable = {
	Standard: {
		Default: new TweenInfo(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0),
		Fast: new TweenInfo(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0),
		Slow: new TweenInfo(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0),
	},
	Elastic: {
		Default: new TweenInfo(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, -1, false, 0),
		Fast: new TweenInfo(0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, -1, false, 0),
		Slow: new TweenInfo(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, -1, false, 0),
	},
	Bounce: {
		Default: new TweenInfo(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, -1, false, 0),
		Fast: new TweenInfo(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, -1, false, 0),
		Slow: new TweenInfo(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, -1, false, 0),
	},
};

export type TweenablePartProperties = {
	Position?: Vector3;
	Orientation?: Vector3;
	Size?: Vector3;
	Color?: Color3;
	Transparency?: number;
	Reflectance?: number;
	CFrame?: CFrame;
};

export class TTweener {
	private constructor() {}

	// eslint-disable-next-line prettier/prettier
	public static tweenPart(part: Part,  properties: TweenablePartProperties, callback?: () => void): Tween {
		const tween = TweenService.Create(part, InfoTable.Standard.Default, properties);
		if (callback) {
			tween.Completed.Connect(callback);
		}
		return tween;
	}
	public static tweenPartCFrame(part: Part, newCFrame: CFrame, overDuration: number, callback?: () => void): Tween {
		const defaultTweenInfo = InfoTable.Standard.Default;
		const tweenInfo = new TweenInfo(
			overDuration,
			defaultTweenInfo.EasingStyle,
			defaultTweenInfo.EasingDirection,
			-1,
			false,
			defaultTweenInfo.DelayTime,
		);
        const properties = { CFrame: newCFrame };
        const tween = TweenService.Create(part, tweenInfo, properties);

        if (callback) {
            tween.Completed.Connect(callback);
        }
        return tween;
	}
}
