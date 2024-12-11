-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local ParentFolder = ReplicatedStorage:WaitForChild("TS"):WaitForChild("WCS")
local WCSFolders = {
	Skills = ParentFolder:WaitForChild("Skills"),
	Movesets = ParentFolder:WaitForChild("Movesets"),
	StatusEffects = ParentFolder:WaitForChild("StatusEffects"),
}
return {
	WCSFolders = WCSFolders,
}
