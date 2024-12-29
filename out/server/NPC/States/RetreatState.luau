-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local RetreatState
do
	RetreatState = setmetatable({}, {
		__tostring = function()
			return "RetreatState"
		end,
	})
	RetreatState.__index = RetreatState
	function RetreatState.new(...)
		local self = setmetatable({}, RetreatState)
		return self:constructor(...) or self
	end
	function RetreatState:constructor()
	end
	function RetreatState:onEnter(previousState)
		Logger:NPCLog("Entering Retreat state")
		-- Play idle animation, reset timers, etc.
	end
	function RetreatState:onUpdate(dt)
		-- Check conditions to transition out of Idle
		-- For example: if a player is detected, we might transition to Attack
		-- If we have a waypoint set, we move to Walking
	end
	function RetreatState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
	end
	function RetreatState:getName()
		return "Idle"
	end
end
return {
	RetreatState = RetreatState,
}
