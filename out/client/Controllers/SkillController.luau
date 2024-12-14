-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local ReplicatedStorage = _services.ReplicatedStorage
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
-- Events
local event_SkillSlotRequest = ReplicatedStorage:FindFirstChild("SKILL_GetSlots", true)
local event_SkillInventoryRequest = ReplicatedStorage:FindFirstChild("SKILL_GetInventory", true)
local event_AssignSlotRequest = ReplicatedStorage:FindFirstChild("SKILL_AssignSlot", true)
local AbilityButton
do
	AbilityButton = setmetatable({}, {
		__tostring = function()
			return "AbilityButton"
		end,
	})
	AbilityButton.__index = AbilityButton
	function AbilityButton.new(...)
		local self = setmetatable({}, AbilityButton)
		return self:constructor(...) or self
	end
	function AbilityButton:constructor(button, skillId)
		self._button = button
		self._skillId = skillId
		self._buttonConnection = button.MouseButton1Down:Connect(function()
			local character = Character.GetLocalCharacter()
			local _wcsSkill = character
			if _wcsSkill ~= nil then
				local _exp = _wcsSkill:GetSkills()
				-- ▼ ReadonlyArray.find ▼
				local _callback = function(skill)
					return skill:GetName() == self._skillId
				end
				local _result
				for _i, _v in _exp do
					if _callback(_v, _i - 1, _exp) == true then
						_result = _v
						break
					end
				end
				-- ▲ ReadonlyArray.find ▲
				_wcsSkill = _result
			end
			local wcsSkill = _wcsSkill
			if wcsSkill == nil then
				Logger:Log("AbilityButton", "wcsSkill: ", self._skillId, " is undefined")
				return nil
			end
			wcsSkill:Start()
		end)
		self._button.MouseButton1Up:Connect(function()
			local character = Character.GetLocalCharacter()
			local _wcsSkill = character
			if _wcsSkill ~= nil then
				local _exp = _wcsSkill:GetSkills()
				-- ▼ ReadonlyArray.find ▼
				local _callback = function(skill)
					return skill:GetName() == self._skillId
				end
				local _result
				for _i, _v in _exp do
					if _callback(_v, _i - 1, _exp) == true then
						_result = _v
						break
					end
				end
				-- ▲ ReadonlyArray.find ▲
				_wcsSkill = _result
			end
			local wcsSkill = _wcsSkill
			if wcsSkill == nil then
				Logger:Log("AbilityButton", "wcsSkill: ", self._skillId, " is undefined")
				return nil
			end
			wcsSkill:Stop()
		end)
		return self
	end
end
local SkillController
do
	SkillController = setmetatable({}, {
		__tostring = function()
			return "SkillController"
		end,
	})
	SkillController.__index = SkillController
	function SkillController.new(...)
		local self = setmetatable({}, SkillController)
		return self:constructor(...) or self
	end
	function SkillController:constructor()
	end
	function SkillController:Start()
		Logger:Log("C_SkillManager", "Started")
	end
	function SkillController:LoadSlot(slotName, skillId)
		local _exp = self._slotFrames
		-- ▼ ReadonlyArray.find ▼
		local _callback = function(frame)
			return frame.Name == slotName
		end
		local _result
		for _i, _v in _exp do
			if _callback(_v, _i - 1, _exp) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local slotFrame = _result
		if slotFrame == nil then
			return nil
		end
		local contentFrame = slotFrame:FindFirstChild("Content", true)
		if contentFrame == nil then
			return nil
		end
		local testButton = Instance.new("TextButton")
		testButton.Size = UDim2.new(1, 0, 1, 0)
		testButton.Text = skillId
		testButton.Parent = contentFrame
		AbilityButton.new(testButton, skillId)
		event_SkillInventoryRequest:FireServer(Players.LocalPlayer)
	end
	SkillController._slotsFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Action Bar"):FindFirstChild("ActionBarSlots", true)
	local _exp = SkillController._slotsFrame:GetChildren()
	-- ▼ ReadonlyArray.filter ▼
	local _newValue = {}
	local _callback = function(child)
		return child:IsA("Frame")
	end
	local _length = 0
	for _k, _v in _exp do
		if _callback(_v, _k - 1, _exp) == true then
			_length += 1
			_newValue[_length] = _v
		end
	end
	-- ▲ ReadonlyArray.filter ▲
	SkillController._slotFrames = _newValue
	SkillController._skillsInventoryScrollingFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("SkillInventoryScroller", true)
	SkillController._connectionGetSkillSlots = event_SkillSlotRequest.OnClientEvent:Connect(function(data)
		-- eslint-disable-next-line prettier/prettier
		local SkillSlotFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("ActionBarSlots", true)
		if SkillSlotFrame == nil then
			return nil
		end
		SkillController:LoadSlot("Slot_1", data.Slot_1)
		SkillController:LoadSlot("Slot_2", data.Slot_2)
		SkillController:LoadSlot("Slot_3", data.Slot_3)
		SkillController:LoadSlot("Slot_4", data.Slot_4)
		SkillController:LoadSlot("Slot_5", data.Slot_5)
	end)
	SkillController._connectionGetSkillInventory = event_SkillInventoryRequest.OnClientEvent:Connect(function(data)
		local _exp_1 = SkillController._skillsInventoryScrollingFrame:GetChildren()
		-- ▼ ReadonlyArray.filter ▼
		local _newValue_1 = {}
		local _callback_1 = function(child)
			return child:IsA("TextButton")
		end
		local _length_1 = 0
		for _k, _v in _exp_1 do
			if _callback_1(_v, _k - 1, _exp_1) == true then
				_length_1 += 1
				_newValue_1[_length_1] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_2 = function(child)
			return child:Destroy()
		end
		for _k, _v in _newValue_1 do
			_callback_2(_v, _k - 1, _newValue_1)
		end
		-- ▲ ReadonlyArray.forEach ▲
		-- ▼ ReadonlyArray.forEach ▼
		local _callback_3 = function(skillId)
			local skillButton = Instance.new("TextButton")
			skillButton.Size = UDim2.new(1, 0, 0, 50)
			skillButton.Text = skillId
			skillButton.Parent = SkillController._skillsInventoryScrollingFrame
			AbilityButton.new(skillButton, skillId)
		end
		for _k, _v in data do
			_callback_3(_v, _k - 1, data)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end)
end
return {
	SkillController = SkillController,
}
