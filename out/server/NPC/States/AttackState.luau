-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local AttackState
do
	AttackState = setmetatable({}, {
		__tostring = function()
			return "AttackState"
		end,
	})
	AttackState.__index = AttackState
	function AttackState.new(...)
		local self = setmetatable({}, AttackState)
		return self:constructor(...) or self
	end
	function AttackState:constructor(stateMachine)
		self.name = "Attack"
		Logger:NPCLog("Creating Attack State")
		self._stateMachine = stateMachine
		return self
	end
	function AttackState:onEnter(previousState)
		-- Play idle animation, reset timers, etc.
		Logger:NPCLog("-- Enter Attack State")
		self._stateMachine.highlight.Enabled = true
		self._stateMachine.highlight.FillColor = Color3.fromRGB(255, 0, 0)
		self._stateMachine.highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
	end
	function AttackState:onUpdate(dt)
		-- Scan for players
		Logger:NPCLog("Attack - Scanning for players")
		task.wait(1)
		self._stateMachine:changeState(self._stateMachine._states.Idle)
	end
	function AttackState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
		Logger:NPCLog("-- Exit Attack State")
	end
	function AttackState:getName()
		return "Attack"
	end
end
return {
	AttackState = AttackState,
}
