-- Compiled with roblox-ts v3.0.0
local PositionGenerator
do
	PositionGenerator = setmetatable({}, {
		__tostring = function()
			return "PositionGenerator"
		end,
	})
	PositionGenerator.__index = PositionGenerator
	function PositionGenerator.new(...)
		local self = setmetatable({}, PositionGenerator)
		return self:constructor(...) or self
	end
	function PositionGenerator:constructor()
		PositionGenerator._instance = self
	end
	function PositionGenerator:Start()
		if PositionGenerator._instance == nil then
			PositionGenerator._instance = PositionGenerator.new()
		end
	end
	function PositionGenerator:GenerateDefaultTargetPosition(sourceModel, offset)
		if offset == nil then
			offset = 10
		end
		-- get the source model's position and direction
		local sourceFrame = sourceModel:GetPivot()
		local sourcePosition = sourceFrame.Position
		local sourceDirection = sourceFrame.LookVector
		-- ensure the target position is in front of the source model in the direction it is facing
		local _offset = offset
		local _arg0 = sourceDirection * _offset
		local targetPosition = sourcePosition + _arg0
		return targetPosition
	end
	function PositionGenerator:GenerateRandomPositionsAroundSource(sourceModel, numPositions, radius)
		-- get the source model's position
		local sourceFrame = sourceModel:GetPivot()
		-- set up the positions array
		local positions = {}
		local angleIncrement = (2 * math.pi) / numPositions
		-- generate positions around the source model
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
				local _arg0 = sourceFrame.Position + position
				table.insert(positions, _arg0)
			end
		end
		return positions
	end
	function PositionGenerator:CreateRing(userCFrame, radius, numPositions)
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
				local _position = cframe.Position
				table.insert(ringCFrames, _position)
			end
		end
		return ringCFrames
	end
end
return {
	PositionGenerator = PositionGenerator,
}
