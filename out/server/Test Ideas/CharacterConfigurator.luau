-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local CharacterConfigurator
do
	CharacterConfigurator = setmetatable({}, {
		__tostring = function()
			return "CharacterConfigurator"
		end,
	})
	CharacterConfigurator.__index = CharacterConfigurator
	function CharacterConfigurator.new(...)
		local self = setmetatable({}, CharacterConfigurator)
		return self:constructor(...) or self
	end
	function CharacterConfigurator:constructor()
		self.effectNames = { "AbilityParticle1", "AbilityParticle2" }
		Players.PlayerAdded:Connect(function(player)
			player.CharacterAdded:Connect(function(character)
				print("Character Configurator: Character added")
				self:configureCharacter(character)
			end)
		end)
	end
	function CharacterConfigurator:configureCharacter(character)
		-- ...existing code...
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		local humanoid = character:WaitForChild("Humanoid")
		local lowerTorso = character:WaitForChild("LowerTorso")
		local attachment = Instance.new("Attachment")
		attachment.Name = "CastingFloor"
		attachment.Parent = lowerTorso
		-- get the pivot of the character
		-- set the y position of the attachment to the floor
		attachment.Position = Vector3.new(0, -1 * humanoid.HipHeight, 0)
	end
	function CharacterConfigurator:enableEffect(character, effectName)
		local _result = character:FindFirstChild("HumanoidRootPart")
		if _result ~= nil then
			_result = _result:FindFirstChild("AbilityAttachment")
			if _result ~= nil then
				_result = _result:FindFirstChild(effectName)
			end
		end
		local particleEffect = _result
		if particleEffect then
			particleEffect.Enabled = true
		end
	end
	function CharacterConfigurator:disableEffect(character, effectName)
		local _result = character:FindFirstChild("HumanoidRootPart")
		if _result ~= nil then
			_result = _result:FindFirstChild("AbilityAttachment")
			if _result ~= nil then
				_result = _result:FindFirstChild(effectName)
			end
		end
		local particleEffect = _result
		if particleEffect then
			particleEffect.Enabled = false
		end
	end
end
return {
	CharacterConfigurator = CharacterConfigurator,
}
