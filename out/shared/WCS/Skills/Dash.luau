-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _wcs = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "wcs", "out")
local Skill = _wcs.Skill
local SkillDecorator = _wcs.SkillDecorator
local Message = _wcs.Message
local Stun = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "WCS", "StatusEffects", "Stun").Stun
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
	function Dash:updateCooldown()
		--Logger.Log`Cooldown updated. ${this.GetDebounceEndTimestamp()}`);
	end
	function Dash:OnStartServer()
		local stun = Stun.new(self.Character)
		self:ApplyCooldown(5)
		stun:Start(1)
		self:updateCooldown()
		-- Logger.Log(script,"Hi, dash just started!");
	end
	local _descriptor = Message({
		Type = "Event",
		Destination = "Client",
	})(Dash, "updateCooldown", {
		value = Dash.updateCooldown,
	})
	if _descriptor then
		Dash.updateCooldown = _descriptor.value
	end
	Dash = SkillDecorator(Dash) or Dash
end
return {
	Dash = Dash,
}
