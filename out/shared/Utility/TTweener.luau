-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local TweenService = _services.TweenService
local CollectionService = _services.CollectionService
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local TagTweener
do
	TagTweener = setmetatable({}, {
		__tostring = function()
			return "TagTweener"
		end,
	})
	TagTweener.__index = TagTweener
	function TagTweener.new(...)
		local self = setmetatable({}, TagTweener)
		return self:constructor(...) or self
	end
	function TagTweener:constructor()
		self._instanceAddedConnection = CollectionService:GetInstanceAddedSignal("TweenAttachment"):Connect(function(instance)
			local attachment = instance
			if attachment == nil then
				Logger:Log(script, "BasicMelee", "Instance is not an attachment")
				return nil
			end
			local duration = 1
			local endPosition = Vector3.new(5, 0, 0)
			local repetes = -1
			TagTweener:StartLinearTween(attachment, duration, endPosition, repetes)
		end)
	end
	function TagTweener:Start()
		if self._instance == nil then
			self._instance = TagTweener.new()
		end
	end
	function TagTweener:StartLinearTween(attachment, duration, endPosition, repetes)
		local startPosition = attachment.Position
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, repetes, false, 0)
		local tween = TweenService:Create(attachment, tweenInfo, {
			Position = endPosition,
		})
		tween.Completed:Connect(function()
			attachment.Position = endPosition
		end)
		tween:Play()
	end
end
return {
	TagTweener = TagTweener,
}
