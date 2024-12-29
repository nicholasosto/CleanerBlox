-- Compiled with roblox-ts v3.0.0
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
		self.humanoid = humanoid
	end
	function AnimationController:playAnimation(animationId)
		-- Load and play the AnimationTrack on the humanoid’s Animator
	end
	function AnimationController:stopAnimation(animationId)
		-- Stop the given animation
	end
end
return {
	AnimationController = AnimationController,
}
