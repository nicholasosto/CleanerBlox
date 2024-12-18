-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local AudioManager
do
	AudioManager = setmetatable({}, {
		__tostring = function()
			return "AudioManager"
		end,
	})
	AudioManager.__index = AudioManager
	function AudioManager.new(...)
		local self = setmetatable({}, AudioManager)
		return self:constructor(...) or self
	end
	function AudioManager:constructor()
	end
	function AudioManager:LoadWCSSound(character, soundName, soundId)
		-- create the sound
		local sound = Instance.new("Sound")
		sound.Name = soundName
		sound.SoundId = soundId
		sound.Parent = character.Instance
		return sound
	end
end
local AnimationManager
do
	AnimationManager = setmetatable({}, {
		__tostring = function()
			return "AnimationManager"
		end,
	})
	AnimationManager.__index = AnimationManager
	function AnimationManager.new(...)
		local self = setmetatable({}, AnimationManager)
		return self:constructor(...) or self
	end
	function AnimationManager:constructor()
	end
	function AnimationManager:LoadWCSCharacterAnimation(character, animationName, animationId, animationDuration)
		-- Get the animator
		local animator = AnimationManager:getAnimator(character.Instance)
		if animator == nil then
			Logger:Log("AnimationManager", "Animator not found")
			return nil
		end
		-- Create the animation
		local animation = Instance.new("Animation")
		animation.Name = animationName
		animation.AnimationId = animationId
		-- Load the animation
		return animator:LoadAnimation(animation)
	end
	function AnimationManager:PlayAnimation(animationTrack, duration)
		local animationLength = animationTrack.Length
		local animationSpeed = animationLength / duration
		animationTrack:Play()
		animationTrack:AdjustSpeed(animationSpeed)
	end
	function AnimationManager:getAnimator(instance)
		return instance:FindFirstChild("Animator", true)
	end
end
return {
	AudioManager = AudioManager,
	AnimationManager = AnimationManager,
}
