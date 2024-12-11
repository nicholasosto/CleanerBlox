-- Compiled with roblox-ts v3.0.0
--[[
	*
	 * An interface for classes responsible for generating one or multiple CFrames
	 * for use in skill activations or object placements. Implementations can derive
	 * the user’s position and orientation directly from the provided userCFrame.
	 
]]
--[[
	*
	 * A class responsible for generating CFrames for skill activations or object 
	 * placements. The user’s position and orientation are derived directly from the 
	 * provided userCFrame.
	 
]]
local CFrameGenerator
do
	CFrameGenerator = setmetatable({}, {
		__tostring = function()
			return "CFrameGenerator"
		end,
	})
	CFrameGenerator.__index = CFrameGenerator
	function CFrameGenerator.new(...)
		local self = setmetatable({}, CFrameGenerator)
		return self:constructor(...) or self
	end
	function CFrameGenerator:constructor()
	end
	function CFrameGenerator:createOffsetFrame(sourceFrame, offsetFrame)
		local _sourceFrame = sourceFrame
		local _offsetFrame = offsetFrame
		return _sourceFrame * _offsetFrame
	end
	function CFrameGenerator:createTargetFrame(userCFrame, offset)
		local _userCFrame = userCFrame
		local _cFrame = CFrame.new(0, -1 * userCFrame.Y, -offset)
		return _userCFrame * _cFrame
	end
	function CFrameGenerator:createRing(userCFrame, radius, numPositions)
		local angleIncrement = (2 * math.pi) / numPositions
		local ringCFrames = {}
		do
			local i = 0
			local _shouldIncrement = false
			while true do
				if _shouldIncrement then
					i += 1
				else
					_shouldIncrement = true
				end
				if not (i < numPositions) then
					break
				end
				local angle = i * angleIncrement
				local x = radius * math.cos(angle)
				local z = radius * math.sin(angle)
				local position = Vector3.new(x, 0, z)
				local cframe = CFrame.new(userCFrame.Position + position)
				table.insert(ringCFrames, cframe)
			end
		end
		return ringCFrames
	end
end
return {
	CFrameGenerator = CFrameGenerator,
}
