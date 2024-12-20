import { GameStorage } from "shared/Utility/GameStorage";
import { TEventSuccessResponse } from "shared/SharedReference";

export class NotificationManager {
	private static _instance: NotificationManager;
	private static _notificationEvent: RemoteEvent = GameStorage.getEvent("NOTIFY_Player");
	private constructor() {
		// Constructor Logic
	}

	// Start
	public static Start() {
		if (NotificationManager._instance === undefined) {
			NotificationManager._instance = new NotificationManager();
		}
		return NotificationManager._instance;
	}

	public static Notify(player: Player, eventResponse: TEventSuccessResponse, timeout: number = 2) {
		// Enable player's notification panel
		const playerGui = player.FindFirstChildOfClass("PlayerGui");
		const NotificationPanel = playerGui?.FindFirstChild("NotificationPanel") as ScreenGui;
		NotificationPanel.Enabled = true;

		// Set the message
		const MessageLabel = NotificationPanel.FindFirstChild("MessageLabel", true) as TextLabel;
		MessageLabel.Text = eventResponse.message;

		// Set the color
		if (eventResponse.success) {
			MessageLabel.TextColor3 = new Color3(0, 1, 0);
		} else {
			MessageLabel.TextColor3 = new Color3(1, 0, 0);
		}

		// Hide the panel after the timeout
		task.delay(timeout, () => {
			NotificationPanel.Enabled = false;
			MessageLabel.Text = "";
		});
	}
}
