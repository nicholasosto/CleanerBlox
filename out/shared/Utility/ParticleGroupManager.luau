-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local ParticleGroupManager
do
	ParticleGroupManager = setmetatable({}, {
		__tostring = function()
			return "ParticleGroupManager"
		end,
	})
	ParticleGroupManager.__index = ParticleGroupManager
	function ParticleGroupManager.new(...)
		local self = setmetatable({}, ParticleGroupManager)
		return self:constructor(...) or self
	end
	function ParticleGroupManager:constructor()
	end
	function ParticleGroupManager:getParticleDecendants(particleParent)
		local _exp = particleParent:GetChildren()
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _callback = function(child)
			return child:IsA("ParticleEmitter")
		end
		local _length = 0
		for _k, _v in _exp do
			if _callback(_v, _k - 1, _exp) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		local particleEffects = _newValue
		return particleEffects
	end
	function ParticleGroupManager:PrintParticleGroup(particleGroup)
		local particleEffects = ParticleGroupManager:getParticleDecendants(particleGroup)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(particle)
			Logger:Log("Particle", particle.Name)
		end
		for _k, _v in particleEffects do
			_callback(_v, _k - 1, particleEffects)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function ParticleGroupManager:GetParticleGroup(name)
		local particleGroup = GameStorage:getModel(name)
		if particleGroup == nil then
			Logger:Log("ParticleGroupManager", "Particle Group not found", name)
		end
		return particleGroup
	end
	function ParticleGroupManager:EnableParticleGroup(particleGroup)
		local particleEffects = ParticleGroupManager:getParticleDecendants(particleGroup)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(particle)
			particle.Enabled = true
		end
		for _k, _v in particleEffects do
			_callback(_v, _k - 1, particleEffects)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function ParticleGroupManager:AdjustParticleGroupSize(particleGroup, scale)
		local particleEffects = ParticleGroupManager:getParticleDecendants(particleGroup)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(particle)
			particle.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, scale) })
		end
		for _k, _v in particleEffects do
			_callback(_v, _k - 1, particleEffects)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
end
return {
	ParticleGroupManager = ParticleGroupManager,
}
