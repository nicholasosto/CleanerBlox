-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local CharacterAnimations = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Animation", "Animations").CharacterAnimations
local AnimationHelper
do
	AnimationHelper = setmetatable({}, {
		__tostring = function()
			return "AnimationHelper"
		end,
	})
	AnimationHelper.__index = AnimationHelper
	function AnimationHelper.new(...)
		local self = setmetatable({}, AnimationHelper)
		return self:constructor(...) or self
	end
	function AnimationHelper:constructor()
	end
	function AnimationHelper:CreateAnimationTrack(characterModel, animationId)
		local animator = characterModel:FindFirstChild("Animator", true)
		local animation = CharacterAnimations[animationId]
		local animationTrack = animator:LoadAnimation(animation)
		return animationTrack
	end
	function AnimationHelper:PlayAnimation(animationTrack)
		animationTrack:Play()
	end
	AnimationHelper.CharacterAnimations = CharacterAnimations
end
return {
	AnimationHelper = AnimationHelper,
}
