-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local DeadState
do
	DeadState = setmetatable({}, {
		__tostring = function()
			return "DeadState"
		end,
	})
	DeadState.__index = DeadState
	function DeadState.new(...)
		local self = setmetatable({}, DeadState)
		return self:constructor(...) or self
	end
	function DeadState:constructor()
	end
	function DeadState:onEnter(previousState)
		Logger:NPCLog("Entering Dead state")
		-- Play idle animation, reset timers, etc.
	end
	function DeadState:onUpdate(dt)
		-- Check conditions to transition out of Idle
		-- For example: if a player is detected, we might transition to Attack
		-- If we have a waypoint set, we move to Walking
	end
	function DeadState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
	end
	function DeadState:getName()
		return "Idle"
	end
end
return {
	DeadState = DeadState,
}
