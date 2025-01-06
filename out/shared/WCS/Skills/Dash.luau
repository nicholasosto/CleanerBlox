-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Dash
do
	local super = Skill
	Dash = setmetatable({}, {
		__tostring = function()
			return "Dash"
		end,
		__index = super,
	})
	Dash.__index = Dash
	function Dash.new(...)
		local self = setmetatable({}, Dash)
		return self:constructor(...) or self
	end
	function Dash:constructor(...)
		super.constructor(self, ...)
	end
	function Dash:OnConstruct()
		Logger:Log(script, "- Construct")
	end
	function Dash:OnConstructServer()
		Logger:Log(script, " - Server")
		--this.DamageContainer = new DamageContainer(this, "Melee", 10);
	end
	function Dash:OnConstructClient()
		Logger:Log(script, "- Client")
	end
	function Dash:OnStartServer()
		Logger:Log(script, "Start Server")
	end
	function Dash:OnEndServer()
		Logger:Log(script, "End Server")
	end
	Dash = SkillDecorator(Dash) or Dash
end
return {
	Dash = Dash,
}
