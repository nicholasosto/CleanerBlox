import { Skill, SkillDecorator } from "@rbxts/wcs";
import { ReplicatedStorage, Debris } from "@rbxts/services";
import { Workspace } from "@rbxts/services";
import { rotateModel, rotatePart } from "shared/Utility/PartEffects";
import { ParticleEmitter, TParts } from "../TRef";

// Folder References
const ParticlePack = ReplicatedStorage.FindFirstChild("PARTICLE_PACK", true) as Folder;
const AnimationsFolder = ReplicatedStorage.FindFirstChild("Melee Unarmed", true) as Folder;
const CastingAnimationsFolder = ReplicatedStorage.FindFirstChild("Casting", true) as Folder;

// Animation References
const MeleeAnimations = AnimationsFolder.GetChildren().map((animation) => animation as Animation);
const CastingAnimations = CastingAnimationsFolder.GetChildren().map((animation) => animation as Animation);

@SkillDecorator
export class Attack extends Skill {
	protected duration: number = 2.5;

	protected initiation() {
		print("Attack initiated");

		const character: Model = this.Character.Instance as Model;

		// load the casting animation to the character
		const initialAnimation = this.Character.Humanoid.LoadAnimation(CastingAnimations[1]);

		// play the animation
		//initialAnimation.Play();

		const castingHandAuraRH = ParticlePack.FindFirstChild("Evil Emmination", true)?.Clone() as ParticleEmitter;
		const castingHandAuraLH = ParticlePack.FindFirstChild("Evil Emmination", true)?.Clone() as ParticleEmitter;

		const castingAura = ParticleEmitter.castingAura.Clone();
		const castingCircle = TParts.castingCircle.Clone();

		if (castingHandAuraRH && castingHandAuraLH) {
			Debris.AddItem(castingHandAuraRH, this.duration);
			Debris.AddItem(castingHandAuraLH, this.duration);
			castingHandAuraRH.Parent = character.FindFirstChild("RightHand") as BasePart;
			castingHandAuraLH.Parent = character.FindFirstChild("LeftHand") as BasePart;
			castingCircle.Parent = character.FindFirstChild("HumanoidRootPart") as BasePart;
			castingAura.Parent = character.FindFirstChild("HumanoidRootPart") as BasePart;
		}
	}

	protected spawnProjectile() {
		const projectile = new Instance("Part");
		projectile.Size = new Vector3(1, 1, 1);

		projectile.Parent = this.Character.Instance;
		projectile.Anchored = true;
		projectile.CanCollide = false;

		const characterModel = this.Character.Instance as Model;
		if (characterModel.PrimaryPart) {
			projectile.PivotTo(characterModel.GetPivot());
		}
	}

	public OnStartServer() {
		print("Hi, attack just started!");
		//this.initiation();
		//const humanoid = this.Character.Humanoid;
		//const animationTrack = this.Character.Humanoid.LoadAnimation(MeleeAnimations[0]);
		//animationTrack.Play();
		this.ApplyCooldown(3); // 3 second cooldown
	}
}
