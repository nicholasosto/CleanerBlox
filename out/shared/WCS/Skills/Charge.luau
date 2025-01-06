-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local Logger = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Utility", "Logger").Logger
local Charge
do
	local super = Skill
	Charge = setmetatable({}, {
		__tostring = function()
			return "Charge"
		end,
		__index = super,
	})
	Charge.__index = Charge
	function Charge.new(...)
		local self = setmetatable({}, Charge)
		return self:constructor(...) or self
	end
	function Charge:constructor(...)
		super.constructor(self, ...)
	end
	function Charge:OnConstruct()
		Logger:Log(script, "- Construct")
	end
	function Charge:OnConstructServer()
		Logger:Log(script, " - Server")
		--this.DamageContainer = new DamageContainer(this, "Melee", 10);
	end
	function Charge:OnConstructClient()
		Logger:Log(script, "- Client")
	end
	function Charge:OnStartServer()
		Logger:Log(script, "Start Server")
	end
	function Charge:OnEndServer()
		Logger:Log(script, "End Server")
	end
	Charge = SkillDecorator(Charge) or Charge
end
return {
	Charge = Charge,
}
