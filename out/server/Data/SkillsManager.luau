-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").ReplicatedStorage
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local SKILL_GetSlots = ReplicatedStorage:FindFirstChild("SKILL_GetSlots", true)
local SKILL_GetInventory = ReplicatedStorage:FindFirstChild("SKILL_GetInventory", true)
local SKILL_AssignSlot = ReplicatedStorage:FindFirstChild("SKILL_AssignSlot", true)
-- Skills Manager
local SkillsManager
do
	SkillsManager = setmetatable({}, {
		__tostring = function()
			return "SkillsManager"
		end,
	})
	SkillsManager.__index = SkillsManager
	function SkillsManager.new(...)
		local self = setmetatable({}, SkillsManager)
		return self:constructor(...) or self
	end
	function SkillsManager:constructor(dataCache)
		self._connectionGetSkillSlots = SKILL_GetSlots.OnServerEvent:Connect(function(player)
			local playerId = tostring(player.UserId)
			if playerId ~= self._dataCache._userId then
				return nil
			end
			Logger:Log("SkillsManagerX", "GetSkillSlots", self:GetSkillSlots())
			SKILL_GetSlots:FireClient(player, self:GetSkillSlots())
		end)
		self._connectionGetSkillInventory = SKILL_GetInventory.OnServerEvent:Connect(function(player)
			local playerId = tostring(player.UserId)
			if playerId ~= self._dataCache._userId then
				return nil
			end
			SKILL_GetInventory:FireClient(player, self._dataCache._playerData.SkillInventory)
			Logger:Log("SkillsManagerX", "GetSkillInventory", self._dataCache._playerData.SkillInventory)
		end)
		self._connectionAssignSlot = SKILL_AssignSlot.OnServerEvent:Connect(function(player, ...)
			local args = { ... }
			local playerId = tostring(player.UserId)
			if playerId ~= self._dataCache._userId then
				return nil
			end
			local slotNumber = args[1]
			local skillId = args[2]
			if slotNumber == nil or skillId == nil then
				return nil
			end
			if slotNumber < 1 or slotNumber > 5 then
				return nil
			end
			if not self:ValidateSkill(skillId) then
				return nil
			end
			Logger:Log("SkillsManagerX", "AssignSlot", slotNumber, skillId)
			self:SetSkillSlot(args[1], args[2])
		end)
		self._dataCache = dataCache
		Logger:Log("SkillSlotManager", "Skills\n\n", self._dataCache._playerData.Skills.Slot_1, self._dataCache._playerData.Skills.Slot_2, self._dataCache._playerData.Skills.Slot_3, self._dataCache._playerData.Skills.Slot_4, "\n\n")
		self._dataCache:Save()
	end
	function SkillsManager:ValidateSkill(skillId)
		local playersSkills = self._dataCache._playerData.SkillInventory
		-- ▼ ReadonlyArray.find ▼
		local _callback = function(skill)
			return skill == skillId
		end
		local _result
		for _i, _v in playersSkills do
			if _callback(_v, _i - 1, playersSkills) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		return _result ~= nil
	end
	function SkillsManager:SetSkillSlot(slot, skillId)
		local playersSkills = self._dataCache._playerData.SkillInventory
		-- ▼ ReadonlyArray.find ▼
		local _callback = function(skill)
			return skill == skillId
		end
		local _result
		for _i, _v in playersSkills do
			if _callback(_v, _i - 1, playersSkills) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local matchingSkill = _result
		if matchingSkill == nil then
			Logger:Log("SkillSlotManager", "Skill not found in player's inventory", skillId)
			return nil
		end
		repeat
			if slot == 1 then
				self._dataCache._playerData.Skills.Slot_1 = skillId
				break
			end
			if slot == 2 then
				self._dataCache._playerData.Skills.Slot_2 = skillId
				break
			end
			if slot == 3 then
				self._dataCache._playerData.Skills.Slot_3 = skillId
				break
			end
			if slot == 4 then
				self._dataCache._playerData.Skills.Slot_4 = skillId
				break
			end
			if slot == 5 then
				self._dataCache._playerData.Skills.Slot_5 = skillId
				break
			end
			break
		until true
		self._dataCache:Save()
	end
	function SkillsManager:GetSkillSlots()
		return self._dataCache._playerData.Skills
	end
end
return {
	SkillsManager = SkillsManager,
}
