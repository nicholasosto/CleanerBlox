-- Compiled with roblox-ts v3.0.0
local InstanceSpawner
do
	InstanceSpawner = setmetatable({}, {
		__tostring = function()
			return "InstanceSpawner"
		end,
	})
	InstanceSpawner.__index = InstanceSpawner
	function InstanceSpawner.new(...)
		local self = setmetatable({}, InstanceSpawner)
		return self:constructor(...) or self
	end
	function InstanceSpawner:constructor()
	end
	function InstanceSpawner:Start()
		if self.instance == nil then
			self.instance = InstanceSpawner.new()
		end
	end
end
return {
	InstanceSpawner = InstanceSpawner,
}
