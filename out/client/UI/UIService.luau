-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local ProgressBar = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "UI", "ProgressBar").ProgressBar
local _UIEnums = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "UI", "UIEnums")
local ColorGradients = _UIEnums.ColorGradients
local AttributeLabels = _UIEnums.AttributeLabels
local AbilityButtons = _UIEnums.AbilityButtons
local localPlayer = Players.LocalPlayer
local UIService
do
	UIService = setmetatable({}, {
		__tostring = function()
			return "UIService"
		end,
	})
	UIService.__index = UIService
	function UIService.new(...)
		local self = setmetatable({}, UIService)
		return self:constructor(...) or self
	end
	function UIService:constructor()
		-- Private Constructor
		-- Private Constructor
	end
	function UIService:Start()
		print("Starting UI Service")
		print(" ** Creating Attribute Bars **")
		UIService:AddAttributeBars()
		print(" ** Createing Attribute Labels **")
		UIService:AddAttributeLabels()
		print(" ** Loading Toggle Buttons **")
	end
	function UIService:AddAttributeBars()
		print("** Creating Progress Bars **")
		-- Health Bar
		local healthBar = ProgressBar.new(self._player, "CurrentHealth", "MaxHealth", self._progressBarParent, "Health", ColorGradients.Rust)
		-- Mana Bar
		local manaBar = ProgressBar.new(self._player, "CurrentMana", "MaxMana", self._progressBarParent, "Mana", ColorGradients.Mana)
		-- Stamina Bar
		local staminaBar = ProgressBar.new(self._player, "CurrentStamina", "MaxStamina", self._progressBarParent, "Stamina", ColorGradients.Stamina)
		-- Experience Bar
		local experienceBar = ProgressBar.new(self._player, "Experience", "ExperienceToNextLevel", self._progressBarParent, "Experience", ColorGradients.Experience)
		print("** Progress Bars Created **")
	end
	function UIService:AddAttributeLabels()
		AttributeLabels.Strength:create(self._attributeLabelParent, self._player)
		AttributeLabels.Speed:create(self._attributeLabelParent, self._player)
		AttributeLabels.Dexterity:create(self._attributeLabelParent, self._player)
		AttributeLabels.Intelligence:create(self._attributeLabelParent, self._player)
		AttributeLabels.Constitution:create(self._attributeLabelParent, self._player)
		AttributeLabels.Level:create(self._attributeLabelParent, self._player)
		AttributeLabels.Experience:create(self._attributeLabelParent, self._player)
		AttributeLabels.ExperienceToNextLevel:create(self._attributeLabelParent, self._player)
		AttributeLabels.MaxHealth:create(self._attributeLabelParent, self._player)
		AttributeLabels.MaxMana:create(self._attributeLabelParent, self._player)
		AttributeLabels.MaxStamina:create(self._attributeLabelParent, self._player)
	end
	function UIService:LoadActionBar()
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
		print("Loading Action Bar")
	end
	UIService._player = localPlayer
	UIService._playerGui = UIService._player:WaitForChild("PlayerGui")
	UIService._progressBarGui = UIService._playerGui:WaitForChild("Bars")
	UIService._progressBarParent = UIService._progressBarGui:WaitForChild("ParentFrame")
	UIService._attributeLabelGui = UIService._playerGui:WaitForChild("Attributes")
	UIService._attributeLabelParent = UIService._attributeLabelGui:WaitForChild("MasterFrame"):WaitForChild("ParentFrame")
	UIService._actionBarGui = UIService._playerGui:WaitForChild("Action Bar")
end
return {
	UIService = UIService,
}
