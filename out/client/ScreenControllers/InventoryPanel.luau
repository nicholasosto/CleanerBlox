-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local SkillsRef = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Character", "Skills")
local _GameAssetManagers = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "GameAssetManagers")
local PackageManager = _GameAssetManagers.PackageManager
local EGuiTemplates = _GameAssetManagers.EGuiTemplates
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local InventoryPanel
do
	InventoryPanel = setmetatable({}, {
		__tostring = function()
			return "InventoryPanel"
		end,
	})
	InventoryPanel.__index = InventoryPanel
	function InventoryPanel.new(...)
		local self = setmetatable({}, InventoryPanel)
		return self:constructor(...) or self
	end
	function InventoryPanel:constructor(screenGui, inventoryType)
		self._connections = {}
		-- ScreenGui
		self._screenGui = screenGui
		-- Inventory Type
		self._inventoryType = inventoryType
		-- Main Frame
		self._mainFrame = self._screenGui:FindFirstChild("MainFrame")
		-- Toggle and Close Button
		local toggleButtonReference = self._screenGui:FindFirstChild("ToggleButton")
		self._toggleButton = toggleButtonReference.Value
		local closeButtonReference = self._screenGui:FindFirstChild("CloseButton")
		self._closeButton = closeButtonReference.Value
		self._scrollingFrame = self._screenGui:FindFirstChild("InventoryScroller")
		-- Connect Signals
		self:_connectSignals()
		Logger:Log(script, "Inventory Panel Created")
		return self
	end
	function InventoryPanel:_connectSignals()
		-- Toggle Button
		local connection = self._toggleButton.Activated:Connect(function()
			self:ToggleScreenGui()
		end)
		self._connections.Toggle = connection
		-- Close Button
		self._connections.Close = connection
	end
	function InventoryPanel:ToggleScreenGui()
		self._mainFrame.Visible = not self._mainFrame.Visible
	end
	function InventoryPanel:_disconnectAll()
		local _exp = self._connections
		-- ▼ ReadonlyMap.forEach ▼
		local _callback = function(connection)
			connection:Disconnect()
		end
		for _k, _v in _exp do
			_callback(_v, _k, _exp)
		end
		-- ▲ ReadonlyMap.forEach ▲
	end
	function InventoryPanel:CreatePanel(inventoryType)
		local screenGui = PackageManager:GetGuiTemplate(EGuiTemplates.InventoryPanel)
		screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		local inventoryPanel = InventoryPanel.new(screenGui, inventoryType)
		return inventoryPanel
	end
end
return {
	InventoryPanel = InventoryPanel,
}
