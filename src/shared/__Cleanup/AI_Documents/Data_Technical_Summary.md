
# Data System Technical Summary

## DataService

The `DataService` module is responsible for managing player data, including loading, saving, and caching player information. It interfaces with Roblox's `DataStoreService` to persist data across game sessions.

### Key Functions

- `onPlayerAdded(player)`: Loads player data when they join the game.
- `onPlayerRemoving(player)`: Saves player data when they leave the game.
- `loadPlayerData(userId)`: Asynchronously retrieves data from the datastore.
- `savePlayerData(userId, data)`: Asynchronously writes data to the datastore.

### Example

```typescript
import { DataService } from "@rbxts/data-system";

// Initialize the data service
const dataService = new DataService();

// Handle player joining
Players.PlayerAdded.Connect((player) => {
    dataService.onPlayerAdded(player);
});

// Handle player leaving
Players.PlayerRemoving.Connect((player) => {
    dataService.onPlayerRemoving(player);
});
```

## PlayerData Interface

The `PlayerData` interface defines the structure of the data associated with each player. It includes attributes like level, experience, character stats, skills, equipment, and inventories.

### Structure

- `Level`: Player's current level.
- `Experience`: Current experience points.
- `ExperienceToNextLevel`: Experience required to reach the next level.
- `CharacterName`: The name of the player's character.
- `CharacterClass`: Detailed class information.
- `Stats`: Core attributes like strength and intelligence.
- `Skills`: Assigned skills in skill slots.
- `Equipment`: Items equipped by the player.
- `SkillInventory`: List of acquired skills.
- `WeaponInventory`, `ArmorInventory`, etc.: Lists of owned items.

### Example

```typescript
interface PlayerData {
    Level: number;
    Experience: number;
    ExperienceToNextLevel: number;
    CharacterName: string;
    CharacterClass: CharacterClassData;
    Stats: StatsData;
    Skills: SkillsData;
    Equipment: EquipmentData;
    SkillInventory: string[];
    WeaponInventory: string[];
    // ...existing code...
}
```

## DataTemplate

The `DataTemplate` provides default values for a new player's data, ensuring that all required fields are initialized properly when a player first joins the game.

### Example

```typescript
const DataTemplate: PlayerData = {
    Level: 1,
    Experience: 0,
    ExperienceToNextLevel: 100,
    CharacterName: "Adventurer",
    CharacterClass: {
        ClassId: "Warrior",
        ClassLevel: 1,
        ClassPoints: 0,
        // ...existing code...
    },
    Stats: {
        Strength: 10,
        Speed: 10,
        // ...existing code...
    },
    Skills: {
        Slot_1: "Slash",
        Slot_2: "Block",
        // ...existing code...
    },
    Equipment: {
        Weapon: "Iron Sword",
        Armor: "Leather Armor",
        // ...existing code...
    },
    SkillInventory: ["Slash", "Block"],
    WeaponInventory: ["Iron Sword"],
    // ...existing code...
};
```

## PlayerAttributes Module

The `PlayerAttributes` module manages the in-game attributes of players based on their `PlayerData`. It syncs data to Roblox's `Attributes` system, allowing for easy access and manipulation during gameplay.

### Key Functions

- `createAttributes(player, data)`: Initializes attributes when the player joins.
- `updateAttributes(player, data)`: Updates attributes as the player's data changes.

### Example

```typescript
import { PlayerAttributes } from "@rbxts/data-system";

// On player data loaded
dataService.onPlayerDataLoaded.Connect((player, data) => {
    PlayerAttributes.createAttributes(player, data);
});
```

## Error Handling

Error handling is integrated to ensure data integrity and provide informative logs in case of failures during data operations.

### Example

```typescript
try {
    await dataService.savePlayerData(userId, data);
} catch (error) {
    warn(`Error saving data for user ${userId}: ${error}`);
}
```

## Best Practices

- **Data Versioning**: Use the `version` field in `PlayerData` to manage data schema updates.
- **Asynchronous Operations**: Employ async/await to handle data store operations without blocking the game thread.
- **Data Caching**: Utilize in-memory caching to reduce redundant data store accesses.
- **Error Logging**: Implement robust error logging to assist in debugging data-related issues.