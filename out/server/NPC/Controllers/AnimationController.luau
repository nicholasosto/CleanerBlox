-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Purpose: Animation controller.
-- Enums
local EAnimationName = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Refrences", "AnimationReference").EAnimationName
-- Animation Controller
local AnimationController
do
	AnimationController = setmetatable({}, {
		__tostring = function()
			return "AnimationController"
		end,
	})
	AnimationController.__index = AnimationController
	function AnimationController.new(...)
		local self = setmetatable({}, AnimationController)
		return self:constructor(...) or self
	end
	function AnimationController:constructor(humanoid)
		self.animationTracks = {}
		self._humanoid = humanoid
		self._animator = humanoid:WaitForChild("Animator")
		-- Create animation tracks
		self:createAnimationTracks()
	end
	function AnimationController:createAnimationTracks()
		-- Idle
		self:addAnimationTrack(EAnimationName.NPC_Idle)
		-- Chase
		self:addAnimationTrack(EAnimationName.NPC_Chase)
		-- Attack
		self:addAnimationTrack(EAnimationName.NPC_Attack)
	end
	function AnimationController:playAnimation(animationEnum)
		local _animationTracks = self.animationTracks
		local _animationEnum = animationEnum
		local track = _animationTracks[_animationEnum]
		if track then
			track:Play()
		end
	end
	function AnimationController:stopAnimation(animationEnum)
		local _animationTracks = self.animationTracks
		local _animationEnum = animationEnum
		local track = _animationTracks[_animationEnum]
		if track then
			track:Stop()
		end
	end
	function AnimationController:addAnimationTrack(animationEnum)
		local animation = Instance.new("Animation")
		animation.AnimationId = animationEnum
		animation.Name = animationEnum
		local track = self._animator:LoadAnimation(animation)
		local _animationTracks = self.animationTracks
		local _animationEnum = animationEnum
		_animationTracks[_animationEnum] = track
	end
end
return {
	AnimationController = AnimationController,
}
