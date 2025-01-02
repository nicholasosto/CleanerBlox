-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Begin: KeyboardController.ts
local UserInputService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").UserInputService
local ClientInventoryService = TS.import(script, script.Parent.Parent, "Services", "ClientInventoryService").ClientInventoryService
local ClientSkillService = TS.import(script, script.Parent.Parent, "Services", "ClientSkillService").ClientSkillService
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local CommunicationGod = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Experimental", "CommunicationGod").CommunicationGod
local InventoryReference = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "SharedReference").InventoryReference
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
			--Logger.Log(script,"KeyboardController", "Character Added");
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
			local _exp = input.KeyCode
			repeat
				if _exp == (Enum.KeyCode.V) then
					print("V Pressed")
					ClientSkillService:AssignSlotRequest("1", "Basic")
					break
				end
				if _exp == (Enum.KeyCode.G) then
					print("G Pressed")
					break
				end
				if _exp == (Enum.KeyCode.H) then
					print("H Pressed")
					self:InventoryToggle(InventoryReference.EInventorySlot.Body, "Plate_Legendary_RB", true)
					self:InventoryToggle(InventoryReference.EInventorySlot.Helmet, "Demon Lord Halo", true)
					break
				end
				if _exp == (Enum.KeyCode.J) then
					print("J Pressed")
					self:InventoryToggle(InventoryReference.EInventorySlot.LeftHand, "Scythe_Epic_Black", true)
					self:InventoryToggle(InventoryReference.EInventorySlot.RightHand, "Scythe_Epic_Black", true)
					break
				end
				KeyboardController:InputBegan(input, isProcessed)
				break
			until true
		end)
		-- Input Ended Connection
		KeyboardController.inputEndedConnection = UserInputService.InputEnded:Connect(function(input, isProcessed)
			local _exp = input.KeyCode
			repeat
				if _exp == (Enum.KeyCode.V) then
					print("V Pressed")
					ClientSkillService:AssignSlotRequest("1", "Basic")
					break
				end
				if _exp == (Enum.KeyCode.G) then
					print("G Pressed")
					break
				end
				if _exp == (Enum.KeyCode.H) then
					print("H Pressed")
					self:InventoryToggle(InventoryReference.EInventorySlot.Body, "Plate_Legendary_RB", false)
					self:InventoryToggle(InventoryReference.EInventorySlot.Helmet, "Demon Lord Halo", false)
					break
				end
				if _exp == (Enum.KeyCode.J) then
					print("J Pressed")
					self:InventoryToggle(InventoryReference.EInventorySlot.LeftHand, "Scythe_Epic_Black", false)
					self:InventoryToggle(InventoryReference.EInventorySlot.RightHand, "Scythe_Epic_Black", false)
					break
				end
				KeyboardController:InputEnded(input, isProcessed)
				break
			until true
		end)
	end
	function KeyboardController:InputBegan(input, isProcessed)
		KeyboardController:onKeyPress(input.KeyCode, true)
	end
	function KeyboardController:InputEnded(input, isProcessed)
		KeyboardController:onKeyPress(input.KeyCode, false)
	end
	function KeyboardController:InventoryToggle(equipmentSlot, weaponName, begin)
		if begin then
			ClientInventoryService:SendEquipRequest(equipmentSlot, weaponName)
		else
			ClientInventoryService:SendUnequipRequest(equipmentSlot)
		end
	end
	function KeyboardController:SkillToggle(skillName, begin)
		local character = Character.GetLocalCharacter()
		if not character then
			return nil
		end
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
		self:SkillToggle(skillName, begin)
	end
end
-- End: KeyboardController.ts
return {
	KeyboardController = KeyboardController,
}
