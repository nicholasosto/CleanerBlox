import { EAnimationName } from "shared/Refrences/AnimationReference";
const ReplicatedFirst = game.GetService("ReplicatedFirst");
const ContentProvider = game.GetService("ContentProvider");

const TSFolder = game.GetService("ReplicatedFirst").WaitForChild("TS");
const LoadingScreen = TSFolder.WaitForChild("LoadingScreen") as ScreenGui;

// Preload any assets
const assetsToLoad: Instance[] = [
    new Instance("Animation", LoadingScreen),

];

// We can use ContentProvider to preload them
ContentProvider.PreloadAsync(assetsToLoad);


// Signal that the engine can skip the default Roblox splash
ReplicatedFirst.RemoveDefaultLoadingScreen();
