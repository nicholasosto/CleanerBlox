-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local InventoryReference = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Refrences", "InventoryReference")
-- [[[[[[  Notifications ]]]]]] 
-- [[[[[[  Event Names ]]]]]] 
-- SKILL Events
local ESkillEvent = {
	SkillSlotRequest = "SKILL_SkillSlotRequest",
	ClearSlotRequest = "SKILL_ClearSlotRequest",
	AssignSlotRequest = "SKILL_AssignSlotRequest",
	SkillSlotResponse = "SKILL_SkillSlotResponse",
	ClearSlotResponse = "SKILL_ClearSlotResponse",
	AssignSlotResponse = "SKILL_AssignSlotResponse",
}
local EStatEvent = {
	IncreaseStatRequest = "STAT_IncreaseStatRequest",
	IncreaseStatResponse = "STAT_IncreaseStatResponse",
}
-- [[[[[[  Player Data ]]]]]] 
-- Skill Slot
-- Equipment Slot
-- Currency Type
-- Character Class
-- Core Stats
-- Player Data Interface
return {
	InventoryReference = InventoryReference,
	ESkillEvent = ESkillEvent,
	EStatEvent = EStatEvent,
}
