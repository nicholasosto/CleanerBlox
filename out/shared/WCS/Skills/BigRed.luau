-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local HoldableSkill = _wcs.HoldableSkill
local SkillDecorator = _wcs.SkillDecorator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local BigRed
do
	local super = HoldableSkill
	BigRed = setmetatable({}, {
		__tostring = function()
			return "BigRed"
		end,
		__index = super,
	})
	BigRed.__index = BigRed
	function BigRed.new(...)
		local self = setmetatable({}, BigRed)
		return self:constructor(...) or self
	end
	function BigRed:constructor(...)
		super.constructor(self, ...)
		self.ChargingEffectAttachment = GameStorage:cloneParticleGroupAttachment("RedCasting")
		self._defaultHoldTime = 5
		self._defaultCooldownTime = 3
	end
	function BigRed:OnConstructServer()
		-- Set Max Hold Time
		Logger:Log(self:GetName(), " - Constructed\n")
	end
	function BigRed:OnStartServer()
		self:ApplyCooldown(self._defaultCooldownTime)
		self:SetMaxHoldTime(self._defaultHoldTime)
		Logger:Log(self:GetName(), " - Skill Started\n")
		self.HoldTimer.secondReached:Connect(function(seconds)
			return self:stageActivated(seconds)
		end)
	end
	function BigRed:stageActivated(seconds)
		Logger:Log(self:GetName(), "\n--------  Stage Activated Server  --------\n")
		local _result = self.Character.Instance
		if _result ~= nil then
			_result = _result:FindFirstChild("Head")
		end
		local particleParent = _result
		self.ChargingEffectAttachment.Parent = particleParent
		Logger:Log(script, "BigRed", "Stage Activated: ", tostring(seconds), tostring(self.CooldownTimer:getTimeLeft()))
		repeat
			if seconds == 1 then
				self:Stage3()
				break
			end
			if seconds == 2 then
				self:Stage2()
				break
			end
			if seconds == 3 then
				self:Stage1()
				break
			end
			break
		until true
	end
	function BigRed:Stage1()
		Logger:Log(self:GetName(), " - Stage 01 called\n")
		local _exp = self.ChargingEffectAttachment:GetChildren()
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
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(emitter)
			emitter.Enabled = true
		end
		for _k, _v in _newValue do
			_callback_1(_v, _k - 1, _newValue)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function BigRed:Stage2()
		Logger:Log(self:GetName(), " - Stage 02 called\n")
		local _exp = self.ChargingEffectAttachment:GetChildren()
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
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(emitter)
			emitter.TimeScale = emitter.TimeScale * 2
		end
		for _k, _v in _newValue do
			_callback_1(_v, _k - 1, _newValue)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function BigRed:Stage3()
		Logger:Log(self:GetName(), " - Stage 03 called\n")
		Logger:Log(self:GetName(), " - Stage 02 called\n")
		local _exp = self.ChargingEffectAttachment:GetChildren()
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
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_1 = function(emitter)
			emitter.TimeScale = emitter.TimeScale * 2
		end
		for _k, _v in _newValue do
			_callback_1(_v, _k - 1, _newValue)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function BigRed:OnEndServer()
		Logger:Log(self:GetName(), "\n--------  Stage Activated Server  --------\n")
		local _result = self.ChargingEffectAttachment
		if _result ~= nil then
			local _exp = _result:GetChildren()
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
			-- ▼ ReadonlyArray.forEach ▼
			local _callback_1 = function(emitter)
				emitter.Enabled = false
			end
			for _k, _v in _newValue do
				_callback_1(_v, _k - 1, _newValue)
			end
			-- ▲ ReadonlyArray.forEach ▲
		end
	end
	BigRed = SkillDecorator(BigRed) or BigRed
end
return {
	BigRed = BigRed,
}
