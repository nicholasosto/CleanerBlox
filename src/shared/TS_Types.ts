type Domain = "Exsanguination" | "Consumption" | "Corruption" | "Blood" | "Hunger" | "Rage" | "Fateless";

type Modifier = {
	name: string;
	effect: string;
	value: number;
};

type Equipment = {
	name: string;
	type: "Helmet" | "Chest Armor" | "Accessory" | "Siphon" | "Familiar";
	level: number;
	equipped: boolean;
	storedSouls: number;
	modifiers: Modifier[];
};

type Transformation = {
	id: string;
	name: string;
	animationId: string;
	duration: number; // in seconds
	description: string;
	ready: boolean;
};

type Combatant = {
	id: string;
	name: string;
	health: number;
	maxHealth: number;
	energy: number;
	maxEnergy: number;
	siphonLevel: number;
	buffs: Modifier[];
	debuffs: Modifier[];
};

type PlayerData = {
	id: string;
	name: string;
	level: number;
	domain: Domain;
	allies: Combatant[];
	enemies: Combatant[];
	equipment: Equipment[];
	transformationProgress: number; // value between 0-100 representing transformation readiness
	activeTransformation?: Transformation;
	stats: {
		strength: number;
		agility: number;
		intelligence: number;
		vitality: number;
	};
	combatHistory: {
		combatants: Combatant[];
		damageDone: number;
		damageTaken: number;
	};
};

type GameData = {
	players: PlayerData[];
	worldState: {
		domainTerritories: Record<Domain, boolean>; // true if controlled by players
		fatelessPlayers: string[]; // player IDs that are 'Fateless'
	};
	events: {
		tutorialCompleted: boolean;
		firstTimeDomainSelection: boolean;
		domainBattle: {
			active: boolean;
			participants: PlayerData[];
		};
	};
};

// Example usage:
const gameData: GameData = {
	players: [],
	worldState: {
		domainTerritories: {
			Exsanguination: false,
			Consumption: false,
			Corruption: false,
			Blood: false,
			Hunger: false,
			Rage: false,
			Fateless: false,
		},
		fatelessPlayers: [],
	},
	events: {
		tutorialCompleted: false,
		firstTimeDomainSelection: true,
		domainBattle: {
			active: false,
			participants: [],
		},
	},
};

export { Domain, Modifier, Equipment, Transformation, Combatant, PlayerData, GameData };
