-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local EAnimationName = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Refrences", "AnimationReference").EAnimationName
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
	function IdleState:constructor(npc)
		self.name = "Idle"
		Logger:NPCLog(self.name .. " - Creating")
		self._npcController = npc
		return self
	end
	function IdleState:onEnter(previousState)
		-- Play idle animation, reset timers, etc.
		self._npcController.animationController:playAnimation(EAnimationName.NPC_Idle)
	end
	function IdleState:onUpdate(dt)
		-- Scan for players
		Logger:NPCLog(self.name .. " - Update")
		self._npcController.animationController:playAnimation(EAnimationName.NPC_Idle)
		task.wait(2)
	end
	function IdleState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
		self._npcController.animationController:stopAnimation(EAnimationName.NPC_Idle)
		Logger:NPCLog(self.name .. " - Exit to " .. nextState.name)
	end
end
return {
	IdleState = IdleState,
}
