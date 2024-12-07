-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- KeyboardClient.ts
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local UserInputService = _services.UserInputService
local KeyboardClient
do
	KeyboardClient = setmetatable({}, {
		__tostring = function()
			return "KeyboardClient"
		end,
	})
	KeyboardClient.__index = KeyboardClient
	function KeyboardClient.new(...)
		local self = setmetatable({}, KeyboardClient)
		return self:constructor(...) or self
	end
	function KeyboardClient:constructor()
		self.player = Players.LocalPlayer
		self:bindKeyboardEvents()
	end
	function KeyboardClient:bindKeyboardEvents()
		UserInputService.InputBegan:Connect(function(input, isProcessed)
			if isProcessed then
				return nil
			end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				local keyCode = input.KeyCode
				repeat
					if keyCode == (Enum.KeyCode.W) then
						self:onWKeyPress()
						break
					end
					if keyCode == (Enum.KeyCode.A) then
						self:onAKeyPress()
						break
					end
					if keyCode == (Enum.KeyCode.S) then
						self:onSKeyPress()
						break
					end
					if keyCode == (Enum.KeyCode.D) then
						self:onDKeyPress()
						break
					end
				until true
			end
		end)
	end
	function KeyboardClient:onWKeyPress()
		-- Implement logic for when 'W' is pressed
		print("W key pressed")
	end
	function KeyboardClient:onAKeyPress()
		-- Implement logic for when 'A' is pressed
		print("A key pressed")
	end
	function KeyboardClient:onSKeyPress()
		-- Implement logic for when 'S' is pressed
		print("S key pressed")
	end
	function KeyboardClient:onDKeyPress()
		-- Implement logic for when 'D' is pressed
		print("D key pressed")
	end
end
return {
	KeyboardClient = KeyboardClient,
}
