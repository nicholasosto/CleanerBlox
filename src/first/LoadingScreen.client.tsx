import { EAnimationName } from "shared/Refrences/AnimationReference";
const ReplicatedFirst = game.GetService("ReplicatedFirst");
const ContentProvider = game.GetService("ContentProvider");

const TSFolder = game.GetService("ReplicatedFirst");
const LoadingScreen = TSFolder.WaitForChild("LoadingScreenGUI") as ScreenGui;
const playButton = LoadingScreen.FindFirstChild("PlayButton", true) as TextButton;

playButton.Activated.Connect(() => {
	LoadingScreen.Enabled = false;
});

// Preload any assets
const assetsToLoad: Instance[] = [new Instance("Animation", LoadingScreen)];

// We can use ContentProvider to preload them
ContentProvider.PreloadAsync(assetsToLoad);

// Signal that the engine can skip the default Roblox splash
ReplicatedFirst.RemoveDefaultLoadingScreen();

// Start the loading screen
LoadingScreen.Enabled = true;
LoadingScreen.Parent = game.GetService("Players").LocalPlayer.FindFirstChildOfClass("PlayerGui");
