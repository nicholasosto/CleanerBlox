-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local AnimationIds = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Indexes", "AssetIndex").AnimationIds
local function CreateAnimation(animationId)
	local animation = Instance.new("Animation")
	animation.AnimationId = animationId
	return animation
end
local CharacterAnimations = {
	[AnimationIds.COMBAT_Damage] = CreateAnimation(AnimationIds.COMBAT_Damage),
	[AnimationIds.MELEE_Backflip] = CreateAnimation(AnimationIds.MELEE_Backflip),
	[AnimationIds.MELEE_FastKick] = CreateAnimation(AnimationIds.MELEE_FastKick),
	[AnimationIds.MELEE_Dodge] = CreateAnimation(AnimationIds.MELEE_Dodge),
	[AnimationIds.CHARACTER_Charging] = CreateAnimation(AnimationIds.CHARACTER_Charging),
	[AnimationIds.FLIGHT_Up] = CreateAnimation(AnimationIds.FLIGHT_Up),
	[AnimationIds.FLIGHT_Left] = CreateAnimation(AnimationIds.FLIGHT_Left),
	[AnimationIds.FLIGHT_Right] = CreateAnimation(AnimationIds.FLIGHT_Right),
	[AnimationIds.FLIGHT_Backward] = CreateAnimation(AnimationIds.FLIGHT_Backward),
}
return {
	CreateAnimation = CreateAnimation,
	CharacterAnimations = CharacterAnimations,
}
