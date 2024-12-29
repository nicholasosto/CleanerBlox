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
local StateMachine = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "Controllers", "StateMachine").StateMachine
-- States
local IdleState = TS.import(script, game:GetService("ServerScriptService"), "TS", "NPC", "States", "IdleState").IdleState
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
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
		-- Get the model instance and humanoid
		self.rigModel = character
		local animator = character:FindFirstChild("Animator", true)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
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
		local idleState = IdleState.new(self)
		self.stateMachine = StateMachine.new(idleState)
		-- Additional initialization like event connections
		self:_connectHeartbeat()
	end
	function NPCController:_connectHeartbeat()
		Logger:NPCLog("Connecting Heartbeat")
		return RunService.Heartbeat:Connect(function(dt)
			return self:update(dt)
		end)
	end
	function NPCController:update(dt)
		Logger:NPCLog("NPCController update")
		self.stateMachine:update(dt)
	end
	function NPCController:setState(newState)
		Logger:NPCLog("Setting new state")
		self.stateMachine:changeState(newState)
	end
end
return {
	NPCController = NPCController,
}
