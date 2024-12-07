-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local ParticleEmitter = {
	castingHands = ReplicatedStorage:FindFirstChild("CastingHands", true),
	castingHands2 = ReplicatedStorage:FindFirstChild("CastingHands2", true),
	castingAura = ReplicatedStorage:FindFirstChild("CastingAura", true),
	castingAura2 = ReplicatedStorage:FindFirstChild("CastingAuraLightning", true),
	chargingAura = ReplicatedStorage:FindFirstChild("ChargingAura", true),
}
local TParts = {
	castingCircle = ReplicatedStorage:FindFirstChild("CastingCircle", true),
	castingSpotlight = ReplicatedStorage:FindFirstChild("CastingSpotlight", true),
}
return {
	ParticleEmitter = ParticleEmitter,
	TParts = TParts,
}
