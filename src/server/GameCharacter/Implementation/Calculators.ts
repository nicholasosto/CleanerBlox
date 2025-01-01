export class ResourceCalculator {
	// Public
	public static calculateMaxHealth(level: number, Constitution: number): number {
		return level * Constitution * 10;
	}

	public static calculateMaxMana(level: number, Intelligence: number): number {
		return level * Intelligence * 10;
	}

	public static calculateMaxStamina(level: number, Speed: number): number {
		return level * Speed * 10;
	}

	public static calculateExperienceToNextLevel(level: number): number {
		return level * 100;
	}
}
