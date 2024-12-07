-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local Character = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out").Character
local Attack = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Skills", "Attack").Attack
Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(CharacterModel)
		-- apply the wrap when character model gets created
		local WCS_Character = Character.new(CharacterModel)
		-- apply our freshly made skill
		Attack.new(WCS_Character)
		-- destroy it when humanoid dies
		local humanoid = CharacterModel:WaitForChild("Humanoid")
		humanoid.Died:Once(function()
			return WCS_Character:Destroy()
		end)
	end)
end)
return nil
