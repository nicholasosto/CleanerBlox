-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local CreateMoveset = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateMoveset
local Spotlights = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "Spotlights").Spotlights
local BigRed = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "BigRed").BigRed
local DevilBeam = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "DevilBeam").DevilBeam
local DefaultMoveset = CreateMoveset("DefaultMoveset", { Spotlights, BigRed, DevilBeam })
return {
	DefaultMoveset = DefaultMoveset,
}
