-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Roblox Services
local RunService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").RunService
-- Custom Services
-- Factories
local _Humanoids = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Refrences", "Humanoids")
local HumanoidDescriptionFactory = _Humanoids.HumanoidDescriptionFactory
local EHumanoidDescription = _Humanoids.EHumanoidDescription
-- Plugin Services
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
-- Controllers
local AnimationController = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "Controllers", "AnimationController").AnimationController
-- States
local IdleState = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "States", "IdleState").IdleState
local PatrolState = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "States", "PatrolState").PatrolState
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local AttackState = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "States", "AttackState").AttackState
local NPCController
do
	NPCController = setmetatable({}, {
		__tostring = function()
			return "NPCController"
		end,
	})
	NPCController.__index = NPCController
	function NPCController.new(...)
		local self = setmetatable({}, NPCController)
		return self:constructor(...) or self
	end
	function NPCController:constructor(character)
		self._lastUpdate = 0
		self._timeSinceLastUpdate = 0
		self._cycleTime = 1
		self._idleState = IdleState.new(self)
		self._patrolState = PatrolState.new(self)
		self._attackState = AttackState.new(self)
		-- Get the model instance and humanoid
		self.rigModel = character
		self.wcsCharacter = Character.GetCharacterFromInstance(character)
		self.startingPosition = character:WaitForChild("StartingPos")
		local _result = character.PrimaryPart
		if _result ~= nil then
			_result = _result.Position
		end
		local _condition = _result
		if not _condition then
			_condition = Vector3.new(0, 0, 0)
		end
		self.startingPosition.Value = _condition
		-- Get the animator and humanoid
		local animator = character:FindFirstChild("Animator", true)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid == nil then
			error(`No humanoid in NPC character: {character.Name}`)
		end
		--START TEST HUMANOID DESCRIPTION
		local hdFactory = HumanoidDescriptionFactory:getInstance()
		local hd = HumanoidDescriptionFactory:ApplyHumanoidDescription(humanoid, EHumanoidDescription.RobotBase)
		--END TEST
		-- Create the animation controller
		self.animationController = AnimationController.new(humanoid)
		-- Get the primary part and unanchor
		local PrimaryPart = character.PrimaryPart
		PrimaryPart.Anchored = false
		-- Set initial state
		self:setState(self._patrolState)
		-- Connect to heartbeat
		self:_connectHeartbeat()
	end
	function NPCController:_connectHeartbeat()
		-- Connect to heartbeat: Runs update once per cycle time this._cycleTime (in seconds)
		self._connectionHeartbeat = RunService.Heartbeat:Connect(function(dt)
			-- Calculate time since last update
			self._timeSinceLastUpdate += dt
			-- Update loop
			if self._timeSinceLastUpdate >= self._cycleTime then
				-- reset time since last update
				self._lastUpdate = tick()
				self._timeSinceLastUpdate = 0
				-- Update the NPC
				self:update(dt)
			end
		end)
	end
	function NPCController:update(dt)
		local _exp = "NPC Update: " .. self.rigModel.Name .. " - "
		local _result = self._currentState
		if _result ~= nil then
			_result = _result.name
		end
		Logger:NPCLog(_exp .. tostring(_result))
		local _result_1 = self._currentState
		if _result_1 ~= nil then
			_result_1:onUpdate(dt)
		end
	end
	function NPCController:setState(newState)
		local _result = self._currentState
		if _result ~= nil then
			_result:onExit(newState)
		end
		self._currentState = newState
		self._currentState:onEnter(self._currentState)
	end
end
return {
	NPCController = NPCController,
}
