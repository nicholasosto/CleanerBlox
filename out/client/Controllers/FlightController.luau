-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local RunService = _services.RunService
local UserInputService = _services.UserInputService
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local localPlayer = Players.LocalPlayer
local FlightController
do
	FlightController = setmetatable({}, {
		__tostring = function()
			return "FlightController"
		end,
	})
	FlightController.__index = FlightController
	function FlightController.new(...)
		local self = setmetatable({}, FlightController)
		return self:constructor(...) or self
	end
	function FlightController:constructor()
		self.enabled = false
		self.isFlyingKeyDown = false
		-- Listen for when the local player's character is added
		localPlayer.CharacterAdded:Connect(function(character)
			return self:onCharacterAdded(character)
		end)
		localPlayer.CharacterRemoving:Connect(function()
			return self:onCharacterRemoving()
		end)
		-- If the character already exists (e.g. game just started or respawned), initialize immediately
		if localPlayer.Character then
			self:onCharacterAdded(localPlayer.Character)
		end
		-- Set up input handling
		self:setupInputHandling()
	end
	function FlightController:Start()
		if not self.instance then
			self.instance = FlightController.new()
		end
		self.instance:setEnabled(true)
	end
	function FlightController:GetInstance()
		return self.instance
	end
	function FlightController:setEnabled(value)
		self.enabled = value
		Logger:Log("Flight", `Flight enabled: {value}`)
	end
	function FlightController:toggleEnabled()
		self:setEnabled(not self.enabled)
	end
	function FlightController:setupInputHandling()
		-- Track when the flight key (Space) is pressed or released
		self.inputBeganConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == Enum.KeyCode.Space then
				self.isFlyingKeyDown = true
			end
		end)
		self.inputEndedConnection = UserInputService.InputEnded:Connect(function(input, gameProcessed)
			if input.KeyCode == Enum.KeyCode.Space then
				self.isFlyingKeyDown = false
			end
		end)
	end
	function FlightController:onCharacterAdded(character)
		self.character = character
		self.humanoid = character:WaitForChild("Humanoid")
		self.rootPart = character:WaitForChild("HumanoidRootPart")
		-- Clean up old connection if it exists
		if self.flightConnection then
			self.flightConnection:Disconnect()
		end
		-- Connect to PreSimulation for flight updates
		self.flightConnection = RunService.PreSimulation:Connect(function()
			return self:updateFlight()
		end)
	end
	function FlightController:onCharacterRemoving()
		-- Disconnect the flight update connection if it exists
		if self.flightConnection then
			self.flightConnection:Disconnect()
			self.flightConnection = nil
		end
		self.character = nil
		self.humanoid = nil
		self.rootPart = nil
	end
	function FlightController:updateFlight()
		if not self.enabled or not self.humanoid or not self.rootPart then
			return nil
		end
		if self.isFlyingKeyDown then
			-- Disable physics state if flight key is down
			self.humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
		else
			-- Re-enable physics if not flying
			self.humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
		end
	end
	function FlightController:cleanup()
		-- Call this if you ever need to destroy the flight controller instance
		if self.flightConnection then
			self.flightConnection:Disconnect()
		end
		if self.inputBeganConnection then
			self.inputBeganConnection:Disconnect()
		end
		if self.inputEndedConnection then
			self.inputEndedConnection:Disconnect()
		end
		self.flightConnection = nil
		self.inputBeganConnection = nil
		self.inputEndedConnection = nil
	end
end
-- End of src/client/Controllers/FlightController.ts
return {
	FlightController = FlightController,
}
