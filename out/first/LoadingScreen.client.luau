-- Compiled with roblox-ts v3.0.0
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ContentProvider = game:GetService("ContentProvider")
local TSFolder = game:GetService("ReplicatedFirst"):WaitForChild("TS")
local LoadingScreen = TSFolder:WaitForChild("LoadingScreen")
-- Preload any assets
local assetsToLoad = { Instance.new("Animation", LoadingScreen) }
-- We can use ContentProvider to preload them
ContentProvider:PreloadAsync(assetsToLoad)
-- Signal that the engine can skip the default Roblox splash
ReplicatedFirst:RemoveDefaultLoadingScreen()
