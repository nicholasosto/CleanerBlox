import { Players } from "@rbxts/services";
import { Character } from "@rbxts/wcs";
import { Attack } from "shared/Skills/Attack";

Players.PlayerAdded.Connect((Player) => {
	Player.CharacterAdded.Connect((CharacterModel) => {
		// apply the wrap when character model gets created
		const WCS_Character = new Character(CharacterModel);

		// apply our freshly made skill
		new Attack(WCS_Character);

		// destroy it when humanoid dies
		const humanoid = CharacterModel.WaitForChild("Humanoid") as Humanoid;
		humanoid.Died.Once(() => WCS_Character.Destroy());
	});
});
