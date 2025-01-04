-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local SkillConfigurations = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Skills", "Skills").SkillConfigurations
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local BasicRanged
do
	local super = Skill
	BasicRanged = setmetatable({}, {
		__tostring = function()
			return "BasicRanged"
		end,
		__index = super,
	})
	BasicRanged.__index = BasicRanged
	function BasicRanged.new(...)
		local self = setmetatable({}, BasicRanged)
		return self:constructor(...) or self
	end
	function BasicRanged:constructor(...)
		super.constructor(self, ...)
	end
	function BasicRanged:OnConstruct()
		Logger:Log(script, "BasicRanged Construct")
	end
	function BasicRanged:OnConstructServer()
		Logger:Log(script, "BasicRanged Server")
		--this.DamageContainer = new DamageContainer(this, "Melee", 10);
	end
	function BasicRanged:OnConstructClient()
		Logger:Log(script, "BasicRanged Client")
	end
	function BasicRanged:OnStartServer()
		Logger:Log(script, "Start Server")
	end
	function BasicRanged:OnEndServer()
		Logger:Log(script, "End Server")
	end
	BasicRanged.SkillConfiguration = SkillConfigurations.BasicRanged
	BasicRanged = SkillDecorator(BasicRanged) or BasicRanged
end
return {
	BasicRanged = BasicRanged,
}
