-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local ReplicatedStorage = _services.ReplicatedStorage
local Debris = _services.Debris
local _TRef = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "TRef")
local ParticleEmitter = _TRef.ParticleEmitter
local TParts = _TRef.TParts
-- Folder References
local ParticlePack = ReplicatedStorage:FindFirstChild("PARTICLE_PACK", true)
local AnimationsFolder = ReplicatedStorage:FindFirstChild("Melee Unarmed", true)
local CastingAnimationsFolder = ReplicatedStorage:FindFirstChild("Casting", true)
-- Animation References
local _exp = AnimationsFolder:GetChildren()
-- ▼ ReadonlyArray.map ▼
local _newValue = table.create(#_exp)
local _callback = function(animation)
	return animation
end
for _k, _v in _exp do
	_newValue[_k] = _callback(_v, _k - 1, _exp)
end
-- ▲ ReadonlyArray.map ▲
local MeleeAnimations = _newValue
local _exp_1 = CastingAnimationsFolder:GetChildren()
-- ▼ ReadonlyArray.map ▼
local _newValue_1 = table.create(#_exp_1)
local _callback_1 = function(animation)
	return animation
end
for _k, _v in _exp_1 do
	_newValue_1[_k] = _callback_1(_v, _k - 1, _exp_1)
end
-- ▲ ReadonlyArray.map ▲
local CastingAnimations = _newValue_1
local Attack
do
	local super = Skill
	Attack = setmetatable({}, {
		__tostring = function()
			return "Attack"
		end,
		__index = super,
	})
	Attack.__index = Attack
	function Attack.new(...)
		local self = setmetatable({}, Attack)
		return self:constructor(...) or self
	end
	function Attack:constructor(...)
		super.constructor(self, ...)
		self.duration = 2.5
	end
	function Attack:initiation()
		print("Attack initiated")
		local character = self.Character.Instance
		-- load the casting animation to the character
		local initialAnimation = self.Character.Humanoid:LoadAnimation(CastingAnimations[2])
		-- play the animation
		--initialAnimation.Play();
		local _result = ParticlePack:FindFirstChild("Evil Emmination", true)
		if _result ~= nil then
			_result = _result:Clone()
		end
		local castingHandAuraRH = _result
		local _result_1 = ParticlePack:FindFirstChild("Evil Emmination", true)
		if _result_1 ~= nil then
			_result_1 = _result_1:Clone()
		end
		local castingHandAuraLH = _result_1
		local castingAura = ParticleEmitter.castingAura:Clone()
		local castingCircle = TParts.castingCircle:Clone()
		if castingHandAuraRH and castingHandAuraLH then
			Debris:AddItem(castingHandAuraRH, self.duration)
			Debris:AddItem(castingHandAuraLH, self.duration)
			castingHandAuraRH.Parent = character:FindFirstChild("RightHand")
			castingHandAuraLH.Parent = character:FindFirstChild("LeftHand")
			castingCircle.Parent = character:FindFirstChild("HumanoidRootPart")
			castingAura.Parent = character:FindFirstChild("HumanoidRootPart")
		end
	end
	function Attack:spawnProjectile()
		local projectile = Instance.new("Part")
		projectile.Size = Vector3.new(1, 1, 1)
		projectile.Parent = self.Character.Instance
		projectile.Anchored = true
		projectile.CanCollide = false
		local characterModel = self.Character.Instance
		if characterModel.PrimaryPart then
			projectile:PivotTo(characterModel:GetPivot())
		end
	end
	function Attack:OnStartServer()
		print("Hi, attack just started!")
		self:initiation()
		--const humanoid = this.Character.Humanoid;
		--const animationTrack = this.Character.Humanoid.LoadAnimation(MeleeAnimations[0]);
		--animationTrack.Play();
		self:ApplyCooldown(3)
	end
	Attack = SkillDecorator(Attack) or Attack
end
return {
	Attack = Attack,
}
