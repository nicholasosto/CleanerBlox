-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local EAnimationName = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Refrences", "AnimationReference").EAnimationName
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
	function AttackState:constructor(npc)
		self.name = "Attack"
		Logger:NPCLog("Creating: " .. self.name)
		self._npcController = npc
		return self
	end
	function AttackState:onEnter(previousState)
		-- Play idle animation, reset timers, etc.
		local _result = previousState
		if _result ~= nil then
			_result = _result.name
		end
		Logger:NPCLog("Previous: " .. tostring(_result) .. " new: " .. self.name)
		self._npcController.animationController:playAnimation(EAnimationName.NPC_Attack)
	end
	function AttackState:onUpdate(dt)
		-- Scan for players
		Logger:NPCLog(self.name .. " - Update")
		self._npcController.animationController:playAnimation(EAnimationName.NPC_Attack)
		task.wait(1)
	end
	function AttackState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
		self._npcController.animationController:stopAnimation(EAnimationName.NPC_Attack)
		Logger:NPCLog(self.name .. " - Exit to " .. nextState.name)
	end
end
return {
	AttackState = AttackState,
}
