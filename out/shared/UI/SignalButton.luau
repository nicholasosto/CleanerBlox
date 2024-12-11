-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- SignalButton.ts
local Signal = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "signals-tooling", "out").Signal
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local SignalButton
do
	SignalButton = setmetatable({}, {
		__tostring = function()
			return "SignalButton"
		end,
	})
	SignalButton.__index = SignalButton
	function SignalButton.new(...)
		local self = setmetatable({}, SignalButton)
		return self:constructor(...) or self
	end
	function SignalButton:constructor(buttonInstance, config)
		self.isPressed = false
		self.Activated = Signal.new()
		self.Released = Signal.new()
		Logger:Log("SignalButton", "<Constructor>", buttonInstance)
		self.buttonInstance = buttonInstance
		local _condition = config.holdable
		if _condition == nil then
			_condition = false
		end
		self.holdable = _condition
		-- Connect input events
		if buttonInstance:IsA("GuiButton") then
			buttonInstance.MouseButton1Down:Connect(function()
				return self:handlePress()
			end)
			buttonInstance.MouseButton1Up:Connect(function()
				return self:handleRelease()
			end)
			buttonInstance.MouseLeave:Connect(function()
				return self:handleRelease()
			end)
		else
			error("SignalButton can only be used with GuiButton instances.")
		end
	end
	function SignalButton:getInstance()
		return self.buttonInstance
	end
	function SignalButton:codedPress()
		self:handlePress()
		task.wait(2)
		self:handleRelease()
	end
	function SignalButton:handlePress()
		if not self.isPressed then
			self.isPressed = true
			self.Activated:fire()
			Logger:Log("SignalButton", "Button Pressed: ", self.buttonInstance)
		end
	end
	function SignalButton:handleRelease()
		if self.isPressed then
			self.isPressed = false
			Logger:Log("SignalButton", "Rel1 ", self.buttonInstance)
			if self.holdable then
				self.Released:fire()
				Logger:Log("SignalButton", "Rel2", self.buttonInstance)
			end
		end
	end
	function SignalButton:destroy()
		self.Activated:disconnectAll()
		self.Released:disconnectAll()
	end
end
return {
	SignalButton = SignalButton,
}
