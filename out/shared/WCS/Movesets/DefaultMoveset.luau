-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local CreateMoveset = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").CreateMoveset
local BasicMelee = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "BasicMelee").BasicMelee
local BasicHold = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "BasicHold").BasicHold
local BasicRanged = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Skills", "BasicRanged").BasicRanged
local DefaultMoveset = CreateMoveset("DefaultMoveset", { BasicMelee, BasicRanged, BasicHold })
return {
	DefaultMoveset = DefaultMoveset,
}
