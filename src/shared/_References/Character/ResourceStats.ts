export type ResourceId = "Health" | "Mana" | "Stamina" | "Domain" | "Class";
export type CurrentOrMax = "Current" | "Max";

export interface ResourceStatDefinition {
	resourceId: ResourceId;
	displayName: string;
	description: string;
	currentValue: number;
	maxValue: number;
}

export const StatDefinitions: Record<ResourceId, ResourceStatDefinition> = {

	Health: {
		resourceId: "Health",
		displayName: "Health",
		description: "Health Points",
		currentValue: 100,
		maxValue: 100,
	},
	Mana: {
		resourceId: "Mana",
		displayName: "Mana",
		description: "Mana Points",
		currentValue: 100,
		maxValue: 100,
	},
	Stamina: {
		resourceId: "Stamina",
		displayName: "Stamina",
		description: "Stamina Points",
		currentValue: 100,
		maxValue: 100,
	},
	Domain: {
		resourceId: "Domain",
		displayName: "Domain",
		description: "Domain Points",
		currentValue: 100,
		maxValue: 100,
	},
	Class: {
		resourceId: "Class",
		displayName: "Class",
		description: "Class Points",
		currentValue: 100,
		maxValue: 100,
	}
};

export interface ResourceStats {
	Health: {
		Current: number;
		Max: number;
	};
	Mana: {
		Current: number;
		Max: number;
	};
	Stamina: {
		Current: number;
		Max: number;
	};
	Domain: {
		Current: number;
		Max: number;
	};
	Class: {
		Current: number;
		Max: number;
	};
}

export function getDefaultResourceStats(): ResourceStats {
	return( {
		Health: {
			Current: 100,
			Max: 100,
		},
		Mana: {
			Current: 100,
			Max: 100,
		},
		Stamina: {
			Current: 100,
			Max: 100,
		},
		Domain: {
			Current: 100,
			Max: 100,
		},
		Class: {
			Current: 100,
			Max: 100,
		},
	});
}
