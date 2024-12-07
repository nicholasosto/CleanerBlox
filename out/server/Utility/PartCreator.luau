-- Compiled with roblox-ts v3.0.0
-- PartCreator.ts
local PartCreator
do
	PartCreator = setmetatable({}, {
		__tostring = function()
			return "PartCreator"
		end,
	})
	PartCreator.__index = PartCreator
	function PartCreator.new(...)
		local self = setmetatable({}, PartCreator)
		return self:constructor(...) or self
	end
	function PartCreator:constructor(name, position, size, color)
		self.part = Instance.new("Part")
		self.part.Name = name
		self.part.Position = position
		self.part.Size = size
		self.part.Color = color
		self.part.Anchored = true
		self.part.Parent = game.Workspace
	end
	function PartCreator:setPosition(newPosition)
		self.part.Position = newPosition
	end
	function PartCreator:setSize(newSize)
		self.part.Size = newSize
	end
	function PartCreator:setColor(newColor)
		self.part.Color = newColor
	end
	function PartCreator:deletePart()
		self.part:Destroy()
	end
	function PartCreator:getPart()
		return self.part
	end
end
return {
	PartCreator = PartCreator,
}
