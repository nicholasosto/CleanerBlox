-- Compiled with roblox-ts v3.0.0
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ContentProvider = game:GetService("ContentProvider")
local TSFolder = game:GetService("ReplicatedFirst")
local LoadingScreen = TSFolder:WaitForChild("LoadingScreenGUI")
local playButton = LoadingScreen:FindFirstChild("PlayButton", true)
playButton.Activated:Connect(function()
	LoadingScreen.Enabled = false
end)
-- Preload any assets
local assetsToLoad = { Instance.new("Animation", LoadingScreen) }
-- We can use ContentProvider to preload them
ContentProvider:PreloadAsync(assetsToLoad)
-- Signal that the engine can skip the default Roblox splash
ReplicatedFirst:RemoveDefaultLoadingScreen()
-- Start the loading screen
LoadingScreen.Enabled = true
LoadingScreen.Parent = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
