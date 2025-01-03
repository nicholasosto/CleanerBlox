-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Purpose: Reference file for all game related classes and enums.
-- Imports
local _Animations = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Animation", "Animations")
local EAnimations = _Animations.EAnimations
local CharacterAnimations = _Animations.CharacterAnimations
local _Skills = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Skills", "Skills")
local ESkillName = _Skills.ESkillName
local SkillConfigurations = _Skills.SkillConfigurations
local AnimationHelper = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Animation", "AnimationHelper").AnimationHelper
-- Class Exports
return {
	EAnimations = EAnimations,
	CharacterAnimations = CharacterAnimations,
	AnimationHelper = AnimationHelper,
	ESkillNames = ESkillName,
	SkillConfigurations = SkillConfigurations,
}
