import { HttpService } from "@rbxts/services";
import { PlayerData, StatsData } from "shared/Interfaces/TInterfaces";

export class PlayerAttributes {
	private constructor() {
		// Private constructor to prevent instantiation
	}

	// Creates Player Attributes
	public static createAttributes(player: Player, playerData: PlayerData): void {

		// Set Core Stats
		this.setCoreStats(player, playerData.Stats);

		// Sets Derived Stats
		// Health
		this.setHealthStat(player, playerData.Level, playerData.Stats.Constitution);
		this.setManaStat(player, playerData.Level, playerData.Stats.Intelligence);
		this.setStaminaStat(player, playerData.Level, playerData.Stats.Strength, playerData.Stats.Constitution);
		this.setExperienceStats(player, playerData);
	}

	// Core Stats:  [StatsData]
	private static setCoreStats(player: Player, statData: StatsData): void {
		player.SetAttribute("Strength", statData.Strength);
		player.SetAttribute("Speed", statData.Speed);
		player.SetAttribute("Dexterity", statData.Dexterity);
		player.SetAttribute("Intelligence", statData.Intelligence);
		player.SetAttribute("Constitution", statData.Constitution);
	}

	// Health Stat: Derived from [Constitution and Level]
	private static setHealthStat(player: Player, level: number, constitution: number): void {
		const maxHealth = math.round(constitution * (level / 3) + 100);
		player.SetAttribute("CurrentHealth", maxHealth);
		player.SetAttribute("MaxHealth", maxHealth);
	}

	// Mana Stat: Derived from [Intelligence and Level]
	private static setManaStat(player: Player, level: number, intelligence: number): void {
		const maxMana = math.round(intelligence * (level / 3) + 100);
		player.SetAttribute("CurrentMana", maxMana);
		player.SetAttribute("MaxMana", maxMana);
	}

	// Stamina Stat: Derived from [Strength, Constitution, and Level]
	private static setStaminaStat(player: Player, level: number, strength: number, constitution: number): void {
		const maxStamina = math.round((strength + constitution) * (level / 3) + 100);
		player.SetAttribute("CurrentStamina", maxStamina);
		player.SetAttribute("MaxStamina", maxStamina);
	}

	// Experience Stats
	private static setExperienceStats(player: Player, playerData: PlayerData): void {
		player.SetAttribute("Level", playerData.Level);
		player.SetAttribute("Experience", playerData.Experience);
		player.SetAttribute("ExperienceToNextLevel", playerData.ExperienceToNextLevel);
	}
}
