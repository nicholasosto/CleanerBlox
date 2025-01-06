-- Compiled with roblox-ts v3.0.0
local SkillNames = {
	MoveForward = "MoveForward",
	MoveBackward = "MoveBackward",
	MoveLeft = "MoveLeft",
	MoveRight = "MoveRight",
	Jump = "Jump",
	Attack = "Attack",
	Block = "Block",
	Dash = "Dash",
	Spotlights = "Spotlights",
}
local TNums
do
	TNums = setmetatable({}, {
		__tostring = function()
			return "TNums"
		end,
	})
	TNums.__index = TNums
	function TNums.new(...)
		local self = setmetatable({}, TNums)
		return self:constructor(...) or self
	end
	function TNums:constructor()
		-- Private constructor to prevent instantiation
		-- Private constructor to prevent instantiation
	end
	TNums.SkillNames = SkillNames
end
return {
	SkillNames = SkillNames,
	TNums = TNums,
}
