-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local TweenService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").TweenService
local function rotatePart(part, duration)
	local initialCFrame = part.CFrame
	local _arg0 = CFrame.Angles(0, math.pi * 2, 0)
	local goalCFrame = initialCFrame * _arg0
	local tweenInfo = TweenInfo.new(duration)
	local tween = TweenService:Create(part, tweenInfo, {
		CFrame = goalCFrame,
	})
	tween:Play()
	tween.Completed:Connect(function()
		part.CFrame = initialCFrame
		tween:Destroy()
	end)
	-- Remove the RenderStepped connection code
end
local function rotateModel(model, duration)
	print("Rotating model: ", model.Name, " for ", duration, " seconds")
	local primaryPart = model.PrimaryPart
	if not primaryPart then
		warn("Model does not have a PrimaryPart set.")
		return nil
	end
	local _cFrame = primaryPart.CFrame
	local _arg0 = CFrame.Angles(0, math.pi * 2, 0)
	local goalCFrame = _cFrame * _arg0
	local rotatedCFrame = CFrame.new(primaryPart.Position, Vector3.new(350, 0, 0))
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
	local tween = TweenService:Create(primaryPart, tweenInfo, {
		CFrame = rotatedCFrame,
	})
	return tween
end
-- generate a random search path for the model based on the search distance and number of positions
local function randomSearch(model, numPositions, searchDistance, duration)
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
			local position = Vector3.new(math.random(-searchDistance, searchDistance), 0, math.random(-searchDistance, searchDistance))
			local _cFrame = CFrame.new(model:GetPivot().Position)
			local _cFrame_1 = CFrame.new(position)
			local goalCFrame = _cFrame * _cFrame_1
			local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
			if model.PrimaryPart then
				local tween = TweenService:Create(model.PrimaryPart, tweenInfo, {
					CFrame = goalCFrame,
				})
				return tween
			else
				warn("Model does not have a PrimaryPart set.")
			end
		end
	end
end
return {
	rotatePart = rotatePart,
	rotateModel = rotateModel,
	randomSearch = randomSearch,
}
