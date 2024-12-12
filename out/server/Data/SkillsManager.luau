-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
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
		self._dataCache = dataCache
		Logger:Log("SkillSlotManager", "Skills\n\n", self._dataCache._playerData.Skills.Slot_1, self._dataCache._playerData.Skills.Slot_2, self._dataCache._playerData.Skills.Slot_3, self._dataCache._playerData.Skills.Slot_4, "\n\n")
		self._dataCache:Save()
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
	end
	function SkillsManager:GetSkillSlots()
		return self._dataCache._playerData.Skills
	end
end
return {
	SkillsManager = SkillsManager,
}
