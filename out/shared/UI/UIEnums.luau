-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local AttributeLabel = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "UI", "AttributeLabel").AttributeLabel
local ColorGradients = {
	Rust = ColorSequence.new(Color3.new(0.6, 0.2, 0.2), Color3.new(0.8, 0.4, 0.4)),
	Blue = ColorSequence.new(Color3.new(0.2, 0.2, 0.6), Color3.new(0.4, 0.4, 0.8)),
	Mana = ColorSequence.new(Color3.new(0.2, 0.6, 0.6), Color3.new(0.4, 0.8, 0.8)),
	Stamina = ColorSequence.new(Color3.new(0.6, 0.6, 0.2), Color3.new(0.8, 0.8, 0.4)),
	Experience = ColorSequence.new(Color3.new(0.6, 0.2, 0.6), Color3.new(0.8, 0.4, 0.8)),
	Modern = ColorSequence.new(Color3.new(0.2, 0.6, 0.2), Color3.new(0.4, 0.8, 0.4)),
	Snazzy = ColorSequence.new(Color3.new(0.6, 0.6, 0.6), Color3.new(0.8, 0.8, 0.8)),
}
local AttributeLabels = {
	Strength = AttributeLabel.new("Str:", "Strength"),
	Speed = AttributeLabel.new("Spd:", "Speed"),
	Dexterity = AttributeLabel.new("Dex:", "Dexterity"),
	Intelligence = AttributeLabel.new("Int:", "Intelligence"),
	Constitution = AttributeLabel.new("Con:", "Constitution"),
	Level = AttributeLabel.new("Lvl:", "Level"),
	Experience = AttributeLabel.new("Exp:", "Experience"),
	ExperienceToNextLevel = AttributeLabel.new("ExpTNL:", "ExperienceToNextLevel"),
	MaxHealth = AttributeLabel.new("MaxHP:", "MaxHealth"),
	MaxMana = AttributeLabel.new("MaxMP:", "MaxMana"),
	MaxStamina = AttributeLabel.new("MaxSP:", "MaxStamina"),
}
local ToggleButtons = {
	Todo = "Implement Toggle Buttons",
}
local Inventory = {
	Todo = "Implement Inventory",
}
return {
	ColorGradients = ColorGradients,
	AttributeLabels = AttributeLabels,
	ToggleButtons = ToggleButtons,
	Inventory = Inventory,
}
