-- Compiled with roblox-ts v3.0.0
-- Objective: Provide a Service to handle CFrames position and rotation
local FormationFrames
do
	local _inverse = {}
	FormationFrames = setmetatable({}, {
		__index = _inverse,
	})
	FormationFrames.Circle = 0
	_inverse[0] = "Circle"
	FormationFrames.Line = 1
	_inverse[1] = "Line"
	FormationFrames.Square = 2
	_inverse[2] = "Square"
	FormationFrames.Triangle = 3
	_inverse[3] = "Triangle"
	FormationFrames.Diamond = 4
	_inverse[4] = "Diamond"
	FormationFrames.Pentagon = 5
	_inverse[5] = "Pentagon"
	FormationFrames.Hexagon = 6
	_inverse[6] = "Hexagon"
	FormationFrames.Octagon = 7
	_inverse[7] = "Octagon"
	FormationFrames.Decagon = 8
	_inverse[8] = "Decagon"
	FormationFrames.Dodecagon = 9
	_inverse[9] = "Dodecagon"
	FormationFrames.Star = 10
	_inverse[10] = "Star"
end
local TCFrame
do
	TCFrame = setmetatable({}, {
		__tostring = function()
			return "TCFrame"
		end,
	})
	TCFrame.__index = TCFrame
	function TCFrame.new(...)
		local self = setmetatable({}, TCFrame)
		return self:constructor(...) or self
	end
	function TCFrame:constructor()
		-- Constructor
		-- Constructor
	end
	function TCFrame:createFire()
		local fire = Instance.new("Fire")
		fire.Size = 5
		fire.Heat = 10
		fire.Color = Color3.fromRGB(255, 0, 0)
		fire.Enabled = true
		return fire
	end
	function TCFrame:CircleFormation(modelSourceAttachment)
		-- Generate a circle formation
		-- Set default values
		local numPositions = 9
		local radius = 15
		local distanceFromSource = 10
		local directionVector = Vector3.new(0, 1, 0)
		-- Create an array of attachments to return
		local attachments = {}
		-- Add the source attachment to the array position 0
		-- Get the source CFrame world position
		local sourceCFrame = modelSourceAttachment.WorldCFrame
		local destinationCenterPoint = Vector3.new(sourceCFrame.X, sourceCFrame.Y, sourceCFrame.Z - distanceFromSource)
		-- Generate the circle formation
		for i = 0, numPositions - 1 do
			-- Calculate the angle
			local angle = ((2 * math.pi) / numPositions) * i
			-- Goal Position
			local goalPosition = Vector3.new(radius * math.cos(angle), destinationCenterPoint.Y, destinationCenterPoint.Z + radius * math.sin(angle))
			-- Calculate the goal CFrame
			local goalCFrame = CFrame.new(goalPosition)
			-- Create a new attachment
			local attachment = Instance.new("Attachment")
			attachment.Name = "CircleAttachment_" .. tostring(i)
			attachment.Position = goalPosition
			attachment.Parent = modelSourceAttachment.Parent
			-- Temp Create Fire
			local fire = self:createFire()
			fire.Parent = attachment
			-- Set the attachment Parent
			table.insert(attachments, attachment)
		end
		return attachments
	end
	function TCFrame:LineFormation(modelSourceAttachment, numPositions, distanceFromSource)
		if numPositions == nil then
			numPositions = 5
		end
		if distanceFromSource == nil then
			distanceFromSource = 70
		end
		-- Create an array of attachments to return
		local attachments = {}
		local sourceAttachment = modelSourceAttachment
		-- Add the source attachment to the array position 0
		--attachments.push(sourceAttachment);
		warn("Line Formation: ", numPositions, " positions", " distance from source: ", distanceFromSource, " studs")
		-- Destination Attachment
		local destinationAttachment = Instance.new("Attachment")
		destinationAttachment.Name = "DestinationAttachment"
		destinationAttachment.Position = Vector3.new(sourceAttachment.WorldCFrame.X, sourceAttachment.WorldCFrame.Y, sourceAttachment.WorldCFrame.Z - distanceFromSource)
		print("Destination Attachment Position: ", destinationAttachment.Position)
		-- Calculate the segment length based on the number of positions and the distance from the source
		local segmentLength = distanceFromSource / numPositions
		-- Create the line formation
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
				-- Calculate the goal position
				local goalPosition = Vector3.new(sourceAttachment.WorldCFrame.X, sourceAttachment.WorldCFrame.Y, sourceAttachment.WorldCFrame.Z - segmentLength * i)
				-- Create a new attachment
				local attachment = Instance.new("Attachment")
				attachment.Name = "LineAttachment_" .. tostring(i)
				attachment.Position = goalPosition
				attachment.Parent = sourceAttachment.Parent
				-- Temp Create Fire
				local fire = self:createFire()
				fire.Parent = attachment
				table.insert(attachments, attachment)
			end
		end
		return attachments
	end
	function TCFrame:generateAttachments(modelSourceAttachment, formation, tweenTo)
		local attachments = {}
		repeat
			if formation == (FormationFrames.Circle) then
				attachments = self:CircleFormation(modelSourceAttachment)
				break
			end
			if formation == (FormationFrames.Line) then
				attachments = self:LineFormation(modelSourceAttachment)
				break
			end
			if formation == (FormationFrames.Square) then
				-- Generate a square formation
				break
			end
			if formation == (FormationFrames.Triangle) then
				-- Generate a triangle formation
				break
			end
			if formation == (FormationFrames.Diamond) then
				-- Generate a diamond formation
				break
			end
			if formation == (FormationFrames.Pentagon) then
				-- Generate a pentagon formation
				break
			end
			if formation == (FormationFrames.Hexagon) then
				-- Generate a hexagon formation
				break
			end
			if formation == (FormationFrames.Octagon) then
				-- Generate an octagon formation
				break
			end
			if formation == (FormationFrames.Decagon) then
				-- Generate a decagon formation
				break
			end
			if formation == (FormationFrames.Dodecagon) then
				-- Generate a dodecagon formation
				break
			end
			if formation == (FormationFrames.Star) then
				-- Generate a star formation
				break
			end
			break
		until true
		return attachments
		-- Remove the RenderStepped connection code
	end
end
return {
	FormationFrames = FormationFrames,
	TCFrame = TCFrame,
}
