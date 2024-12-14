-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local ProgressBar = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "UI", "ProgressBar").ProgressBar
local _UIEnums = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "UI", "UIEnums")
local ColorGradients = _UIEnums.ColorGradients
local AttributeLabels = _UIEnums.AttributeLabels
local AbilityButtons = _UIEnums.AbilityButtons
local localPlayer = Players.LocalPlayer
local UIController
do
	UIController = setmetatable({}, {
		__tostring = function()
			return "UIController"
		end,
	})
	UIController.__index = UIController
	function UIController.new(...)
		local self = setmetatable({}, UIController)
		return self:constructor(...) or self
	end
	function UIController:constructor()
		-- Private Constructor
		-- Private Constructor
	end
	function UIController:Start()
		UIController:AddAttributeBars()
		UIController:AddAttributeLabels()
	end
	function UIController:AddAttributeBars()
		local _character = self._player.Character
		if self._player.Character then
			_character = self._player.Character
		else
			_character = (self._player.CharacterAdded:Wait())
		end
		if _character == nil then
			return nil
		end
		-- Health Bar
		local healthBar = ProgressBar.new(_character, "CurrentHealth", "MaxHealth", self._progressBarParent, "Health", ColorGradients.Rust)
		-- Mana Bar
		local manaBar = ProgressBar.new(_character, "CurrentMana", "MaxMana", self._progressBarParent, "Mana", ColorGradients.Mana)
		-- Stamina Bar
		local staminaBar = ProgressBar.new(_character, "CurrentStamina", "MaxStamina", self._progressBarParent, "Stamina", ColorGradients.Stamina)
		-- Experience Bar
		local experienceBar = ProgressBar.new(self._player, "Experience", "ExperienceToNextLevel", self._progressBarParent, "Experience", ColorGradients.Experience)
	end
	function UIController:AddAttributeLabels()
		local character = self._player.Character
		AttributeLabels.Strength:create(self._attributeLabelParent, character)
		AttributeLabels.Speed:create(self._attributeLabelParent, character)
		AttributeLabels.Dexterity:create(self._attributeLabelParent, character)
		AttributeLabels.Intelligence:create(self._attributeLabelParent, character)
		AttributeLabels.Constitution:create(self._attributeLabelParent, character)
		AttributeLabels.Level:create(self._attributeLabelParent, character)
		AttributeLabels.Experience:create(self._attributeLabelParent, character)
		AttributeLabels.ExperienceToNextLevel:create(self._attributeLabelParent, character)
		AttributeLabels.MaxHealth:create(self._attributeLabelParent, character)
		AttributeLabels.MaxMana:create(self._attributeLabelParent, character)
		AttributeLabels.MaxStamina:create(self._attributeLabelParent, character)
	end
	function UIController:LoadActionBar()
		local ActionBarCells = {}
		local Cell_01 = self._actionBarGui:FindFirstChild("Cell-01", true)
		local Cell_02 = self._actionBarGui:FindFirstChild("Cell-02", true)
		local Cell_03 = self._actionBarGui:FindFirstChild("Cell-03", true)
		local Cell_04 = self._actionBarGui:FindFirstChild("Cell-04", true)
		local Cell_05 = self._actionBarGui:FindFirstChild("Cell-05", true)
		table.insert(ActionBarCells, Cell_01)
		table.insert(ActionBarCells, Cell_02)
		table.insert(ActionBarCells, Cell_03)
		table.insert(ActionBarCells, Cell_04)
		table.insert(ActionBarCells, Cell_05)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(cell)
			local newCell = Instance.new("Frame")
			newCell.Size = UDim2.new(2.2, 0, 2, 0)
			newCell.Position = UDim2.new(0, 0, 0, 0)
			newCell.BackgroundColor3 = Color3.new(0, 0, 0)
			newCell.Name = "Dummy"
			newCell.Parent = cell
		end
		for _k, _v in ActionBarCells do
			_callback(_v, _k - 1, ActionBarCells)
		end
		-- ▲ ReadonlyArray.forEach ▲
		AbilityButtons.Spotlights:create(Cell_03)
	end
	UIController._player = localPlayer
	UIController._playerGui = UIController._player:WaitForChild("PlayerGui")
	UIController._progressBarGui = UIController._playerGui:WaitForChild("Bars")
	UIController._progressBarParent = UIController._progressBarGui:WaitForChild("ParentFrame")
	UIController._attributeLabelGui = UIController._playerGui:WaitForChild("Attributes")
	UIController._attributeLabelParent = UIController._attributeLabelGui:WaitForChild("MasterFrame"):WaitForChild("ParentFrame")
	UIController._actionBarGui = UIController._playerGui:WaitForChild("Action Bar")
end
return {
	UIController = UIController,
}
