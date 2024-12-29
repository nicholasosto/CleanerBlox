-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local IdleState = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "States", "IdleState").IdleState
local PatrolState = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "States", "PatrolState").PatrolState
local AttackState = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "States", "AttackState").AttackState
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local NPCStateMachine
do
	NPCStateMachine = setmetatable({}, {
		__tostring = function()
			return "NPCStateMachine"
		end,
	})
	NPCStateMachine.__index = NPCStateMachine
	function NPCStateMachine.new(...)
		local self = setmetatable({}, NPCStateMachine)
		return self:constructor(...) or self
	end
	function NPCStateMachine:constructor(robloxModel)
		self._states = {}
		-- Assign the model and humanoid instances
		self.modelInstance = robloxModel
		self.highlight = robloxModel:WaitForChild("StateColor")
		self.highlight.Enabled = false
		-- Set the initial state to Idle
		local __states = self._states
		local _idleState = IdleState.new(self)
		__states.Idle = _idleState
		local __states_1 = self._states
		local _patrolState = PatrolState.new(self)
		__states_1.Patrol = _patrolState
		local __states_2 = self._states
		local _attackState = AttackState.new(self)
		__states_2.Attack = _attackState
		self.currentState = self._states.Idle
		self._wcsCharacter = Character.GetCharacterFromInstance(robloxModel)
		self.humanoidInstance = robloxModel:FindFirstChildOfClass("Humanoid")
		return self
	end
	function NPCStateMachine:changeState(newState)
		Logger:NPCLog("StateMachine changeState")
		if self.currentState ~= newState then
			local previousState = self.currentState
			if previousState then
				previousState:onExit(newState)
			end
			self.currentState = newState
			self.currentState:onEnter(previousState)
		end
	end
	function NPCStateMachine:update(dt)
		Logger:NPCLog("StateMachine update")
		self.currentState:onUpdate(dt)
		-- State Change Conditions check
	end
end
return {
	NPCStateMachine = NPCStateMachine,
}
