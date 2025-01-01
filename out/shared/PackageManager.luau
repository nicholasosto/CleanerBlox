-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local InsertService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").InsertService
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local EPackageIDs
do
	local _inverse = {}
	EPackageIDs = setmetatable({}, {
		__index = _inverse,
	})
	EPackageIDs.Environment = 16178566269
	_inverse[16178566269] = "Environment"
	EPackageIDs.Effects = 16593023479
	_inverse[16593023479] = "Effects"
	EPackageIDs.Audio = 16412665714
	_inverse[16412665714] = "Audio"
	EPackageIDs.NPC = 16034962856
	_inverse[16034962856] = "NPC"
	EPackageIDs.GameStorage = 106038395934214
	_inverse[106038395934214] = "GameStorage"
	EPackageIDs.Weapons = 16226642685
	_inverse[16226642685] = "Weapons"
end
local PackageManager
do
	PackageManager = setmetatable({}, {
		__tostring = function()
			return "PackageManager"
		end,
	})
	PackageManager.__index = PackageManager
	function PackageManager.new(...)
		local self = setmetatable({}, PackageManager)
		return self:constructor(...) or self
	end
	function PackageManager:constructor()
	end
	function PackageManager:LoadPackage(packageID)
		local packageContainer = InsertService:LoadAsset(packageID)
		if packageContainer == nil then
			Logger:Log(script.Name, "Failed to load package with ID: ", packageID)
		end
		return packageContainer
	end
end
return {
	EPackageIDs = EPackageIDs,
	PackageManager = PackageManager,
}
