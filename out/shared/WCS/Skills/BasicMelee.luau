-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local _SkillManagers = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "SkillManagers")
local AnimationManager = _SkillManagers.AnimationManager
local AudioManager = _SkillManagers.AudioManager
local ParticleGroupManager = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "ParticleGroupManager").ParticleGroupManager
local WeaponManager = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "Movesets", "WeaponManager").WeaponManager
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local BasicMelee
do
	local super = Skill
	BasicMelee = setmetatable({}, {
		__tostring = function()
			return "BasicMelee"
		end,
		__index = super,
	})
	BasicMelee.__index = BasicMelee
	function BasicMelee.new(...)
		local self = setmetatable({}, BasicMelee)
		return self:constructor(...) or self
	end
	function BasicMelee:constructor(...)
		super.constructor(self, ...)
	end
	function BasicMelee:OnConstruct()
		--Logger.Log("BasicMelee", "OnConstruct");
	end
	function BasicMelee:OnConstructServer()
		Logger:Log("BasicMelee", "OnConstructServer")
		local character = self.Character.Instance
		if character == nil then
			Logger:Log("BasicMelee", "No Character Found")
			return nil
		end
		self.DamageContainer = self:CreateDamageContainer(BasicMelee.SkillConfiguration.DefaultHealthChange)
		-- Load Sound
		-- eslint-disable-next-line prettier/prettier
		self.ActivationSound = AudioManager:LoadWCSSound(self.Character, "BasicMelee_ActivationAudio", BasicMelee.SkillConfiguration.ActivationSoundId)
		-- Load Animation
		-- eslint-disable-next-line prettier/prettier
		self.ActivationAnimationTrack = AnimationManager:LoadWCSCharacterAnimation(self.Character, "BasicMelee_ActivationAnimation", BasicMelee.SkillConfiguration.ActivationAnimationId, BasicMelee.SkillConfiguration.ActivationTime)
		-- Load Particles
		-- eslint-disable-next-line prettier/prettier
		self.ActivationParticles = ParticleGroupManager:GetParticleGroup(BasicMelee.SkillConfiguration.ActivationParticleGroup)
		ParticleGroupManager:ParentParticleEmtters(self.ActivationParticles, self.Character.Instance:FindFirstChild("RightGripAttachment", true))
		ParticleGroupManager:DisableParticleEmitters(self.ActivationParticles)
		-- Load Weapon
		self.SkillWeapon = WeaponManager:LoadWCSCharacterWeapon(self.Character, "Scythe_Epic_Black")
		local _result = self.SkillWeapon
		if _result ~= nil then
			_result = _result:FindFirstChild("Handle")
		end
		self.SkillHitPart = _result
		if self.SkillHitPart == nil then
			--Logger.Log("BasicMelee", "No Hit Part Found");
			return nil
		end
		local _result_1 = self.HitPartConnection
		if _result_1 ~= nil then
			_result_1:Disconnect()
		end
		self.HitPartConnection = self.SkillHitPart.Touched:Connect(function(hit)
			local _result_2 = hit.Parent
			if _result_2 ~= nil then
				_result_2 = _result_2.Name
			end
			Logger:Log("BasicMelee", `Hit: {_result_2}`)
			if hit.Parent == self.Character.Instance then
				Logger:Log("BasicMelee", "Hit Self")
				return nil
			end
			local _result_3 = hit.Parent
			if _result_3 ~= nil then
				_result_3 = _result_3:FindFirstChild("Humanoid")
			end
			if _result_3 == nil then
				Logger:Log("BasicMelee", "No Humanoid Found")
				return nil
			end
			local targetCharacter = Character.GetCharacterFromInstance(hit.Parent)
			if targetCharacter == nil then
				local _result_4 = hit.Parent
				if _result_4 ~= nil then
					_result_4 = _result_4.Parent
				end
				targetCharacter = Character.GetCharacterFromInstance(_result_4)
				Logger:Log("BasicMelee", "No Target Character Found")
				local _result_5 = targetCharacter
				if _result_5 ~= nil then
					_result_5:TakeDamage(self.DamageContainer)
				end
			end
			--hit.Parent = undefined;
		end)
		--ParticleGroupManager.DisableParticleEmitters(this.ActivationParticles as [ParticleEmitter]);
		Logger:Log("BasicMelee", "Animation, Sound, and Particles Loaded")
	end
	function BasicMelee:OnConstructClient()
		Logger:Log("BasicMelee", "OnConstructClinet")
	end
	function BasicMelee:OnStartServer()
		self:ApplyCooldown(BasicMelee.SkillConfiguration.DefaultCooldownTime)
		self.Character:TakeDamage(self:CreateDamageContainer(10))
		local _result = self.ActivationSound
		if _result ~= nil then
			_result:Play()
		end
		AnimationManager:PlayAnimation(self.ActivationAnimationTrack, BasicMelee.SkillConfiguration.ActivationTime)
		--this.ActivationAnimationTrack?.Play();
		ParticleGroupManager:EnableParticleEmitters(self.ActivationParticles)
		WeaponManager:EquipWCSCharacterWeapon(self.Character, "Scythe_Epic_Black")
		-- Cooldown Timer
		self.CooldownTimer.secondReached:Connect(function(seconds)
			Logger:Log("BasicMelee", `PE Cooldown: {seconds}`)
		end)
	end
	function BasicMelee:OnEndServer()
		Logger:Log("BasicMelee", "OnEndServer")
		task.delay(BasicMelee.SkillConfiguration.ActivationTime, function()
			ParticleGroupManager:DisableParticleEmitters(self.ActivationParticles)
			WeaponManager:UnEquipWCSCharacterWeapon(self.Character.Player, self.SkillWeapon)
		end)
	end
	BasicMelee.SkillConfiguration = {
		DisplayName = "Clean Basic",
		ImageId = "rbxassetid://132928610589911",
		ActivationAnimationId = "rbxassetid://77799116860007",
		ActivationSoundId = "rbxassetid://511715134",
		ActivationParticleGroup = "SwordHitEff2",
		ActivationTime = 0.8,
		DefaultHealthChange = 10,
		DefaultHoldTime = 0,
		DefaultCooldownTime = 0.5,
		DefaultManaCost = 10,
		DefaultStaminaCost = 10,
	}
	BasicMelee = SkillDecorator(BasicMelee) or BasicMelee
end
return {
	BasicMelee = BasicMelee,
}
