-- Compiled with roblox-ts v3.0.0
local SoulSeaker
do
	SoulSeaker = setmetatable({}, {
		__tostring = function()
			return "SoulSeaker"
		end,
	})
	SoulSeaker.__index = SoulSeaker
	function SoulSeaker.new(...)
		local self = setmetatable({}, SoulSeaker)
		return self:constructor(...) or self
	end
	function SoulSeaker:constructor(part)
		self._fire = Instance.new("Fire")
		self._fire.Size = 3
		self._fire.Parent = part
		self._fire.Heat = 10
		self._fire.Color = Color3.fromRGB(255, 0, 0)
		self._part = part
		self._fire.Parent = self._part
		return self
	end
end
return {
	SoulSeaker = SoulSeaker,
}
