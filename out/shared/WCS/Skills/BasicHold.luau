-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local SkillConfigurations = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Skills", "Skills").SkillConfigurations
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local BasicHold
do
	local super = Skill
	BasicHold = setmetatable({}, {
		__tostring = function()
			return "BasicHold"
		end,
		__index = super,
	})
	BasicHold.__index = BasicHold
	function BasicHold.new(...)
		local self = setmetatable({}, BasicHold)
		return self:constructor(...) or self
	end
	function BasicHold:constructor(...)
		super.constructor(self, ...)
	end
	function BasicHold:OnConstruct()
		Logger:Log(script, "BasicHold Construct")
	end
	function BasicHold:OnConstructServer()
		Logger:Log(script, "BasicHold Server")
		--this.DamageContainer = new DamageContainer(this, "Melee", 10);
	end
	function BasicHold:OnConstructClient()
		Logger:Log(script, "BasicHold Client")
	end
	function BasicHold:OnStartServer()
		Logger:Log(script, "Start Server")
	end
	function BasicHold:OnEndServer()
		Logger:Log(script, "End Server")
	end
	BasicHold.SkillConfiguration = SkillConfigurations.BasicHold
	BasicHold = SkillDecorator(BasicHold) or BasicHold
end
return {
	BasicHold = BasicHold,
}
