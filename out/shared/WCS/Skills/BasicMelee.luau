-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local SkillConfigurations = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "_References", "Skills", "Skills").SkillConfigurations
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local BasicMelee
do
	local super = Skill
	BasicMelee = setmetatable({}, {
		__tostring = function()
			return "BasicMelee"
		end,
		__index = super,
	})
	BasicMelee.__index = BasicMelee
	function BasicMelee.new(...)
		local self = setmetatable({}, BasicMelee)
		return self:constructor(...) or self
	end
	function BasicMelee:constructor(...)
		super.constructor(self, ...)
	end
	function BasicMelee:OnConstruct()
		Logger:Log(script, "BasicMelee Construct")
	end
	function BasicMelee:OnConstructServer()
		Logger:Log(script, "BasicMelee Server")
		--this.DamageContainer = new DamageContainer(this, "Melee", 10);
	end
	function BasicMelee:OnConstructClient()
		Logger:Log(script, "BasicMelee Client")
	end
	function BasicMelee:OnStartServer()
		Logger:Log(script, "Start Server")
	end
	function BasicMelee:OnEndServer()
		Logger:Log(script, "End Server")
	end
	BasicMelee.SkillConfiguration = SkillConfigurations.BasicMelee
	BasicMelee = SkillDecorator(BasicMelee) or BasicMelee
end
return {
	BasicMelee = BasicMelee,
}
