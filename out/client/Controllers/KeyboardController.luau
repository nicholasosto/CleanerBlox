-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Begin: KeyboardController.ts
local UserInputService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").UserInputService
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local PositionGenerator = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "PositionGenerator").PositionGenerator
local CommunicationGod = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Events", "CommunicationGod").CommunicationGod
CommunicationGod:Summon()
local function formatVector3(vector)
	local x = "X:" .. tostring(math.round(vector.X * 10) / 10)
	local y = " y: " .. tostring(math.round(vector.Y * 10) / 10)
	local z = " Z: " .. tostring(math.round(vector.Z * 10) / 10)
	return x .. y .. z
end
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
	function KeyboardController:PositionGeneratorTests(start)
		local scriptBlock = game:GetService("Workspace"):FindFirstChild("ScriptBlock", true)
		if not start then
			scriptBlock:ClearAllChildren()
			Logger:Log("PositionGeneratorTests", "Cleared Children")
			return nil
		end
		local scriptBlockAttachment = Instance.new("Attachment")
		scriptBlock.Name = "ScriptBlockAttachment"
		scriptBlockAttachment.Parent = scriptBlock
		local randomPositionTest = PositionGenerator:GenerateRandomPositionsAroundSource(scriptBlock, 15, 22)
		local fireIndicator = Instance.new("Fire")
		fireIndicator.Color = Color3.fromRGB(255, 222, 0)
		fireIndicator.Parent = scriptBlock
		local beamCreated = false
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(position)
			local firePart = Instance.new("Part")
			local fire = Instance.new("Fire")
			local fireAttachment = Instance.new("Attachment")
			fireAttachment.Parent = firePart
			local beam = Instance.new("Beam")
			if not beamCreated then
				beamCreated = true
				beam.Parent = firePart
				beam.Color = ColorSequence.new(Color3.new(1, 0, 0))
				beam.FaceCamera = true
				beam.LightEmission = 1
				beam.LightInfluence = 0
				beam.Segments = 10
				beam.Attachment0 = scriptBlockAttachment
				beam.Attachment1 = fireAttachment
				firePart.Name = "HitPart"
				firePart.Color = Color3.fromRGB(255, 0, 0)
			else
				beamCreated = false
			end
			fire.Color = Color3.fromRGB(255, 222, 0)
			fire.Parent = firePart
			firePart.Size = Vector3.new(1, 1, 1)
			firePart.Position = position
			firePart.Anchored = true
			firePart.Parent = scriptBlock
		end
		for _k, _v in randomPositionTest do
			_callback(_v, _k - 1, randomPositionTest)
		end
		-- ▲ ReadonlyArray.forEach ▲
		local defaultTargetPosition = PositionGenerator:GenerateDefaultTargetPosition(scriptBlock, 10)
		warn("Default Target Position: ", formatVector3(defaultTargetPosition))
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
		local serverSignals = CommunicationGod.ServerSignals
		--Logger.Log("KeyboardController", `Key Pressed: ${key} - ${begin}`);
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
			if key == (Enum.KeyCode.T) then
				self:PositionGeneratorTests(begin)
				break
			end
			if key == (Enum.KeyCode.Y) then
				-- ▼ ReadonlyMap.forEach ▼
				local _callback = function(signal, name)
					signal:FireServer(begin)
					print("Fired Signal: ", name)
				end
				for _k, _v in serverSignals do
					_callback(_v, _k, serverSignals)
				end
				-- ▲ ReadonlyMap.forEach ▲
				break
			end
			--warn(`Unhandled key: ${key}`);
			break
		until true
	end
end
-- End: KeyboardController.ts
return {
	KeyboardController = KeyboardController,
}
