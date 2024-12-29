-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local ConversationState
do
	ConversationState = setmetatable({}, {
		__tostring = function()
			return "ConversationState"
		end,
	})
	ConversationState.__index = ConversationState
	function ConversationState.new(...)
		local self = setmetatable({}, ConversationState)
		return self:constructor(...) or self
	end
	function ConversationState:constructor()
	end
	function ConversationState:onEnter(previousState)
		Logger:NPCLog("Entering Conversation state")
		-- Play idle animation, reset timers, etc.
	end
	function ConversationState:onUpdate(dt)
		-- Check conditions to transition out of Idle
		-- For example: if a player is detected, we might transition to Attack
		-- If we have a waypoint set, we move to Walking
	end
	function ConversationState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
	end
	function ConversationState:getName()
		return "Idle"
	end
end
return {
	ConversationState = ConversationState,
}
