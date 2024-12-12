-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
-- States for HomingSphere
local HSState = {
	Created = "Created",
	Searching = "Searching",
	Homing = "Homing",
	Exploding = "Exploding",
}
-- HomingSphere: Class for HomingSphere
local HomingSphere
do
	HomingSphere = setmetatable({}, {
		__tostring = function()
			return "HomingSphere"
		end,
	})
	HomingSphere.__index = HomingSphere
	function HomingSphere.new(...)
		local self = setmetatable({}, HomingSphere)
		return self:constructor(...) or self
	end
	function HomingSphere:constructor(owner)
		self._state = HSState.Created
		Logger:Log("HomingSphere", "Created", owner.Name)
		self._instance = GameStorage:getModel("HomingSphere")
		self._owner = owner
		self._hitPart = self._instance:FindFirstChild("HitPart")
		if not self._hitPart then
			error("HitPart not found in HomingSphere")
		end
		self:transitionTo(HSState.Searching)
		return self
	end
	function HomingSphere:transitionTo(newState)
		self._state = newState
		repeat
			if newState == (HSState.Created) then
				self:onCreated()
				break
			end
			if newState == (HSState.Searching) then
				self:onSearching()
				break
			end
			if newState == (HSState.Homing) then
				self:onHoming()
				break
			end
			if newState == (HSState.Exploding) then
				self:onExploding()
				break
			end
		until true
	end
	function HomingSphere:onCreated()
		print("HomingSphere Created")
	end
	function HomingSphere:onSearching()
		print("HomingSphere Searching")
	end
	function HomingSphere:onHoming()
		print("HomingSphere Homing")
	end
	function HomingSphere:onExploding()
		print("HomingSphere Exploding")
	end
end
return {
	HSState = HSState,
	HomingSphere = HomingSphere,
}
