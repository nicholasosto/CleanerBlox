import { PlayerSkillsData } from "./Character/Skills";
import { CharacterStats } from "./Character/CharacterStats";
import { ProgressionStatsData } from "./ProgressionStats";
import { ResourceStats } from "./Character/ResourceStats";

// Player Data Interface
export interface PlayerData {
	[str: string]: unknown;

	// Datastore Info
	key: string;
	version: number;

	// Character Info
	CharacterName: string;

	// Progression Stats
	ProgressionStats: ProgressionStatsData;
	// Character Stats
	CharacterStats: CharacterStats;
	// Resource Stats
	ResourceStats: ResourceStats;
	// Skills Data
	Skills: PlayerSkillsData;
}