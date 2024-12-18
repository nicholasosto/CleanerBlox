-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Begin: KeyboardController.ts
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local UserInputService = _services.UserInputService
local Workspace = _services.Workspace
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local CommunicationGod = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Events", "CommunicationGod").CommunicationGod
-- Set the skills here
local Skills = {}
local _q = Enum.KeyCode.Q
Skills[_q] = "BasicMelee"
local _e = Enum.KeyCode.E
Skills[_e] = "CleanHold"
local _r = Enum.KeyCode.R
Skills[_r] = "BigRed"
local _t = Enum.KeyCode.T
Skills[_t] = "ShapeTester"
CommunicationGod:Summon()
local AI_Request = GameStorage:getEvent("AI_Request")
local KeyboardController
do
	KeyboardController = setmetatable({}, {
		__tostring = function()
			return "KeyboardController"
		end,
	})
	KeyboardController.__index = KeyboardController
	function KeyboardController.new(...)
		local self = setmetatable({}, KeyboardController)
		return self:constructor(...) or self
	end
	function KeyboardController:constructor()
		local Player = game:GetService("Players").LocalPlayer
		local character = Player.Character
		KeyboardController:OnCharacterAdded(character)
		-- CHARACTER ADDED
		KeyboardController.characterAddedConnection = Player.CharacterAdded:Connect(function(character)
			--Logger.Log("KeyboardController", "Character Added");
			KeyboardController:OnCharacterAdded(character)
		end)
	end
	function KeyboardController:Start()
		if self.instance == nil then
			self.instance = KeyboardController.new()
		end
	end
	function KeyboardController:OnCharacterAdded(character)
		-- Disconnect the previous connections
		local _result = KeyboardController.inputBeganConnection
		if _result ~= nil then
			_result:Disconnect()
		end
		local _result_1 = KeyboardController.inputEndedConnection
		if _result_1 ~= nil then
			_result_1:Disconnect()
		end
		local wcsCharacter = Character.GetLocalCharacter()
		-- Input Began Connection
		KeyboardController.inputBeganConnection = UserInputService.InputBegan:Connect(function(input, isProcessed)
			if input.KeyCode == Enum.KeyCode.F then
				print("F Pressed")
				AI_Request:FireServer(Workspace:FindFirstChild("TrembusTech"))
			end
			KeyboardController:InputBegan(input, isProcessed)
		end)
		-- Input Ended Connection
		KeyboardController.inputEndedConnection = UserInputService.InputEnded:Connect(function(input, isProcessed)
			KeyboardController:InputEnded(input, isProcessed)
		end)
	end
	function KeyboardController:InputBegan(input, isProcessed)
		KeyboardController:onKeyPress(input.KeyCode, true)
	end
	function KeyboardController:InputEnded(input, isProcessed)
		KeyboardController:onKeyPress(input.KeyCode, false)
	end
	function KeyboardController:SkillToggle(skillName, begin)
		local character = Character.GetLocalCharacter()
		local skill = character:GetSkillFromString(skillName)
		if skill then
			if begin then
				skill:Start()
			else
				skill:Stop()
			end
		end
	end
	function KeyboardController:onKeyPress(key, begin)
		local _key = key
		local skillName = Skills[_key]
		if skillName ~= "" and skillName then
			self:SkillToggle(skillName, begin)
		end
	end
end
-- End: KeyboardController.ts
return {
	KeyboardController = KeyboardController,
}
