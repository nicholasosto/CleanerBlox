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
		Players.PlayerAdded:Connect(function(player)
			player.CharacterAdded:Connect(function(character)
				print("Character Configurator: Character added")
				--this.configureCharacter(character);
			end)
		end)
	end
	function CharacterConfigurator:configureCharacter(character)
		-- ...existing code...
		-- const humanoidRootPart = character.WaitForChild("HumanoidRootPart") as Part;
		-- const humanoid: Humanoid = character.WaitForChild("Humanoid") as Humanoid;
		-- const lowerTorso = character.WaitForChild("LowerTorso") as Part;
		-- const attachment = new Instance("Attachment");
		-- attachment.Name = "CastingFloor";
		-- attachment.Parent = lowerTorso;
		-- // get the pivot of the character
		-- // set the y position of the attachment to the floor
		-- attachment.Position = new Vector3(0, -1 * humanoid.HipHeight, 0);
	end
end
return {
	CharacterConfigurator = CharacterConfigurator,
}
