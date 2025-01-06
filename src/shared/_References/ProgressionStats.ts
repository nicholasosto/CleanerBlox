
// Core Stats
export type ProgressionStatId =
	| "Level"
	| "Experience"
	| "ExperienceToNextLevel"
	| "ClassPoints"
	| "ClassExperience"
	| "ClassExperienceToNextLevel";

export type ProgressionStatValue = number;

export interface ProgressionStatDefinition {
	displayName: string;
	description: string;
	icon: string; // rbxassetid:// etc.
}

export const ProgressionStatDefinitions: Record<ProgressionStatId, ProgressionStatDefinition> = {
	Level: {
		displayName: "Level",
		description: "Character Level",
		icon: "rbxassetid://12345",
	},
	Experience: {
		displayName: "Experience",
		description: "Experience Points",
		icon: "rbxassetid://12346",
	},
	ExperienceToNextLevel: {
		displayName: "Experience To Next Level",
		description: "Experience Points Required to Level Up",
		icon: "rbxassetid://12347",
	},
	ClassPoints: {
		displayName: "Class Points",
		description: "Class Points Available",
		icon: "rbxassetid://12348",
	},
	ClassExperience: {
		displayName: "Class Experience",
		description: "Class Experience Points",
		icon: "rbxassetid://12349",
	},
	ClassExperienceToNextLevel: {
		displayName: "Class Experience To Next Level",
		description: "Class Experience Points Required to Level Up",
		icon: "rbxassetid://12350",
	},
};

export interface ProgressionStatsData {
	Level: ProgressionStatValue;
	Experience: ProgressionStatValue;
	ExperienceToNextLevel: ProgressionStatValue;
	ClassPoints: ProgressionStatValue;
	ClassExperience: ProgressionStatValue;
	ClassExperienceToNextLevel: ProgressionStatValue;
}

export function getDefaultProgressionStatsData(): ProgressionStatsData {
	return {
		Level: 1,
		Experience: 0,
		ExperienceToNextLevel: 100,
		ClassPoints: 0,
		ClassExperience: 0,
		ClassExperienceToNextLevel: 100,
	};
}
