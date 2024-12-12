-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local scriptTag = "TEffect"
local TEffect
do
	TEffect = setmetatable({}, {
		__tostring = function()
			return "TEffect"
		end,
	})
	TEffect.__index = TEffect
	function TEffect.new(...)
		local self = setmetatable({}, TEffect)
		return self:constructor(...) or self
	end
	function TEffect:constructor(effectName, particleGroupingPart, soundEffect, duration)
		self._particleEffects = {}
		-- Set the effect name
		self.Name = `Effect_{effectName}`
		-- Set the particle grouping part
		self._particleGroupingPart = particleGroupingPart
		self._soundEffect = soundEffect:Clone()
		local _exp = self._particleGroupingPart:GetDescendants()
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _callback = function(child)
			return child:IsA("ParticleEmitter")
		end
		local _length = 0
		for _k, _v in _exp do
			if _callback(_v, _k - 1, _exp) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		self._particleEffects = _newValue
		local _exp_1 = self._particleEffects
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(particle)
			Logger:Log(scriptTag, particleGroupingPart, particleGroupingPart.CFrame)
		end
		for _k, _v in _exp_1 do
			_callback_1(_v, _k - 1, _exp_1)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function TEffect:playEffect(parent)
		if self._particleGroupingPart then
			print("Playing Effect: " .. self.Name)
			self._particleGroupingPart.Parent = parent
			--Debris.AddItem(this._particleGroupingPart, 5);
		end
		if self._soundEffect then
			print("Playing Sound: " .. self._soundEffect.Name)
			self._soundEffect:Play()
		end
	end
end
local EffectList = {
	BlackHole_01 = TEffect.new("BlackHole", GameStorage:cloneParticleGroupAttachment("03 - BLACK HOLE [A]"), GameStorage:getAudio("Creepy Night"), 5),
	BlackHole_02 = TEffect.new("BlackHoleSun", GameStorage:cloneParticleGroupAttachment("04 - BLACK HOLE [B]"), GameStorage:getAudio("Null Ending"), 5),
}
return {
	TEffect = TEffect,
	EffectList = EffectList,
}
