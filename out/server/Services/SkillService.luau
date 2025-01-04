-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
-- Remote Events
-- Requests
local SKILLS_SkillSlotRequest = GameStorage:getEvent("SKILL_SkillSlotRequest")
local SKILLS_ClearSlotRequest = GameStorage:getEvent("SKILL_ClearSlotRequest")
local SKILL_AssignSlotRequest = GameStorage:getEvent("SKILL_AssignSlotRequest")
-- Responses
local SKILLS_SkillSlotResponse = GameStorage:getEvent("SKILL_SkillSlotResponse")
local SKILLS_ClearSlotResponse = GameStorage:getEvent("SKILL_ClearSlotResponse")
local SKILLS_AssignSlotResponse = GameStorage:getEvent("SKILL_AssignSlotResponse")
-- Skills Manager
local SkillService
do
	SkillService = setmetatable({}, {
		__tostring = function()
			return "SkillService"
		end,
	})
	SkillService.__index = SkillService
	function SkillService.new(...)
		local self = setmetatable({}, SkillService)
		return self:constructor(...) or self
	end
	function SkillService:constructor()
		SkillService:ClearConnections()
		-- Skill Slot Request Listener
		SkillService._connectionSkillSlotsRequest = SKILLS_SkillSlotRequest.OnServerEvent:Connect(function(player)
			Logger:Log(script, "SkillService", "Skill Slot Requested")
			local userId = tostring(player.UserId)
			local playerData = DataManager:GetDataCache(userId)._playerData
			SKILLS_SkillSlotResponse:FireClient(player, playerData.SkillSlots)
		end)
		-- Clear Slot Request Listener
		SkillService._connectionClearSlotRequest = SKILLS_ClearSlotRequest.OnServerEvent:Connect(function(player, ...)
			local args = { ... }
			local SlotId = args[1]
			print("Getting player data", args)
		end)
		return self
	end
	function SkillService:ClearConnections()
		local _result = SkillService._connectionSkillSlotsRequest
		if _result ~= nil then
			_result:Disconnect()
		end
		local _result_1 = SkillService._connectionClearSlotRequest
		if _result_1 ~= nil then
			_result_1:Disconnect()
		end
		local _result_2 = SkillService._connectionAssignSlotRequest
		if _result_2 ~= nil then
			_result_2:Disconnect()
		end
	end
	function SkillService:Start()
		if SkillService._instance == nil then
			SkillService._instance = SkillService.new()
		else
			Logger:Log(script, "SkillService", "Already started")
		end
	end
	function SkillService:AssignSkills(player, skills)
		local userId = tostring(player.UserId)
		local playerData = DataManager:GetDataCache(userId)._playerData
		local playerSkills = playerData.SkillSlots
	end
	function SkillService:ClearSlot(player, slotId)
		local response = {
			success = true,
			message = "Skill Slot Cleared",
		}
		return response
	end
end
return {
	SkillService = SkillService,
}
