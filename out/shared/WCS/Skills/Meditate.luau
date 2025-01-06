-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Meditate
do
	local super = Skill
	Meditate = setmetatable({}, {
		__tostring = function()
			return "Meditate"
		end,
		__index = super,
	})
	Meditate.__index = Meditate
	function Meditate.new(...)
		local self = setmetatable({}, Meditate)
		return self:constructor(...) or self
	end
	function Meditate:constructor(...)
		super.constructor(self, ...)
	end
	function Meditate:OnConstruct()
		Logger:Log(script, "- Construct")
	end
	function Meditate:OnConstructServer()
		Logger:Log(script, " - Server")
		--this.DamageContainer = new DamageContainer(this, "Melee", 10);
	end
	function Meditate:OnConstructClient()
		Logger:Log(script, "- Client")
	end
	function Meditate:OnStartServer()
		Logger:Log(script, "Start Server")
	end
	function Meditate:OnEndServer()
		Logger:Log(script, "End Server")
	end
	Meditate = SkillDecorator(Meditate) or Meditate
end
return {
	Meditate = Meditate,
}
