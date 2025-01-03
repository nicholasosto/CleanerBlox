-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local BaseGameCharacter = TS.import(script, game:GetService("ServerScriptService"), "TS", "GameCharacter", "BaseGameCharacter").BaseGameCharacter
local _GameAssetManagers = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "GameAssetManagers")
local GuiReferenceHandler = _GameAssetManagers.GuiReferenceHandler
local EventManager = _GameAssetManagers.EventManager
local EGUIElements = _GameAssetManagers.EGUIElements
local EScreenGuis = _GameAssetManagers.EScreenGuis
local DataManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "Data", "DataManager").DataManager
local AbilityButton = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "UI", "AbilityButton").AbilityButton
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
-- Skills
-- PlayerGameCharacter (Inherits from BaseGameCharacter)
local PlayerGameCharacter
do
	local super = BaseGameCharacter
	PlayerGameCharacter = setmetatable({}, {
		__tostring = function()
			return "PlayerGameCharacter"
		end,
		__index = super,
	})
	PlayerGameCharacter.__index = PlayerGameCharacter
	function PlayerGameCharacter.new(...)
		local self = setmetatable({}, PlayerGameCharacter)
		return self:constructor(...) or self
	end
	function PlayerGameCharacter:constructor(player)
		-- Get Character
		local character = player.Character or (player.CharacterAdded:Wait())
		if character == nil then
			Logger:Log(script, "PlayerGameCharacter: Character not found")
			error("PlayerGameCharacter: Character Model not found")
		end
		-- Super Constructor: BaseGameCharacter
		super.constructor(self, character)
		self._abilityButtons = {}
		-- Assign Player
		self._player = player
		-- DataCache
		self._dataCache = DataManager:GetDataCache(tostring(player.UserId))
		-- Assign GUI
		self._playerGui = player:WaitForChild("PlayerGui")
		-- HUD GUI
		self._hudGui = GuiReferenceHandler:getScreenGui(player, EScreenGuis.HUD)
		-- Action Bar
		self._actionBar = GuiReferenceHandler:getUIElement(player, EScreenGuis.HUD, EGUIElements.ActionBar)
		-- Character Frame
		self._characterFrame = GuiReferenceHandler:getUIElement(player, EScreenGuis.HUD, EGUIElements.CharacterFrame)
		Logger:Log(script, "PlayerGameCharacter Created: \n", self._characterFrame, " ", self._actionBar, " ", self._hudGui)
		local PlayerCharacterCreated = EventManager:GetEvent("PLAYER_CharacterCreated")
		PlayerCharacterCreated:FireClient(player)
		return self
	end
	function PlayerGameCharacter:createAbilityButton(skillName, slot)
		local skill = self.WCS_Character:GetSkillFromString(skillName)
		if skill == nil then
			Logger:Log(script.Name, "Skill not found")
		end
		local abilityButton = AbilityButton.new(self._actionBar, skill, slot)
		local __abilityButtons = self._abilityButtons
		local _skillName = skillName
		__abilityButtons[_skillName] = abilityButton
	end
	function PlayerGameCharacter:CreateMoveset()
		--this.WCS_Character.AddSkill(BasicMelee);
		--this.WCS_Character.AddSkill(BasicHold);
	end
	function PlayerGameCharacter:Destroy()
		super.Destroy(self)
	end
end
return {
	PlayerGameCharacter = PlayerGameCharacter,
}
