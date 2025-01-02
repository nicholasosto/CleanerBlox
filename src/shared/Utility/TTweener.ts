import { TweenService, CollectionService } from "@rbxts/services";
import { Logger } from "shared/Utility/Logger";
import { PositionGenerator } from "./PositionGenerator";

export class TagTweener {
	private static _instance: TagTweener;

	private _instanceAddedConnection: RBXScriptConnection | undefined;

	private constructor() {
		this._instanceAddedConnection = CollectionService.GetInstanceAddedSignal("TweenAttachment").Connect((instance) => {
			const attachment = instance as Attachment;
			if (attachment === undefined) {
				Logger.Log(script,"BasicMelee", "Instance is not an attachment");
				return;
			}

			const duration = 1;
			const endPosition = new Vector3(5, 0, 0);
			const repetes = -1;
			TagTweener.StartLinearTween(attachment, duration, endPosition, repetes);
		});
	}

	public static Start() {
		if (this._instance === undefined) {
			this._instance = new TagTweener();
		}	
	}

	public static StartLinearTween(attachment: Attachment, duration: number, endPosition: Vector3, repetes: number) {
		const startPosition = attachment.Position;
		const tweenInfo = new TweenInfo(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, repetes, false, 0);
		const tween = TweenService.Create(attachment, tweenInfo, { Position: endPosition });
		tween.Completed.Connect(() => {
			attachment.Position = endPosition;
		});
		tween.Play();
	}
}