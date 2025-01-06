-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Fly
do
	local super = Skill
	Fly = setmetatable({}, {
		__tostring = function()
			return "Fly"
		end,
		__index = super,
	})
	Fly.__index = Fly
	function Fly.new(...)
		local self = setmetatable({}, Fly)
		return self:constructor(...) or self
	end
	function Fly:constructor(...)
		super.constructor(self, ...)
	end
	function Fly:OnConstruct()
		Logger:Log(script, "- Construct")
	end
	function Fly:OnConstructServer()
		Logger:Log(script, " - Server")
		--this.DamageContainer = new DamageContainer(this, "Melee", 10);
	end
	function Fly:OnConstructClient()
		Logger:Log(script, "- Client")
	end
	function Fly:OnStartServer()
		Logger:Log(script, "Start Server")
	end
	function Fly:OnEndServer()
		Logger:Log(script, "End Server")
	end
	Fly = SkillDecorator(Fly) or Fly
end
return {
	Fly = Fly,
}
