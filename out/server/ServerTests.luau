-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local _HomingSphere = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Skill Parts", "HomingSphere")
local HomingSphere = _HomingSphere.HomingSphere
local HSState = _HomingSphere.HSState
local CollectionService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").CollectionService
local ServerTests
do
	ServerTests = setmetatable({}, {
		__tostring = function()
			return "ServerTests"
		end,
	})
	ServerTests.__index = ServerTests
	function ServerTests.new(...)
		local self = setmetatable({}, ServerTests)
		return self:constructor(...) or self
	end
	function ServerTests:constructor()
	end
	function ServerTests:TestHomingSphere()
		-- Initialize the HomingSphere listener
		CollectionService:GetInstanceAddedSignal("HomingSphere"):Connect(function(instance)
			Logger:Log(`HomingSphere tagged: {instance.Name}`)
			local homingSphere = HomingSphere.new(instance)
			homingSphere:transitionTo(HSState.Searching)
		end)
		-- Handle existing instances already tagged with "HomingSphere"
		local _exp = CollectionService:GetTagged("HomingSphere")
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(instance)
			Logger:Log(`Existing HomingSphere found: {instance.Name}`)
			local homingSphere = HomingSphere.new(instance)
			homingSphere:transitionTo(HSState.Searching)
		end
		for _k, _v in _exp do
			_callback(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
end
return {
	ServerTests = ServerTests,
}
