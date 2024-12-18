-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local WeaponManager
do
	WeaponManager = setmetatable({}, {
		__tostring = function()
			return "WeaponManager"
		end,
	})
	WeaponManager.__index = WeaponManager
	function WeaponManager.new(...)
		local self = setmetatable({}, WeaponManager)
		return self:constructor(...) or self
	end
	function WeaponManager:constructor()
	end
	function WeaponManager:LoadWCSCharacterWeapon(character, weaponName)
		local weapon = GameStorage:cloneAccessory(weaponName)
		local player = character.Player
		if player == nil or weapon == nil then
			return nil
		end
		local playerBackpack = player:FindFirstChildOfClass("Backpack")
		if playerBackpack then
			weapon.Parent = playerBackpack
		end
		if weapon == nil then
			return nil
		end
		return weapon
	end
	function WeaponManager:EquipWCSCharacterWeapon(character, weaponName)
		local player = character.Player
		if player == nil then
			return nil
		end
		local playerBackpack = player:FindFirstChildOfClass("Backpack")
		if playerBackpack == nil then
			return nil
		end
		local weapon = playerBackpack:FindFirstChild(weaponName)
		if weapon == nil then
			return nil
		end
		weapon.Parent = character.Instance
	end
	function WeaponManager:UnEquipWCSCharacterWeapon(player, weapon)
		if player == nil or weapon == nil then
			return nil
		end
		Logger:Log("BasicMelee", "UnEquipping Weapon")
		weapon.Parent = player:FindFirstChildOfClass("Backpack")
	end
	function WeaponManager:UnloadWCSCharacterWeapon(character, weaponName)
		local player = character.Player
		if player == nil then
			return nil
		end
		local playerBackpack = player:FindFirstChildOfClass("Backpack")
		if playerBackpack == nil then
			return nil
		end
		local weapon = playerBackpack:FindFirstChild(weaponName)
		if weapon == nil then
			return nil
		end
		weapon:Destroy()
	end
end
return {
	WeaponManager = WeaponManager,
}
