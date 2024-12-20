-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
-- Events
-- Requests
local SKILLS_SkillSlotRequest = GameStorage:getEvent("SKILL_SkillSlotRequest")
local SKILLS_ClearSlotRequest = GameStorage:getEvent("SKILL_ClearSlotRequest")
local SKILL_AssignSlotRequest = GameStorage:getEvent("SKILL_AssignSlotRequest")
-- Responses
local SKILLS_SkillSlotResponse = GameStorage:getEvent("SKILL_SkillSlotResponse")
local SKILLS_ClearSlotResponse = GameStorage:getEvent("SKILL_ClearSlotResponse")
local SKILLS_AssignSlotResponse = GameStorage:getEvent("SKILL_AssignSlotResponse")
local ClientSkillService
do
	ClientSkillService = setmetatable({}, {
		__tostring = function()
			return "ClientSkillService"
		end,
	})
	ClientSkillService.__index = ClientSkillService
	function ClientSkillService.new(...)
		local self = setmetatable({}, ClientSkillService)
		return self:constructor(...) or self
	end
	function ClientSkillService:constructor()
		-- Equip Response
		ClientSkillService._connectionSkillSlotsResponse = SKILLS_SkillSlotResponse.OnClientEvent:Connect(function(response)
			print("Equip Response", response)
		end)
		-- Unequip Response
		ClientSkillService._connectionClearSlotResponse = SKILLS_ClearSlotResponse.OnClientEvent:Connect(function(response)
			print("Unequip Response", response)
		end)
		-- Assign Slot Response
		ClientSkillService._connectionAssignSlotResponse = SKILLS_AssignSlotResponse.OnClientEvent:Connect(function(response)
			print("Assign Slot Response", response)
		end)
		return self
	end
	function ClientSkillService:Start()
		if ClientSkillService._instance == nil then
			ClientSkillService._instance = ClientSkillService.new()
		else
			print("ClientSkillService Already Started")
		end
	end
	function ClientSkillService:AssignSlotRequest(slotId, skillId)
		SKILL_AssignSlotRequest:FireServer(slotId, skillId)
	end
	function ClientSkillService:ClearSlotRequest(slotId)
		SKILLS_ClearSlotRequest:FireServer(slotId)
	end
	function ClientSkillService:GetSlotsRequest()
		SKILLS_SkillSlotRequest:FireServer()
	end
end
return {
	ClientSkillService = ClientSkillService,
}
