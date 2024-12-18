import { Skill, SkillDecorator } from "@rbxts/wcs";
import { AnimationManager, AudioManager } from "shared/WCS/SkillManagers";
import { ParticleGroupManager } from "shared/Utility/ParticleGroupManager";
import { WeaponManager } from "../Movesets/WeaponManager";
import { Logger } from "shared/Utility/Logger";
import { Character, DamageContainer } from "@rbxts/wcs";

@SkillDecorator
export class BasicMelee extends Skill {
	public static SkillConfiguration = {
		DisplayName: "Clean Basic",
		ImageId: "rbxassetid://132928610589911",
		ActivationAnimationId: "rbxassetid://77799116860007",
		ActivationSoundId: "rbxassetid://511715134",
		ActivationParticleGroup: "SwordHitEff2",
		ActivationTime: 0.8,
		DefaultHealthChange: 22,
		DefaultHoldTime: 0,
		DefaultCooldownTime: 0.5,
		DefaultManaCost: 10,
		DefaultStaminaCost: 10,
	};

	public ActivationAnimationTrack: AnimationTrack | undefined;
	public ActivationSound: Sound | undefined;
	public ActivationParticles: ParticleEmitter[] | undefined;
	public SkillWeapon: Accessory | undefined;
	public SkillHitPart: BasePart | undefined;
	public HitPartConnection: RBXScriptConnection | undefined;
	public DamageContainer: DamageContainer | undefined;

	// 00. CONSTRUCT
	public OnConstruct() {
		//Logger.Log("BasicMelee", "OnConstruct");
	}

	public OnConstructServer(): void {
		Logger.Log("BasicMelee", "OnConstructServer");
		const character = this.Character.Instance;
		if (character === undefined) {
			Logger.Log("BasicMelee", "No Character Found");
			return;
		}
		this.DamageContainer = this.CreateDamageContainer(BasicMelee.SkillConfiguration.DefaultHealthChange);

		// Load Sound
		// eslint-disable-next-line prettier/prettier
		this.ActivationSound = AudioManager.LoadWCSSound(this.Character, "BasicMelee_ActivationAudio", BasicMelee.SkillConfiguration.ActivationSoundId);
		// Load Animation
		// eslint-disable-next-line prettier/prettier
		this.ActivationAnimationTrack = AnimationManager.LoadWCSCharacterAnimation(this.Character, "BasicMelee_ActivationAnimation", BasicMelee.SkillConfiguration.ActivationAnimationId, BasicMelee.SkillConfiguration.ActivationTime);
		// Load Particles
		// eslint-disable-next-line prettier/prettier
		this.ActivationParticles = ParticleGroupManager.GetParticleGroup(BasicMelee.SkillConfiguration.ActivationParticleGroup);
		ParticleGroupManager.ParentParticleEmtters(
			this.ActivationParticles,
			this.Character.Instance.FindFirstChild("RightGripAttachment", true) as Instance,
		);
		ParticleGroupManager.DisableParticleEmitters(this.ActivationParticles as [ParticleEmitter]);

		// Load Weapon
		this.SkillWeapon = WeaponManager.LoadWCSCharacterWeapon(this.Character, "Scythe_Epic_Black");
		this.SkillHitPart = this.SkillWeapon?.FindFirstChild("Handle") as BasePart;
		if (this.SkillHitPart === undefined) {
			//Logger.Log("BasicMelee", "No Hit Part Found");
			return;
		}
		this.HitPartConnection?.Disconnect();
		this.HitPartConnection = this.SkillHitPart.Touched.Connect((hit) => {
			Logger.Log("BasicMelee", `Hit: ${hit.Parent?.Name}`);

			if (hit.Parent === this.Character.Instance) {
				Logger.Log("BasicMelee", "Hit Self");
				return;
			}
			if (hit.Parent?.FindFirstChild("Humanoid") === undefined) {
				Logger.Log("BasicMelee", "No Humanoid Found");
				return;
			}
			let targetCharacter = Character.GetCharacterFromInstance(hit.Parent as Instance);
			if (targetCharacter === undefined) {
				targetCharacter = Character.GetCharacterFromInstance(hit.Parent?.Parent as Instance);
				Logger.Log("BasicMelee", "No Target Character Found");
				targetCharacter?.TakeDamage(this.DamageContainer as DamageContainer);
			}
			//hit.Parent = undefined;
		});
		//ParticleGroupManager.DisableParticleEmitters(this.ActivationParticles as [ParticleEmitter]);
		Logger.Log("BasicMelee", "Animation, Sound, and Particles Loaded");
	}

	// 01. CONSTRUCT CLIENT
	public OnConstructClient(): void {
		Logger.Log("BasicMelee", "OnConstructClinet");
	}

	// MOVE START
	public OnStartServer() {
		this.ApplyCooldown(BasicMelee.SkillConfiguration.DefaultCooldownTime);
		this.Character.TakeDamage(this.CreateDamageContainer(10));
		this.ActivationSound?.Play();
		AnimationManager.PlayAnimation(
			this.ActivationAnimationTrack as AnimationTrack,
			BasicMelee.SkillConfiguration.ActivationTime,
		);
		//this.ActivationAnimationTrack?.Play();
		ParticleGroupManager.EnableParticleEmitters(this.ActivationParticles as [ParticleEmitter]);
		WeaponManager.EquipWCSCharacterWeapon(this.Character, "Scythe_Epic_Black");

		// Cooldown Timer
		this.CooldownTimer.secondReached.Connect((seconds) => {
			Logger.Log("BasicMelee", `PE Cooldown: ${seconds}`);
		});
	}

	// END SERVER
	public OnEndServer() {
		Logger.Log("BasicMelee", "OnEndServer");
		task.delay(BasicMelee.SkillConfiguration.ActivationTime, () => {
			ParticleGroupManager.DisableParticleEmitters(this.ActivationParticles as [ParticleEmitter]);
			WeaponManager.UnEquipWCSCharacterWeapon(this.Character.Player as Player, this.SkillWeapon as Accessory);
		});
	}
}
