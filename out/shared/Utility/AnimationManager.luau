-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
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
		-- Private Constructor
		-- Private Constructor
	end
	function AnimationManager:Start()
		local _value = self.__instance
		if not (_value ~= 0 and _value == _value and _value ~= "" and _value) then
			self.__instance = AnimationManager.new()
		end
		return self.__instance
	end
	function AnimationManager:RegisterAnimationsFor(character)
		local animator = character.Humanoid:WaitForChild("Animator")
		local ___registry = AnimationManager.__registry
		local _character = character
		local _condition = ___registry[_character]
		if not _condition then
			_condition = {}
		end
		local animationTracks = _condition
		if not animator then
			warn("Animator or AnimationTracks not found for character: ", character)
			return nil
		end
		if #animationTracks > 0 then
			-- ▼ ReadonlyArray.forEach ▼
			local _callback = function(track)
				return track:Destroy()
			end
			for _k, _v in animationTracks do
				_callback(_v, _k - 1, animationTracks)
			end
			-- ▲ ReadonlyArray.forEach ▲
			local ___registry_1 = AnimationManager.__registry
			local _character_1 = character
			___registry_1[_character_1] = nil
		end
		local _arg0 = animator:LoadAnimation(AnimationManager._combatAnimations.DanteBackflip)
		table.insert(animationTracks, _arg0)
		local _arg0_1 = animator:LoadAnimation(AnimationManager._combatAnimations.Godlike)
		table.insert(animationTracks, _arg0_1)
		local ___registry_1 = AnimationManager.__registry
		local _character_1 = character
		___registry_1[_character_1] = animationTracks
	end
	function AnimationManager:PlayAnimationFor(character, animationName)
		local ___registry = AnimationManager.__registry
		local _character = character
		local _animationTrack = ___registry[_character]
		if _animationTrack ~= nil then
			-- ▼ ReadonlyArray.filter ▼
			local _newValue = {}
			local _callback = function(track)
				local _result = track.Animation
				if _result ~= nil then
					_result = _result.Name
				end
				return _result == animationName
			end
			local _length = 0
			for _k, _v in _animationTrack do
				if _callback(_v, _k - 1, _animationTrack) == true then
					_length += 1
					_newValue[_length] = _v
				end
			end
			-- ▲ ReadonlyArray.filter ▲
			_animationTrack = _newValue[1]
		end
		local animationTrack = _animationTrack
		if not animationTrack then
			warn("Animation not found: ", animationName)
			return nil
		end
		animationTrack:Play()
	end
	AnimationManager.__registry = {}
	AnimationManager._combatAnimations = {
		DanteBackflip = GameStorage:getAnimation("DanteBackflip"),
		Godlike = GameStorage:getAnimation("Godlike"),
	}
end
return {
	AnimationManager = AnimationManager,
}
