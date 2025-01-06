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
		self._VectorForce = Instance.new("VectorForce")
		self._part = part
		self._VectorForce.Enabled = false
		self._VectorForce.Parent = self._part
		--this._VectorForce.Force = new Vector3(math.random(-10,10), math.random(-10,10), math.random(-10,10));
		self:_attachFire()
		self:_seek()
		return self
	end
	function SoulSeaker:_seek()
		self._part.Anchored = false
		self._VectorForce.Enabled = true
	end
	function SoulSeaker:_attachFire()
		self._fire.Size = 3
		self._fire.Parent = self._part
		self._fire.Heat = 10
		self._fire.Color = Color3.fromRGB(255, 0, 0)
		self._fire.Parent = self._part
	end
end
return {
	SoulSeaker = SoulSeaker,
}
