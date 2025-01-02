import { Character } from "@rbxts/wcs";
import { Logger } from "./Logger";

export class CharacterUtility {
	public static getClosestCharacterFrom(model: Model, maxRange: number): Character | undefined {
		const wcsCharacters = Character.GetCharacterMap();
		let closestCharacter: Character | undefined;
		let closestDistance = math.huge;
		const modelPosition = model.GetPivot().Position;
		for (const [, wcsCharacter] of pairs(wcsCharacters)) {
			const characterModel = wcsCharacter.Instance as Model;
			if (characterModel === model) {
				continue;
			}
			const characterPosition = characterModel.GetPivot().Position;
			const distance = characterPosition.sub(modelPosition).Magnitude;
			if (distance < closestDistance && distance <= maxRange) {
				Logger.Log(script,"CharacterUtility", `Distance: ${distance}`);
				closestDistance = distance;
				closestCharacter = wcsCharacter;
			}
		}
		return closestCharacter;
	}
}
