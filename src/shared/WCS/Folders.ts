import { ReplicatedStorage } from "@rbxts/services";

const ParentFolder = ReplicatedStorage.WaitForChild("TS").WaitForChild("WCS");

export const WCSFolders = {
	Skills: ParentFolder.WaitForChild("Skills"),
	Movesets: ParentFolder.WaitForChild("Movesets"),
	StatusEffects: ParentFolder.WaitForChild("StatusEffects"),
};
