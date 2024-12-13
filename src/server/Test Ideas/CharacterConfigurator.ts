import { Players } from "@rbxts/services";
import { ParticleEmitter } from "../../shared/TRef";

export class CharacterConfigurator {
	constructor() {
		Players.PlayerAdded.Connect((player) => {
			player.CharacterAdded.Connect((character) => {
				print("Character Configurator: Character added");
				//this.configureCharacter(character);
			});
		});
	}

	//private effectNames = ["AbilityParticle1", "AbilityParticle2"]; // Add effect keys here

	private configureCharacter(character: Model) {
		// ...existing code...
		// const humanoidRootPart = character.WaitForChild("HumanoidRootPart") as Part;
		// const humanoid: Humanoid = character.WaitForChild("Humanoid") as Humanoid;
		// const lowerTorso = character.WaitForChild("LowerTorso") as Part;

		// const attachment = new Instance("Attachment");
		// attachment.Name = "CastingFloor";
		// attachment.Parent = lowerTorso;
		// // get the pivot of the character

		// // set the y position of the attachment to the floor
		// attachment.Position = new Vector3(0, -1 * humanoid.HipHeight, 0);
	}

	/*
	public enableEffect(character: Model, effectName: string) {
		const particleEffect = character
			.FindFirstChild("HumanoidRootPart")
			?.FindFirstChild("AbilityAttachment")
			?.FindFirstChild(effectName) as ParticleEmitter;
		if (particleEffect) {
			particleEffect.Enabled = true;
		}
	}

	public disableEffect(character: Model, effectName: string) {
		const particleEffect = character
			.FindFirstChild("HumanoidRootPart")
			?.FindFirstChild("AbilityAttachment")
			?.FindFirstChild(effectName) as ParticleEmitter;
		if (particleEffect) {
			particleEffect.Enabled = false;
		}
	}
		*/
}
