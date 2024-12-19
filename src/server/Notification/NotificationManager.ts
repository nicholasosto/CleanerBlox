import { GameStorage } from "shared/Utility/GameStorage";

export class NotificationManager {
	private static _instance: NotificationManager;
	private static _notificationEvent: RemoteEvent = GameStorage.getEvent("NOTIFY_Player");
	private constructor() {
		// Constructor Logic
	}

	public static Start() {
		if (NotificationManager._instance === undefined) {
			NotificationManager._instance = new NotificationManager();
		}
		return NotificationManager._instance;
	}

	public static Notify(player: Player, message: string) {
		NotificationManager._notificationEvent.FireClient(player, message);
		const playerGui = player.FindFirstChildOfClass("PlayerGui");
		const NotificationPanel = playerGui?.FindFirstChild("NotificationPanel") as ScreenGui;
		NotificationPanel.Enabled = true;
		const MessageLabel = NotificationPanel.FindFirstChild("MessageLabel", true) as TextLabel;

		MessageLabel.Text = message;
		task.delay(2, () => {
			NotificationPanel.Enabled = false;
			MessageLabel.Text = "";
		});
	}
}
