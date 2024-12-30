-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameStorage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "GameStorage").GameStorage
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local EHumanoidDescription = {
	RobotBase = "RobotBase",
	DemonBase = "DemonBasee",
	VampireBase = "VampireBase",
	HumanBase = "HumanBase",
	AngelBase = "AngelBase",
	OccultistBase = "OccultistBase",
}
local HumanoidDescriptionFactory
do
	HumanoidDescriptionFactory = setmetatable({}, {
		__tostring = function()
			return "HumanoidDescriptionFactory"
		end,
	})
	HumanoidDescriptionFactory.__index = HumanoidDescriptionFactory
	function HumanoidDescriptionFactory.new(...)
		local self = setmetatable({}, HumanoidDescriptionFactory)
		return self:constructor(...) or self
	end
	function HumanoidDescriptionFactory:constructor()
		-- Private constructor to prevent instantiation
		self:LoadBaseHumanoidDescriptions()
		return self
	end
	function HumanoidDescriptionFactory:getInstance()
		if HumanoidDescriptionFactory._instance == nil then
			HumanoidDescriptionFactory._instance = HumanoidDescriptionFactory.new()
		end
		return HumanoidDescriptionFactory._instance
	end
	function HumanoidDescriptionFactory:LoadBaseHumanoidDescriptions()
		HumanoidDescriptionFactory:setHumanoidDescription(EHumanoidDescription.RobotBase)
		HumanoidDescriptionFactory:setHumanoidDescription(EHumanoidDescription.DemonBase)
		HumanoidDescriptionFactory:setHumanoidDescription(EHumanoidDescription.VampireBase)
		HumanoidDescriptionFactory:setHumanoidDescription(EHumanoidDescription.HumanBase)
		HumanoidDescriptionFactory:setHumanoidDescription(EHumanoidDescription.AngelBase)
		HumanoidDescriptionFactory:setHumanoidDescription(EHumanoidDescription.OccultistBase)
	end
	function HumanoidDescriptionFactory:getHumanoidDescription(humanoidDescription)
		local __humanoidDescriptions = HumanoidDescriptionFactory._humanoidDescriptions
		local _humanoidDescription = humanoidDescription
		return __humanoidDescriptions[_humanoidDescription]
	end
	function HumanoidDescriptionFactory:setHumanoidDescription(hdName)
		local humanoidDescription = GameStorage:cloneHumanoidDescription(hdName)
		if humanoidDescription == nil then
			Logger:Log("HumanoidDescriptionFactory", `Humanoid {hdName} not found in storage.`)
			return nil
		end
		local __humanoidDescriptions = HumanoidDescriptionFactory._humanoidDescriptions
		local _hdName = hdName
		__humanoidDescriptions[_hdName] = humanoidDescription
	end
	function HumanoidDescriptionFactory:ApplyHumanoidDescription(humanoid, hdName)
		local humanoidDescription = HumanoidDescriptionFactory:getHumanoidDescription(hdName)
		local currenctDescription = humanoid:GetAppliedDescription()
		if currenctDescription == nil then
			Logger:Log("HumanoidDescriptionFactory", `Humanoid cache not found in storage.`)
		end
		if humanoidDescription == nil then
			Logger:Log("HumanoidDescriptionFactory", `Humanoid {hdName} not found in storage.`)
			return nil
		end
		humanoid:ApplyDescription(humanoidDescription)
	end
	HumanoidDescriptionFactory._humanoidDescriptions = {}
end
return {
	EHumanoidDescription = EHumanoidDescription,
	HumanoidDescriptionFactory = HumanoidDescriptionFactory,
}
