-- Compiled with roblox-ts v3.0.0
local StatDefinitions = {
	Health = {
		resourceId = "Health",
		displayName = "Health",
		description = "Health Points",
		currentValue = 100,
		maxValue = 100,
	},
	Mana = {
		resourceId = "Mana",
		displayName = "Mana",
		description = "Mana Points",
		currentValue = 100,
		maxValue = 100,
	},
	Stamina = {
		resourceId = "Stamina",
		displayName = "Stamina",
		description = "Stamina Points",
		currentValue = 100,
		maxValue = 100,
	},
	Domain = {
		resourceId = "Domain",
		displayName = "Domain",
		description = "Domain Points",
		currentValue = 100,
		maxValue = 100,
	},
	Class = {
		resourceId = "Class",
		displayName = "Class",
		description = "Class Points",
		currentValue = 100,
		maxValue = 100,
	},
}
local function getDefaultResourceStats()
	return {
		Health = {
			Current = 100,
			Max = 100,
		},
		Mana = {
			Current = 100,
			Max = 100,
		},
		Stamina = {
			Current = 100,
			Max = 100,
		},
		Domain = {
			Current = 100,
			Max = 100,
		},
		Class = {
			Current = 100,
			Max = 100,
		},
	}
end
return {
	getDefaultResourceStats = getDefaultResourceStats,
	StatDefinitions = StatDefinitions,
}
