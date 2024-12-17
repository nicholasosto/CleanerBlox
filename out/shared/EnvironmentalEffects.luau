-- Compiled with roblox-ts v3.0.0
local FogTextureTweenInfo = TweenInfo.new(10, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out, -1, true, 0)
local EnumEnvironmentalEffects = {
	Fog = "Fog",
	Portal = "Portal",
	Rain = "Rain",
	Snow = "Snow",
}
local EnvironmentGod
do
	EnvironmentGod = setmetatable({}, {
		__tostring = function()
			return "EnvironmentGod"
		end,
	})
	EnvironmentGod.__index = EnvironmentGod
	function EnvironmentGod.new(...)
		local self = setmetatable({}, EnvironmentGod)
		return self:constructor(...) or self
	end
	function EnvironmentGod:constructor()
		-- Singleton
		-- Singleton
	end
	function EnvironmentGod:Summon()
		local _value = self._godInstance
		if not (_value ~= 0 and _value == _value and _value ~= "" and _value) then
			self._godInstance = EnvironmentGod.new()
		end
		return self._godInstance
	end
end
return {
	EnumEnvironmentalEffects = EnumEnvironmentalEffects,
	EnvironmentGod = EnvironmentGod,
}
