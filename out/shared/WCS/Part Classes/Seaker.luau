-- Compiled with roblox-ts v3.0.0
local Seaker
do
	Seaker = setmetatable({}, {
		__tostring = function()
			return "Seaker"
		end,
	})
	Seaker.__index = Seaker
	function Seaker.new(...)
		local self = setmetatable({}, Seaker)
		return self:constructor(...) or self
	end
	function Seaker:constructor(instance, owner, target)
		self.instance = instance
		self.owner = owner
		self.target = target
	end
	function Seaker:SetTarget(target)
		self.target = target
	end
end
return {
	Seaker = Seaker,
}
