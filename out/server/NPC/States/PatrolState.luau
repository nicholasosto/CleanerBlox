-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local PatrolState
do
	PatrolState = setmetatable({}, {
		__tostring = function()
			return "PatrolState"
		end,
	})
	PatrolState.__index = PatrolState
	function PatrolState.new(...)
		local self = setmetatable({}, PatrolState)
		return self:constructor(...) or self
	end
	function PatrolState:constructor()
	end
	function PatrolState:onEnter(previousState)
		Logger:NPCLog("Entering Patrol state")
		-- Play idle animation, reset timers, etc.
	end
	function PatrolState:onUpdate(dt)
		-- Check conditions to transition out of Idle
		-- For example: if a player is detected, we might transition to Attack
		-- If we have a waypoint set, we move to Walking
	end
	function PatrolState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
	end
	function PatrolState:getName()
		return "Idle"
	end
end
return {
	PatrolState = PatrolState,
}
