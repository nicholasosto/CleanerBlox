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
	local initialCFrames = {}
	local _exp = model:GetDescendants()
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(descendant)
		if descendant:IsA("BasePart") then
			local _descendant = descendant
			local _cFrame = descendant.CFrame
			initialCFrames[_descendant] = _cFrame
		end
	end
	for _k, _v in _exp do
		_callback(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.forEach ▲
	local _cFrame = primaryPart.CFrame
	local _arg0 = CFrame.Angles(0, math.pi * 2, 0)
	local goalCFrame = _cFrame * _arg0
	local tweenInfo = TweenInfo.new(duration)
	local tween = TweenService:Create(primaryPart, tweenInfo, {
		CFrame = goalCFrame,
	})
	tween:Play()
	tween.Completed:Connect(function()
		-- ▼ ReadonlyMap.forEach ▼
		local _callback_1 = function(cf, part)
			part.CFrame = cf
		end
		for _k, _v in initialCFrames do
			_callback_1(_v, _k, initialCFrames)
		end
		-- ▲ ReadonlyMap.forEach ▲
		tween:Destroy()
	end)
	-- Remove the RenderStepped connection code
end
-- ...existing code...
return {
	rotatePart = rotatePart,
	rotateModel = rotateModel,
}
