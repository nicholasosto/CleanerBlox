-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local CreateMoveset = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateMoveset
local Attack = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "Attack").Attack
local Block = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "Block").Block
local Dash = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "Dash").Dash
local Spotlights = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "Spotlights").Spotlights
local BigRed = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "BigRed").BigRed
local DefaultMoveset = CreateMoveset("DefaultMoveset", { Attack, Block, Dash, Spotlights, BigRed })
return {
	DefaultMoveset = DefaultMoveset,
}
