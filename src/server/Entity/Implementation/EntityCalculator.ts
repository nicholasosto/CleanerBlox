export function calculateMaxHealth(level: number, Constitution: number): number {
    return level * Constitution * 10;
}

export function calculateMaxMana(level: number, Intelligence: number): number {
    return level * Intelligence * 10;
}

export function calculateMaxStamina(level: number, Speed: number): number {
    return level * Speed * 10;
}

export function calculateExperienceToNextLevel(level: number): number {
    return level * 100;
}
