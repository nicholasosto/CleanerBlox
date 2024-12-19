import { GameStorage } from "shared/Utility/GameStorage";

export class GUIController {
	private static _instance: GUIController;
	private static _notificationConnection: RBXScriptConnection | undefined;

	private constructor() {
		const NotificationEvent = GameStorage.getEvent("NOTIFY_Player");
		GUIController._notificationConnection = NotificationEvent.OnClientEvent.Connect((message: string) => {
			warn("Notification: ", message);
			// Logic to display the message
		});
	}
	public static Start() {
		if (GUIController._instance === undefined) {
			GUIController._instance = new GUIController();
		}
		return GUIController._instance;
	}
}
