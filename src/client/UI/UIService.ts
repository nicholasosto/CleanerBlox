import { ReplicatedStorage, Players } from "@rbxts/services";
import { UIFactory } from "../../shared/UI/UIFactory";


export class UIService {

	constructor(playerGui: PlayerGui) {

		const player = Players.LocalPlayer;
		const playerAttributes = player.GetAttributes();
		warn("Player Attributes: ", playerAttributes);

		return this;
	}
}
