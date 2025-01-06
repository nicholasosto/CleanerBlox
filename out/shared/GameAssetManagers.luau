-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local InsertService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").InsertService
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
-- Package IDs
local EPackageIDs
do
	local _inverse = {}
	EPackageIDs = setmetatable({}, {
		__index = _inverse,
	})
	EPackageIDs.Environment = 16178566269
	_inverse[16178566269] = "Environment"
	EPackageIDs.Effects = 16593023479
	_inverse[16593023479] = "Effects"
	EPackageIDs.Audio = 16412665714
	_inverse[16412665714] = "Audio"
	EPackageIDs.NPC = 16034962856
	_inverse[16034962856] = "NPC"
	EPackageIDs.GameStorage = 106038395934214
	_inverse[106038395934214] = "GameStorage"
	EPackageIDs.Weapons = 16226642685
	_inverse[16226642685] = "Weapons"
	EPackageIDs.UITemplates = 102507696180343
	_inverse[102507696180343] = "UITemplates"
end
-- GUI Templates
local EGuiTemplates = {
	AbilityButton = "AbilityButton_Template",
	AttributeLabel = "AttributeLabel_Template",
	CharacterFrame = "CharacterFrame_Template",
	InventoryPanel = "InventoryPanel_Template",
}
-- Aura Names
local EAuraNames = {
	TimeAura = "TimeAura",
	FireAura = "FireAura",
	WaterAura = "WaterAura",
}
local EScreenGuis = {
	HUD = "HUD",
	Developer = "Developer",
	MainGui = "MainGui",
}
local EGUIElements = {
	ActionBar = "ActionBarMain",
	CharacterFrame = "CharacterFrame",
}
-- Package Manager
local PackageManager
do
	PackageManager = setmetatable({}, {
		__tostring = function()
			return "PackageManager"
		end,
	})
	PackageManager.__index = PackageManager
	function PackageManager.new(...)
		local self = setmetatable({}, PackageManager)
		return self:constructor(...) or self
	end
	function PackageManager:constructor()
	end
	function PackageManager:LoadPackage(packageID)
		local packageContainer = InsertService:LoadAsset(packageID)
		if packageContainer == nil then
			Logger:Log(script.Name, "Failed to load package with ID: ", packageID)
		end
		return packageContainer
	end
	function PackageManager:LoadGuiTemplate(guiTemplate)
		if game:GetService("RunService"):IsServer() then
			Logger:Log(script.Name, "Cannot load GUI template on the server")
			return nil
		end
		local guiTemplateInstance = InsertService:LoadAsset(EPackageIDs.UITemplates):FindFirstChild(guiTemplate, true)
		if guiTemplateInstance == nil then
			Logger:Log(script.Name, "Failed to load GUI template with name: ", guiTemplate)
		end
		return guiTemplateInstance
	end
	function PackageManager:GetGuiTemplate(guiTemplate)
		local packageFolder = game:GetService("ReplicatedStorage"):WaitForChild("Asset Package - UI Templates")
		local guiTemplateInstance = packageFolder:FindFirstChild(guiTemplate, true)
		if guiTemplateInstance == nil then
			Logger:Log(script.Name, "Failed to load GUI template with name: ", guiTemplate)
		end
		return guiTemplateInstance
	end
end
-- Event Manager
local EventManager
do
	EventManager = setmetatable({}, {
		__tostring = function()
			return "EventManager"
		end,
	})
	EventManager.__index = EventManager
	function EventManager.new(...)
		local self = setmetatable({}, EventManager)
		return self:constructor(...) or self
	end
	function EventManager:constructor()
	end
	function EventManager:GetEvent(eventName)
		local event = EventManager.EventsFolder:FindFirstChild(eventName, true)
		return event
	end
	EventManager.EventsFolder = game:GetService("ReplicatedStorage"):WaitForChild("Asset Package - Remotes")
end
-- GUI Reference Handler
local GuiReferenceHandler
do
	GuiReferenceHandler = setmetatable({}, {
		__tostring = function()
			return "GuiReferenceHandler"
		end,
	})
	GuiReferenceHandler.__index = GuiReferenceHandler
	function GuiReferenceHandler.new(...)
		local self = setmetatable({}, GuiReferenceHandler)
		return self:constructor(...) or self
	end
	function GuiReferenceHandler:constructor()
	end
	function GuiReferenceHandler:getScreenGui(player, guiName)
		local guiInstance = player:WaitForChild("PlayerGui"):WaitForChild(guiName)
		if guiInstance == nil then
			Logger:Log(script.Name, "Failed to load GUI with name: ", guiName)
		end
		return guiInstance
	end
	function GuiReferenceHandler:ToggleScreenGui(player, guiName, toggle)
		local guiInstance = player:WaitForChild("PlayerGui"):WaitForChild(guiName)
		if guiInstance == nil then
			Logger:Log(script.Name, "Failed to Toggle GUI with name: ", guiName)
		end
		guiInstance.Enabled = toggle
	end
	function GuiReferenceHandler:getUIElement(player, guiName, elementName)
		local guiInstance = player:WaitForChild("PlayerGui"):WaitForChild(guiName)
		local elementInstance = guiInstance:FindFirstChild(elementName, true)
		if elementInstance == nil then
			Logger:Log(script.Name, "Failed to load UI Element with name: ", elementName)
		end
		return elementInstance
	end
end
return {
	EPackageIDs = EPackageIDs,
	EGuiTemplates = EGuiTemplates,
	EAuraNames = EAuraNames,
	EScreenGuis = EScreenGuis,
	EGUIElements = EGUIElements,
	PackageManager = PackageManager,
	EventManager = EventManager,
	GuiReferenceHandler = GuiReferenceHandler,
}
