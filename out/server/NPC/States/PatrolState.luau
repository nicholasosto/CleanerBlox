-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local CharacterUtility = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "CharacterUtility").CharacterUtility
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
	function PatrolState:constructor(stateMachine)
		self.name = "Patrol"
		self._lastUpdate = 0
		Logger:NPCLog("Creating Patrol State")
		local model = stateMachine.modelInstance
		local VectorValueObject = model:WaitForChild("StartingPos")
		self._startingPosition = VectorValueObject.Value
		self._stateMachine = stateMachine
		return self
	end
	function PatrolState:onEnter(previousState)
		-- Play idle animation, reset timers, etc.
		Logger:NPCLog("-- Enter Patrol State")
		self._stateMachine.highlight.Enabled = true
		self._stateMachine.highlight.FillColor = Color3.fromRGB(0, 255, 0)
		self._stateMachine.highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
	end
	function PatrolState:onUpdate(dt)
		local humanoid = self._stateMachine.humanoidInstance
		local model = self._stateMachine.modelInstance
		local now = tick()
		local delta = now - self._lastUpdate
		if humanoid:GetMoveVelocity().Magnitude < 0.1 or delta > 5 then
			local closestCharacter = CharacterUtility:getClosestCharacterFrom(model, 30)
			local _result = closestCharacter
			if _result ~= nil then
				_result = _result.Instance
			end
			local characterInstance = _result
			if characterInstance == nil then
				return nil
			end
			local characterPosition = characterInstance:GetPivot().Position
			humanoid:MoveTo(characterPosition)
			task.wait(1)
			local distance = (model:GetPivot().Position - characterPosition).Magnitude
			if distance < 30 then
				self._stateMachine:changeState(self._stateMachine._states.Attack)
			end
			local __startingPosition = self._startingPosition
			local _position = model:GetPivot().Position
			if (__startingPosition - _position).Magnitude > 30 then
				humanoid:MoveTo(self._startingPosition)
			end
		end
	end
	function PatrolState:onExit(nextState)
		-- Cleanup if necessary (e.g., stop idle animation)
		Logger:NPCLog("-- Exit Patrol State")
		self._stateMachine.highlight.Enabled = false
	end
end
return {
	PatrolState = PatrolState,
}
