-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
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
		self.effectName = effectName
		self._particleGroupingPart = particleGroupingPart
		self._soundEffect = soundEffect
	end
	function TEffect:onEffect(...)
		local args = { ... }
		-- Override this method in your subclass
	end
end
local EffectList = {
	BlackHole_01 = TEffect.new("BlackHole", GameStorage:getParticleGroupPart("03 - BLACK HOLE [A]"), GameStorage:getAudio("Creepy Night"), 5),
	BlackHole_02 = TEffect.new("BlackHole", GameStorage:getParticleGroupPart("03 - BLACK HOLE [B]"), GameStorage:getAudio("Null Ending"), 5),
}
return {
	TEffect = TEffect,
	EffectList = EffectList,
}
