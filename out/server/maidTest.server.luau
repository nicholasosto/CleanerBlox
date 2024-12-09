-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local Workspace = _services.Workspace
local Maid = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "maid", "Maid")
-- Create a Maid instance
local maid = Maid.new()
-- Add a part to be destroyed later
local part = Instance.new("Part")
part.Parent = Workspace
maid:GiveTask(part)
-- Add an event connection to be disconnected
local connection = Players.PlayerAdded:Connect(function(player)
	print(`{player.Name} joined the game.`)
end)
maid:GiveTask(connection)
-- Add a custom cleanup function
maid:GiveTask(function()
	print("Custom cleanup function executed!")
end)
