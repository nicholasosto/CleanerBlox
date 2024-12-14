-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Begin: KeyboardController.ts
local UserInputService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").UserInputService
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
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
			Logger:Log("KeyboardController", "Character Added")
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
		Logger:Log("KeyboardController", `Skill Toggle: {skillName} - {begin}`)
		local character = Character.GetLocalCharacter()
		local skill = character:GetSkillFromString(skillName)
		Logger:Log("KeyboardController", `Skill: {skill}`)
		if skill then
			if begin then
				skill:Start()
			else
				skill:Stop()
			end
		end
	end
	function KeyboardController:onKeyPress(key, begin)
		Logger:Log("KeyboardController", `Key Pressed: {key} - {begin}`)
		repeat
			if key == (Enum.KeyCode.Q) then
				self:SkillToggle("DevilBeam", begin)
				break
			end
			if key == (Enum.KeyCode.E) then
				self:SkillToggle("Spotlights", begin)
				break
			end
			if key == (Enum.KeyCode.R) then
				self:SkillToggle("BigRed", begin)
				break
			end
			warn(`Unhandled key: {key}`)
			break
		until true
	end
end
-- End: KeyboardController.ts
return {
	KeyboardController = KeyboardController,
}
