import { PlayerData } from "../../shared/TS_Types";

// DataService class to manage player data
class DataService {
    private playerDataStore: Map<string, PlayerData> = new Map();
  
    // Load player data from storage (mocked for simplicity)
    public loadPlayerData(playerId: string): PlayerData | undefined {
      return this.playerDataStore.get(playerId);
    }
  
    // Save player data to storage (mocked for simplicity)
    public savePlayerData(playerData: PlayerData): void {
      this.playerDataStore.set(playerData.id, playerData);
    }
  
    // Update specific player data by merging changes
    public updatePlayerData(playerId: string, updates: Partial<PlayerData>): void {
      const existingData = this.playerDataStore.get(playerId);
      if (existingData) {
        const updatedData = { ...existingData, ...updates };
        this.playerDataStore.set(playerId, updatedData);
      } else {
        warn(`Player data for ${playerId} not found.`);
      }
    }
  
  
    // Remove player data (e.g., when a player leaves the game)
    public removePlayerData(playerId: string): void {
      this.playerDataStore.delete(playerId);
    }
  }

export { DataService };