-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local StateMachine
do
	StateMachine = setmetatable({}, {
		__tostring = function()
			return "StateMachine"
		end,
	})
	StateMachine.__index = StateMachine
	function StateMachine.new(...)
		local self = setmetatable({}, StateMachine)
		return self:constructor(...) or self
	end
	function StateMachine:constructor(initialState)
		Logger:NPCLog("Creating StateMachine")
		self.currentState = initialState
		self.currentState:onEnter(nil)
	end
	function StateMachine:changeState(newState)
		Logger:NPCLog(`Changing state to {newState:getName()}`)
		if self.currentState ~= newState then
			local previousState = self.currentState
			if previousState then
				previousState:onExit(newState)
			end
			self.currentState = newState
			self.currentState:onEnter(previousState)
		end
	end
	function StateMachine:update(dt)
		Logger:NPCLog("StateMachine update")
		if self.currentState then
			self.currentState:onUpdate(dt)
		end
	end
	function StateMachine:getCurrentStateName()
		Logger:NPCLog("Getting current state name")
		local _result = self.currentState
		if _result ~= nil then
			_result = _result:getName()
		end
		return _result
	end
end
return {
	StateMachine = StateMachine,
}
