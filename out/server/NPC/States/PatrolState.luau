-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local EAnimationName = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Refrences", "AnimationReference").EAnimationName
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
	function PatrolState:constructor(npc)
		self.name = "Patrol"
		Logger:NPCLog("Creating: " .. self.name)
		self._npcController = npc
		return self
	end
	function PatrolState:onEnter(previousState)
		-- Play idle animation, reset timers, etc.
		local _result = previousState
		if _result ~= nil then
			_result = _result.name
		end
		Logger:NPCLog("Previous: " .. tostring(_result) .. " new: " .. self.name)
		self._npcController.animationController:playAnimation(EAnimationName.NPC_Patrol)
	end
	function PatrolState:onUpdate(dt)
		-- Scan for players
		Logger:NPCLog(self.name .. " - Update")
		self._npcController.animationController:playAnimation(EAnimationName.NPC_Patrol)
		task.wait(1)
	end
	function PatrolState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
		self._npcController.animationController:stopAnimation(EAnimationName.NPC_Patrol)
		Logger:NPCLog(self.name .. " - Exit to " .. nextState.name)
	end
end
return {
	PatrolState = PatrolState,
}
