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
local BasicRanged
do
	local super = Skill
	BasicRanged = setmetatable({}, {
		__tostring = function()
			return "BasicRanged"
		end,
		__index = super,
	})
	BasicRanged.__index = BasicRanged
	function BasicRanged.new(...)
		local self = setmetatable({}, BasicRanged)
		return self:constructor(...) or self
	end
	function BasicRanged:constructor(...)
		super.constructor(self, ...)
	end
	function BasicRanged:OnConstruct()
		--Logger.Log(script,"BasicRanged", "OnConstruct");
	end
	function BasicRanged:OnConstructServer()
		local character = self.Character.Instance
		if character == nil then
			Logger:Log(script, "BasicRanged no character found")
			return nil
		end
		self.DamageContainer = self:CreateDamageContainer(BasicRanged.SkillConfiguration.DefaultHealthChange)
		-- Load Sound
		-- eslint-disable-next-line prettier/prettier
		self.ActivationSound = AudioManager:LoadWCSSound(self.Character, "BasicRanged_ActivationAudio", BasicRanged.SkillConfiguration.ActivationSoundId)
		-- Load Animation
		-- eslint-disable-next-line prettier/prettier
		self.ActivationAnimationTrack = AnimationManager:LoadWCSCharacterAnimation(self.Character, "BasicRanged_ActivationAnimation", BasicRanged.SkillConfiguration.ActivationAnimationId, BasicRanged.SkillConfiguration.ActivationTime)
		-- Load Particles
		-- eslint-disable-next-line prettier/prettier
		self.ActivationParticles = ParticleGroupManager:GetParticleGroup(BasicRanged.SkillConfiguration.ActivationParticleGroup)
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
			--Logger.Log(script,"BasicRanged", "No Hit Part Found");
			return nil
		end
		local _result_1 = self.HitPartConnection
		if _result_1 ~= nil then
			_result_1:Disconnect()
		end
		self.HitPartConnection = self.SkillHitPart.Touched:Connect(function(hit)
			--Logger.Log(script,"BasicRanged", `Hit: ${hit.Parent?.Name}`);
			if hit.Parent == self.Character.Instance then
				--Logger.Log(script,"BasicRanged", "Hit Self");
				return nil
			end
			local _result_2 = hit.Parent
			if _result_2 ~= nil then
				_result_2 = _result_2:FindFirstChild("Humanoid")
			end
			if _result_2 == nil then
				--Logger.Log(script,"BasicRanged", "No Humanoid Found");
				return nil
			end
			local targetCharacter = Character.GetCharacterFromInstance(hit.Parent)
			if targetCharacter == nil then
				local _result_3 = hit.Parent
				if _result_3 ~= nil then
					_result_3 = _result_3.Parent
				end
				targetCharacter = Character.GetCharacterFromInstance(_result_3)
				--Logger.Log(script,"BasicRanged", "No Target Character Found");
				local _result_4 = targetCharacter
				if _result_4 ~= nil then
					_result_4:TakeDamage(self.DamageContainer)
				end
			end
			--hit.Parent = undefined;
		end)
		--ParticleGroupManager.DisableParticleEmitters(this.ActivationParticles as [ParticleEmitter]);
		--Logger.Log(script,"BasicRanged", "Animation, Sound, and Particles Loaded");
	end
	function BasicRanged:OnConstructClient()
		--Logger.Log(script,"BasicRanged Client");
	end
	function BasicRanged:OnStartServer()
		self:ApplyCooldown(BasicRanged.SkillConfiguration.DefaultCooldownTime)
		self.Character:TakeDamage(self:CreateDamageContainer(10))
		local _result = self.ActivationSound
		if _result ~= nil then
			_result:Play()
		end
		AnimationManager:PlayAnimation(self.ActivationAnimationTrack, BasicRanged.SkillConfiguration.ActivationTime)
		--this.ActivationAnimationTrack?.Play();
		ParticleGroupManager:EnableParticleEmitters(self.ActivationParticles)
		WeaponManager:EquipWCSCharacterWeapon(self.Character, "Scythe_Epic_Black")
		-- Cooldown Timer
		self.CooldownTimer.secondReached:Connect(function(seconds)
			--Logger.Log(script,"BasicRanged", `PE Cooldown: ${seconds}`);
		end)
	end
	function BasicRanged:OnEndServer()
		--Logger.Log(script,"BasicRanged", "OnEndServer");
		task.delay(BasicRanged.SkillConfiguration.ActivationTime, function()
			ParticleGroupManager:DisableParticleEmitters(self.ActivationParticles)
			WeaponManager:UnEquipWCSCharacterWeapon(self.Character.Player, self.SkillWeapon)
		end)
	end
	BasicRanged.SkillConfiguration = {
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
	BasicRanged = SkillDecorator(BasicRanged) or BasicRanged
end
return {
	BasicRanged = BasicRanged,
}
