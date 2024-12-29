-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local IdleState
do
	IdleState = setmetatable({}, {
		__tostring = function()
			return "IdleState"
		end,
	})
	IdleState.__index = IdleState
	function IdleState.new(...)
		local self = setmetatable({}, IdleState)
		return self:constructor(...) or self
	end
	function IdleState:constructor(stateMachine)
		self.name = "Idle"
		Logger:NPCLog("Creating Idle State")
		self._stateMachine = stateMachine
		return self
	end
	function IdleState:onEnter(previousState)
		-- Play idle animation, reset timers, etc.
		Logger:NPCLog("-- Enter Idle State")
		self._stateMachine.highlight.Enabled = true
		self._stateMachine.highlight.FillColor = Color3.fromRGB(0, 0, 255)
		self._stateMachine.highlight.OutlineColor = Color3.fromRGB(0, 0, 255)
		task.wait(1)
	end
	function IdleState:onUpdate(dt)
		-- Scan for players
		Logger:NPCLog("Idle - Scanning for players")
		task.wait(2)
		self._stateMachine:changeState(self._stateMachine._states.Patrol)
	end
	function IdleState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
		Logger:NPCLog("-- Exit Idle State")
	end
	function IdleState:getName()
		return "Idle"
	end
end
return {
	IdleState = IdleState,
}
