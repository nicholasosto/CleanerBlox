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
	function IdleState:constructor(NPCController)
		self.idleTimer = 0
		self.NPCController = NPCController
	end
	function IdleState:onEnter(previousState)
		-- Play idle animation, reset timers, etc.
		Logger:NPCLog("Entering Idle state")
	end
	function IdleState:onUpdate(dt)
		-- Check conditions to transition out of Idle
		-- For example: if a player is detected, we might transition to Attack
		-- If we have a waypoint set, we move to Walking
	end
	function IdleState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
	end
	function IdleState:getName()
		return "Idle"
	end
end
return {
	IdleState = IdleState,
}
