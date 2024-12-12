-- Compiled with roblox-ts v3.0.0
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
	function ParticleGroupManager:disableParticleGroup(particleGroup)
		if particleGroup == nil then
			return nil
		end
		local _exp = particleGroup:GetDescendants()
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
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(particle)
			particle.Enabled = false
		end
		for _k, _v in particleEffects do
			_callback_1(_v, _k - 1, particleEffects)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function ParticleGroupManager:enableParticleGroup(particleGroup)
		if particleGroup == nil then
			return nil
		end
		local _exp = particleGroup:GetDescendants()
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
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(particle)
			particle.Enabled = true
		end
		for _k, _v in particleEffects do
			_callback_1(_v, _k - 1, particleEffects)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function ParticleGroupManager:adjustParticleGroupTransparency(particleGroup, transparency)
		if transparency == nil or particleGroup == nil then
			return nil
		end
		local _exp = particleGroup:GetDescendants()
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
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(particle)
			local currentTransparency = particle.Transparency
			local _exp_1 = currentTransparency.Keypoints
			-- ▼ ReadonlyArray.map ▼
			local _newValue_1 = table.create(#_exp_1)
			local _callback_2 = function(keypoint)
				return NumberSequenceKeypoint.new(keypoint.Time, keypoint.Value * transparency)
			end
			for _k, _v in _exp_1 do
				_newValue_1[_k] = _callback_2(_v, _k - 1, _exp_1)
			end
			-- ▲ ReadonlyArray.map ▲
			local adjustedTransparency = _newValue_1
			particle.Transparency = NumberSequence.new(adjustedTransparency)
		end
		for _k, _v in particleEffects do
			_callback_1(_v, _k - 1, particleEffects)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function ParticleGroupManager:adjustParticleGroupSize(particleGroup, size)
		if particleGroup == nil or size == nil then
			return nil
		end
		local _exp = particleGroup:GetDescendants()
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
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(particle)
			particle.Size = NumberSequence.new(size)
		end
		for _k, _v in particleEffects do
			_callback_1(_v, _k - 1, particleEffects)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
end
return {
	ParticleGroupManager = ParticleGroupManager,
}
