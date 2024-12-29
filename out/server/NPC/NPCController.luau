-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Roblox Services
local RunService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").RunService
local Anim = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "animation", "out")
local EAnimationName = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Refrences", "AnimationReference").EAnimationName
-- Plugin Services
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
-- Controllers
local AnimationController = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "Controllers", "AnimationController").AnimationController
local NPCStateMachine = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "Controllers", "NPCStateMachine").NPCStateMachine
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
		Logger:NPCLog("Creating NPCController")
		if character == nil then
			error("Character is undefined")
		end
		-- Get the model instance and humanoid
		self.rigModel = character
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
		local animator = character:FindFirstChild("Animator", true)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local PrimaryPart = character.PrimaryPart
		PrimaryPart.Anchored = false
		self.stateMachine = NPCStateMachine.new(character)
		if self.stateMachine == nil then
			error("StateMachine is undefined")
		end
		self._attackState = AttackState.new(self.stateMachine)
		self._idleState = IdleState.new(self.stateMachine)
		self._patrolState = PatrolState.new(self.stateMachine)
		-- Set initial state
		self:setState(self._patrolState)
		self.wcsCharacter = Character.GetCharacterFromInstance(character)
		local Bundle = Anim.Animation.createAnimations({
			Melee = EAnimationName.SKILL_BasicMeleeAttack,
			Idle = EAnimationName.FLIGHT_Up,
		})
		Anim.Animation.loadAnimator(animator, Bundle).Idle:Play()
		if not humanoid then
			error(`No humanoid in NPC character: {character.Name}`)
		end
		self.animationController = AnimationController.new(humanoid)
		-- Create initial states
		--const idleState = new IdleState(this);
		--this.stateMachine = new StateMachine(idleState);
		-- Additional initialization like event connections
		self:_connectHeartbeat()
	end
	function NPCController:_connectHeartbeat()
		Logger:NPCLog("00 - Init - Connecting Heartbeat")
		self._connectionHeartbeat = RunService.Heartbeat:Connect(function(dt)
			self:update(dt)
		end)
	end
	function NPCController:update(dt)
		Logger:NPCLog("INF - NPCController update")
		self.stateMachine:update(dt)
	end
	function NPCController:setState(newState)
		local _result = newState
		if _result ~= nil then
			_result = _result.name
		end
		Logger:NPCLog("INF - State Change:  " .. _result)
		self.stateMachine:changeState(newState)
	end
end
return {
	NPCController = NPCController,
}
