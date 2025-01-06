-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local MultiJump
do
	local super = Skill
	MultiJump = setmetatable({}, {
		__tostring = function()
			return "MultiJump"
		end,
		__index = super,
	})
	MultiJump.__index = MultiJump
	function MultiJump.new(...)
		local self = setmetatable({}, MultiJump)
		return self:constructor(...) or self
	end
	function MultiJump:constructor(...)
		super.constructor(self, ...)
	end
	function MultiJump:OnConstruct()
		Logger:Log(script, "- Construct")
	end
	function MultiJump:OnConstructServer()
		Logger:Log(script, " - Server")
		--this.DamageContainer = new DamageContainer(this, "Melee", 10);
	end
	function MultiJump:OnConstructClient()
		Logger:Log(script, "- Client")
	end
	function MultiJump:OnStartServer()
		Logger:Log(script, "Start Server")
	end
	function MultiJump:OnEndServer()
		Logger:Log(script, "End Server")
	end
	MultiJump = SkillDecorator(MultiJump) or MultiJump
end
return {
	MultiJump = MultiJump,
}
