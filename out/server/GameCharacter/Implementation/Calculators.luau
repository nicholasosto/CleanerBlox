-- Compiled with roblox-ts v3.0.0
local ResourceCalculator
do
	ResourceCalculator = setmetatable({}, {
		__tostring = function()
			return "ResourceCalculator"
		end,
	})
	ResourceCalculator.__index = ResourceCalculator
	function ResourceCalculator.new(...)
		local self = setmetatable({}, ResourceCalculator)
		return self:constructor(...) or self
	end
	function ResourceCalculator:constructor()
	end
	function ResourceCalculator:calculateMaxHealth(level, Constitution)
		return level * Constitution * 10
	end
	function ResourceCalculator:calculateMaxMana(level, Intelligence)
		return level * Intelligence * 10
	end
	function ResourceCalculator:calculateMaxStamina(level, Speed)
		return level * Speed * 10
	end
	function ResourceCalculator:calculateExperienceToNextLevel(level)
		return level * 100
	end
end
return {
	ResourceCalculator = ResourceCalculator,
}
