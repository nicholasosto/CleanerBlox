import { ReplicatedStorage } from "@rbxts/services";

export const ParticleEmitter = {
	castingHands: ReplicatedStorage.FindFirstChild("CastingHands", true) as ParticleEmitter,
	castingHands2: ReplicatedStorage.FindFirstChild("CastingHands2", true) as ParticleEmitter,
	castingAura: ReplicatedStorage.FindFirstChild("CastingAura", true) as ParticleEmitter,
	castingAura2: ReplicatedStorage.FindFirstChild("CastingAuraLightning", true) as ParticleEmitter,

	chargingAura: ReplicatedStorage.FindFirstChild("ChargingAura", true) as ParticleEmitter,
};

export const TParts = {
	castingCircle: ReplicatedStorage.FindFirstChild("CastingCircle", true) as Model,
	castingSpotlight: ReplicatedStorage.FindFirstChild("CastingSpotlight", true) as Model,
};
