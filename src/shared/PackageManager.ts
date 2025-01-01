import { InsertService } from "@rbxts/services";
import { Logger } from "./Utility/Logger";

export enum EPackageIDs {
	Environment = 16178566269,
	Effects = 16593023479,
	Audio = 16412665714,
	NPC = 16034962856,
	GameStorage = 106038395934214,
	Weapons = 16226642685,
}

export class PackageManager {
	public static LoadPackage(packageID: EPackageIDs): Model | undefined {
		const packageContainer = InsertService.LoadAsset(packageID);
		if (packageContainer === undefined) {
			Logger.Log(script.Name, "Failed to load package with ID: ", packageID);
		}
		return packageContainer;
	}
}
