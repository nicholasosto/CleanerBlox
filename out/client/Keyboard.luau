-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Begin: KeyboardClient.ts
local UserInputService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").UserInputService
local TNums = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Enums", "TNums").TNums
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local KeyboardClient
do
	KeyboardClient = setmetatable({}, {
		__tostring = function()
			return "KeyboardClient"
		end,
	})
	KeyboardClient.__index = KeyboardClient
	function KeyboardClient.new(...)
		local self = setmetatable({}, KeyboardClient)
		return self:constructor(...) or self
	end
	function KeyboardClient:constructor(character)
		-- Set the wcsCharacter
		repeat
			do
				self.wcsCharacter = Character.GetLocalCharacter()
				task.wait(0.3)
			end
		until not (self.wcsCharacter == nil)
		-- Get the skills from WCS
		local skills = self.wcsCharacter:GetSkills()
		-- INPUT BEGAN
		self.inputBeganConnection = UserInputService.InputBegan:Connect(function(input, isProcessed)
			if isProcessed then
				return nil
			end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				local keyCode = input.KeyCode
				self:onKeyPress(keyCode, true)
			end
		end)
		-- INPUT ENDED
		self.inputEndedConnection = UserInputService.InputEnded:Connect(function(input, isProcessed)
			if isProcessed then
				return nil
			end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				local keyCode = input.KeyCode
				self:onKeyPress(keyCode, false)
			end
		end)
	end
	function KeyboardClient:SkillToggle(skillName, begin)
		local character = self.wcsCharacter
		local skill = character:GetSkillFromString(skillName)
		if skill then
			if begin then
				skill:Start()
			else
				skill:Stop()
			end
		end
	end
	function KeyboardClient:onKeyPress(key, begin)
		repeat
			if key == (Enum.KeyCode.Q) then
				self:SkillToggle(TNums.SkillNames.Spotlights, begin)
				break
			end
			if key == (Enum.KeyCode.E) then
				self:SkillToggle(TNums.SkillNames.Dash, begin)
				break
			end
			warn(`Unhandled key: {key}`)
			break
		until true
	end
end
-- End: KeyboardClient.ts
return {
	KeyboardClient = KeyboardClient,
}
