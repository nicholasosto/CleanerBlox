import { GameStorage } from "shared/Utility/GameStorage";
import { Character } from "@rbxts/wcs";
import { Logger } from "shared/Utility/Logger";

export class WeaponManager {
	// eslint-disable-next-line prettier/prettier
    public static LoadWCSCharacterWeapon(character: Character, weaponName: string): Accessory | undefined {
		const weapon = GameStorage.cloneAccessory(weaponName);
		const player = character.Player;
		if (player === undefined || weapon === undefined) {
			return;
		}

		const playerBackpack: Backpack = player.FindFirstChildOfClass("Backpack") as Backpack;

		if (playerBackpack) {
			weapon.Parent = playerBackpack;
		}

		if (weapon === undefined) {
			return;
		}

		return weapon as Accessory;
	}

    public static EquipWCSCharacterWeapon(character: Character, weaponName: string): void {
        const player = character.Player;
        if (player === undefined) {
            return;
        }
        const playerBackpack: Backpack = player.FindFirstChildOfClass("Backpack") as Backpack;
        if (playerBackpack === undefined) {
            return;
        }
        const weapon = playerBackpack.FindFirstChild(weaponName);
        if (weapon === undefined) {
            return;
        }
        weapon.Parent = character.Instance;
    }

    public static UnEquipWCSCharacterWeapon(player: Player, weapon:Accessory): void {
        if(player === undefined || weapon === undefined){
            return;
        }
        Logger.Log(script,"BasicMelee", "UnEquipping Weapon");
        weapon.Parent = player.FindFirstChildOfClass("Backpack") as Backpack;
    }

    public static UnloadWCSCharacterWeapon(character: Character, weaponName: string): void {
        const player = character.Player;
        if (player === undefined) {
            return;
        }
        const playerBackpack: Backpack = player.FindFirstChildOfClass("Backpack") as Backpack;
        if (playerBackpack === undefined) {
            return;
        }
        const weapon = playerBackpack.FindFirstChild(weaponName);
        if (weapon === undefined) {
            return;
        }
        weapon.Destroy();
    }
}
