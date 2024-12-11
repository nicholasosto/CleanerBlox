-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local TweenService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").TweenService
local InfoTable = {
	Standard = {
		Default = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0),
		Fast = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0),
		Slow = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0),
	},
	Elastic = {
		Default = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, -1, false, 0),
		Fast = TweenInfo.new(0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, -1, false, 0),
		Slow = TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, -1, false, 0),
	},
	Bounce = {
		Default = TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, -1, false, 0),
		Fast = TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, -1, false, 0),
		Slow = TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, -1, false, 0),
	},
}
local TTweener
do
	TTweener = setmetatable({}, {
		__tostring = function()
			return "TTweener"
		end,
	})
	TTweener.__index = TTweener
	function TTweener.new(...)
		local self = setmetatable({}, TTweener)
		return self:constructor(...) or self
	end
	function TTweener:constructor()
	end
	function TTweener:tweenPart(part, properties, callback)
		local tween = TweenService:Create(part, InfoTable.Standard.Default, properties)
		if callback then
			tween.Completed:Connect(callback)
		end
		return tween
	end
	function TTweener:tweenPartCFrame(part, newCFrame, overDuration, callback)
		local defaultTweenInfo = InfoTable.Standard.Default
		local tweenInfo = TweenInfo.new(overDuration, defaultTweenInfo.EasingStyle, defaultTweenInfo.EasingDirection, -1, false, defaultTweenInfo.DelayTime)
		local properties = {
			CFrame = newCFrame,
		}
		local tween = TweenService:Create(part, tweenInfo, properties)
		if callback then
			tween.Completed:Connect(callback)
		end
		return tween
	end
end
return {
	InfoTable = InfoTable,
	TTweener = TTweener,
}
